const usersResolvers = require("./users.js");
const articleResolvers = require("./Articles.js");

module.exports = {
  Query: {
    ...usersResolvers.Query,
    ...articleResolvers.Query,
  },
  Mutation: {
    ...usersResolvers.Mutation,
    ...articleResolvers.Mutation,
  },
};
