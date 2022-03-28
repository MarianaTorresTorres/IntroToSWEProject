const Article = require("../../models/Article.js");

module.exports = {
  Query: {
    async getArticles() {
      try {
        const articles = await Article.find();
        return articles;
      } catch (err) {
        throw new Error(err);
      }
    },
    async getArticlesByTopic(_, { topic }) {
      try {
        const articles = await Article.find({
          topic: topic,
        });
        return articles;
      } catch (err) {
        throw new Error(err);
      }
    },
    async getArticlesByFormat(_, { format }) {
      try {
        const articles = await Article.find({
          format: format,
        });
        return articles;
      } catch (err) {
        throw new Error(err);
      }
    },
    async getArticlesByTopicAndFormat(_, { topic, format }) {
      try {
        const articles = await Article.find({
          topic: topic,
          format: format,
        });
        return articles;
      } catch (err) {
        throw new Error(err);
      }
    },
  },
  Mutation: {
    async createArticle(
      _,
      {
        createArticleInput: {
          topic,
          format,
          title,
          author,
          desc,
          url,
          imageUrl,
        },
      }
    ) {
      // idk if i need this since its not user input...
      /*const { valid, errors } = validateCreateArticleInput(
        topic,
        format,
        title,
        author,
        desc,
        url,
        imageUrl
      );

      if(!valid){
        throw new Error("Errors", {errors});
      }*/
      const newArticle = new Article({
        topic,
        format,
        title,
        author,
        desc,
        url,
        imageUrl,
      });

      await newArticle.save();

      return newArticle;
    },
    async deleteArticles() {
      try {
        await Article.deleteMany({});
        const articles = await Article.find();
        return articles;
      } catch (err) {
        throw new Error(err);
      }
    },
  },
};
