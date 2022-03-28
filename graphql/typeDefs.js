const { gql } = require("apollo-server");

module.exports = gql`
  type User {
    username: String!
    email: String!
    password: String!
    createdAt: String!
  }
  type Query {
    getUsers: [User]
    getUser(userId: ID!): User
  }
  type Mutation{
    login(username: String!, password: String!): User!
  }
`;
