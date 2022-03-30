const { gql } = require("apollo-server");
const users = require("./resolvers/users");

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
  input RegisterInput {
    username: String!
    email: String!
    password: String!
    confirmPassword: String!
  }
  type Query {
    getUsers: [User]
    getUser(userId: ID!): User
  }
  type Mutation {
    editUserProfile(editUserProfileInput: editUserProfileInput): User! 
    register(registerInput: RegisterInput): User!
    login(username: String!, password: String!): User!
  }
`;

