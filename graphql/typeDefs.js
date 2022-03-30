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
  }
  input editUserProfileInput {
    username: String!
    email: String!
    password: String!
    createdAt: String!
    interests: [String]
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

  input RegisterInput {
    username: String!
    email: String!
    password: String!
    confirmPassword: String!
  }
  type Query {
    getUsers: [User]
    getUser(userId: ID!): User
    getArticles: [Article]
    getArticlesByTopic(topic: String): [Article]
    getArticlesByFormat(format: String): [Article]
    getArticlesByTopicAndFormat(topic: String, format: String): [Article]
    getArticlesForUser(userId: ID!): [Article]
  }

  type Mutation {
    createArticle(createArticleInput: createArticleInput): Article
    deleteArticles: [Article]
    editUserProfile(editUserProfileInput: editUserProfileInput): User!
    register(registerInput: RegisterInput): User!
    login(username: String!, password: String!): User!
  }
`;
