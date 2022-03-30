const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const { UserInputError } = require("apollo-server");
const nodemailer = require("nodemailer");
const nodemailerSendgrid = require("nodemailer-sendgrid");

const { validateRegisterInput, validateLoginInput } = require("../../util/validators");
const User = require("../../models/User.js");

require("dotenv").config();

const transport = nodemailer.createTransport(
  nodemailerSendgrid({
    apiKey: process.env.SENDGRID_API_KEY,
  })
);

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
  },
  Mutation: {
    async editUserProfile(
      _, 
      { 
        editUserProfileInput: {
          username,
          email,
          passwords,
          createdAt,
          interests
        },
      }
      ) {
        try {
          const user = await User.find({ username });
          if (user) {
            const updatedUser = await User.findOneAndUpdate (
              { username },
              {
                username,
                email,
                passwords,
                createdAt,
                interests,
              },
              {
                new: true,
              }
            );

            return updatedUser;
          } else {
            throw new Error("User not found");
          }
        } catch (err) {
          throw new Error(err);
        }
    }
  },
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

      const url =
        "https://www.canva.com/design/DAE8TCHeOXk/EIA3TWq0-pgCjMsvbJP_Lw/view?website#4";

      transport
        .sendMail({
          from: "mari.torret@gmail.com",
          to: res.email,
          subject: "edYou Confirmation Email",
          html:
            "Welcome to edYou, " +
            res.username +
            "! Please click on the link below to complete your registration\n\n" +
            "<a href=" +
            url +
            ">" +
            url +
            "<a/>",
        })
        .then(() => {
          console.log("Confirmation Email sent!");
          res.confirmed = true;
        })
        .catch(() => {
          console.log("Oh no! The email didn't send for some reason :(");
        });

      return {
        ...res._doc,
        id: res._id,
        token,
      };
    },
    async login(_, { username, password }) {
      /*validate login input*/
      const { errors, valid } = validateLoginInput(username, password);
      if(!valid){
        throw new UserInputError("Errors" , { errors });
      }
      /*Check Credentials*/
      const user = await User.findOne({ username });
      if(!user){
        errors.general = 'User not found';
        throw new UserInputError("Wrong credentials" , { errors });
      }

      const passwordMatch = await bcrypt.compare(password, user.password);
      if(!passwordMatch){
        errors.general = 'Wrong credentials';
        throw new UserInputError("Wrong credentials" , { errors });
      }

      const token = jwt.sign(
        {
          id: user.id,
          username: user.username,
          email: user.email,
        },
        process.env.SECRET,
        { expiresIn: "24h" }
      );
      return {
        ...user._doc,
        id: user._id,
        token,
      }; 
    },
  },
};
