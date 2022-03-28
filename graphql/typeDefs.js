const { gql } = require("apollo-server");

module.exports = gql`
  type User {
    username: String!
    email: String!
    password: String!
    createdAt: String!
  }

  type Article {
    topic: String!
    format: String!
    title: String!
    author: String!
    desc: String!
    url: String!
    imageUrl: String
  }

  input createArticleInput {
    topic: String!
    format: String!
    title: String!
    author: String!
    desc: String
    url: String!
    imageUrl: String
  }

  type Query {
    getUsers: [User]
    getUser(userId: ID!): User
    getArticles: [Article]
    getArticlesByTopic(topic: String): [Article]
    getArticlesByFormat(format: String): [Article]
    getArticlesByTopicAndFormat(topic: String, format: String): [Article]
  }

  type Mutation {
    createArticle(createArticleInput: createArticleInput): Article
    deleteArticles: [Article]
  }
`;
