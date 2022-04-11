const { model, Schema } = require("mongoose");

const articleSchema = new Schema({
  topic: {
    type: String,
    required: true,
    lowercase: true,
  },
  format: {
    type: String,
    required: true,
    lowercase: true,
  },
  title: {
    type: String,
    required: true,
  },
  author: {
    type: String,
    required: true,
  },
  desc: {
    type: String,
    required: false,
  },
  url: {
    type: String,
    required: true,
  },
  imageUrl: {
    type: String,
    required: false,
  },
});

module.exports = model("Article", articleSchema);
