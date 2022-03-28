const User = require("../../models/User.js");
//const loginResolver = require("./login.js");
const usersResolvers = require("./users.js");

module.exports = {
  Query: {
    ...usersResolvers.Query,
  },
  Mutation: {
    ...usersResolvers.Mutation,
  },
};
