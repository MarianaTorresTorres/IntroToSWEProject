const { gql } = require("apollo-server");

module.exports = gql`
  type User {
    id: ID!
    token: String!
    username: String!
    email: String!
    password: String!
    createdAt: String!
    interests: [String]
    savedArticles: [Article]
  }

  type Article {
    topic: String!
    format: String!
    title: String!
    author: String!
    url: String!
    imageUrl: String
    saved: Boolean!
  }

  input RegisterInput {
    username: String!
    email: String!
    password: String!
    confirmPassword: String!
  }

  input editUserProfileInput {
    username: String!
    email: String!
    password: String!
    interests: [String]
  }

  input createArticleInput {
    topic: String!
    format: String!
    title: String!
    author: String!
    url: String!
    imageUrl: String
  }

  input saveArticleInput {
    username: String!
    topic: String!
    format: String!
    title: String!
    author: String!
    url: String!
    imageUrl: String
    saved: Boolean!
  }

  type Query {
    getUsers: [User]
    getUser(userId: ID!): User
    getArticles: [Article]
    getArticlesByTopic(topic: String): [Article]
    getArticlesByFormat(format: String): [Article]
    getArticlesByTopicAndFormat(topic: String, format: String): [Article]
    getArticlesForUser(userId: ID!): [Article]
    getSavedArticles: [Article]
  }

  type Mutation {
    register(registerInput: RegisterInput): User!
    login(username: String!, password: String!): User!
    editUserProfile(editUserProfileInput: editUserProfileInput): User!
    adjustSavedArticles(saveArticleInput: saveArticleInput): User!
    createArticle(createArticleInput: createArticleInput): Article
    deleteArticles: [Article]
  }
`;
