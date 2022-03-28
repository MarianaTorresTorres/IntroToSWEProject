const Article = require("../../models/Article.js");
const User = require("../../models/User.js");

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
    async getArticlesForUser(_, { userID }) {
      try {
        const user = User.findById(userID);
        if (user) {
          var articles = [];
          let count = 50 / user.interests.length;
          for (var interest in user.interests) {
            const articlesOfTopic = Article.find({
              topic: sinterest,
              format: "article",
            });
            const videosOfTopic = Article.find({
              topic: interest,
              format: "video",
            });

            for (let i = 0; i < count; i++) {
              articles.push(
                articlesOfTopic[
                  Math.floor(Math.random() * articlesOfTopic.length)
                ]
              );
              articles.push(
                videosOfTopic[Math.floor(Math.random() * videosOfTopic.length)]
              );
            }
          }
          return articles;
        } else {
          throw new Error("User doesn't exist");
        }
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
