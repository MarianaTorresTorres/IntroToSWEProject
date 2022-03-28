const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const { UserInputError } = require("apollo-server");
const nodemailer = require("nodemailer");
const nodemailerSendgrid = require("nodemailer-sendgrid");

const { validateRegisterInput } = require("../../util/validators");
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

      const url = `https://localhost:5000/confirmation/${res.id}`;

      transport
        .sendMail({
          from: "mari.torret@gmail.com",
          to: res.email,
          subject: "edYou Confirmation Email",
          html:
            "Welcome to edYou, " +
            res.username +
            "! Please click on the link below to complete your registration\n\n" +
            "<a href=" + url + ">" + url + "<a/>",
        })
        .then(() => {
          console.log("Confirmation Email sent!");
        })
        .catch(() => {
          console.log("Ah shit, the email didn't send for some reason :(");
        });

      return {
        ...res._doc,
        id: res._id,
        token,
      };
    },
  },
};
