const { model, Schema } = require("mongoose");

const userSchema = new Schema({
  username: {
    type: String,
    required: true,
    lowercase: true,
    unique: true,
  },
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  createdAt: {
    type: String,
    required: true,
  },
  confirmed: {
    type: Boolean,
    default: false,
  },
  interests: [
    {
      type: String,
      unique: true,
      lowercase: true,
    },
  ],
  savedArticles: [
    {
      topic: String,
      format: String,
      title: String,
      author: String,
      url: String,
      imageUrl: String,
    },
  ],
});

module.exports = model("User", userSchema);
