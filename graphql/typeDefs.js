const { gql } = require("apollo-server");
const users = require("./resolvers/users");

module.exports = gql`
  type User {
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
  type Query {
    getUsers: [User]
    getUser(userId: ID!): User
  }
  type Mutation {
    editUserProfile(editUserProfileInput: editUserProfileInput): User! 
  }
`;

