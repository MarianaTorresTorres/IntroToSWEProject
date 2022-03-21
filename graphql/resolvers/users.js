const User = require("../../models/User.js");

module.exports = {
  Query: {
    async getUsers() {
      try {
        const users = await User.find().sort({
          username: 1
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
};
