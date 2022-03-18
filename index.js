const { ApolloServer, gql } = require("apollo-server");
const {
  ApolloServerPluginLandingPageGraphQLPlayground,
} = require("apollo-server-core");

// The GraphQL schema
const typeDefs = gql`
  type User {
    username: String!
    email: String!
  }
  type Query {
    getUser: User!
  }
`;

// A map of functions which return data for the schema.
const resolvers = {
  Query: {
    getUser: () => {
      const user = {
        username: "user1",
        email: "user1@gmail.com",
      };
      return user;
    },
  },
};

const server = new ApolloServer({
  typeDefs,
  resolvers,
  plugins: [ApolloServerPluginLandingPageGraphQLPlayground()],
});

server.listen().then(({ url }) => {
  console.log(`🚀 Server ready at ${url}`);
});
