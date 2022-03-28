const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const { UserInputError } = require("apollo-server");

const { validateRegisterInput } = require("../../util/validators");
const User = require("../../models/User.js");

require("dotenv").config();

module.exports = {
  Query: {
    async getUsers() {
      try {
        const users = await User.find().sort({
          username: 1,
        });
        return users;
      } catch (err) {
        throw new Error(err);
      }
    },
    async getUser(_, { userId }) {
      try {
        const user = await User.findById(userId);
        if (user) {
          return user;
        } else {
          throw new Error("User not found");
        }
      } catch (err) {
        throw new Error(err);
      }
    },
    async login(_, {username, password}) {
      try {
          if(username.trim() === '')
              throw new Error("Username must not be empty");
          if(password === '')
              throw new Error("Password must not be empty");
          
          const user = await User.findOne({username});
          if(!user){
              throw new Error("User not found");
          }
          const passwordMatch = await bcrypt.compare(password, user.password);
          if(!passwordMatch){
              throw new Error("Incorrect password");
          }
          const token = jwt.sign({username},
              'my-secret-from-env-file-in-prod', {expiresIn: '1d'});

          return{ user.toJSON(),
          createdAt: user.createdAt.toISOString(),
          token,
          }
      
      } catch (err) {
          throw new Error(err);
      }
    },
  },
  Mutation: {
    async register(
      _,
      { registerInput: { username, email, password, confirmPassword } }
    ) {
      /*validate user data*/
      const { valid, errors } = validateRegisterInput(
        username,
        email,
        password,
        confirmPassword
      );
      if (!valid) {
        throw new UserInputError("Errors", { errors });
      }
      /*Make sure user doesn't already exist*/
      const user = await User.findOne({ username });
      if (user) {
        throw new UserInputError("Username is taken", {
          errors: {
            username: "This username is taken",
          },
        });
      }
      /*Hash password and create auth token*/
      password = await bcrypt.hash(password, 12);

      const newUser = new User({
        username,
        email,
        password,
        createdAt: new Date().toISOString(),
      });

      const res = await newUser.save();

      const token = jwt.sign(
        {
          id: res.id,
          username: res.username,
          email: res.email,
        },
        process.env.SECRET,
        { expiresIn: "24h" }
      );

      return {
        ...res._doc,
        id: res._id,
        token,
      };
    },
  },
};
