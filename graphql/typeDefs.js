const { gql } = require("apollo-server");

module.exports = gql`
  type User {
    id: ID!
    token: String!
    username: String!
    email: String!
    password: String!
    createdAt: String!
  }
  input RegisterInput {
    username: String!
    password: String!
    confirmPassword: String!
    email: String!
  }
  type Query {
    getUsers: [User]
    getUser(userId: ID!): User
  }
  type Mutation {
    register(registerInput: RegisterInput): User!
  }
`;
