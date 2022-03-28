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
};
