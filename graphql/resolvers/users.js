const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");

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
  },
  Mutation: {
    async register(
      _,
      { registerInput: { username, email, password, confirmPassword } },
      context,
      info
    ) {
      //validate user data
      //Make sure user doesn't already exist
      //Hash password and create auth token
      password = await bcrypt.hash(password, 12);

      const newUser = new User({
        username,
        email,
        password,
        createdAt: new Date().toISOString(),
      });

      const res = await newUser.save();

      const token = jwt.sign({
        id: res.id,
        username: res.username,
        email: res.email,

      }, process.env.SECRET, { expiredIn: "24h"});

      return{
        ...res._doc,
        id: res._id,
        token
      }
    },
  },
};
