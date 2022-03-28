const usersResolvers = require("./users.js");
const articleResolvers = require("./Articles.js");

module.exports = {
  Query: {
    ...usersResolvers.Query,
    ...articleResolvers.Query,
  },
  Mutation: {
    ...articleResolvers.Mutation,
  },
<<<<<<< HEAD
=======
  Mutation: {
    ...usersResolvers.Mutation,
  },
>>>>>>> cf98e39f454949c27f3a4ec1e689d16ba0a713b3
};
