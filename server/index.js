const { ApolloServer, PubSub } = require("apollo-server");
const {
  ApolloServerPluginLandingPageGraphQLPlayground,
} = require("apollo-server-core");
const mongoose = require("mongoose");

require("dotenv").config();

const typeDefs = require("./graphql/typeDefs.js");
const resolvers = require("./graphql/resolvers");

const schedule = require("node-schedule");
const populate = require("./populateArticles.js");

// job is "0 */12 * * *"
const job = schedule.scheduleJob("0 */12 * * *", () => {
  console.log("populate");
  populate.populateDataBase();
});

const server = new ApolloServer({
  typeDefs,
  resolvers,
  plugins: [ApolloServerPluginLandingPageGraphQLPlayground()],
});

const port = process.env.PORT || 5000;

mongoose
  .connect(process.env.URI, {
    useNewUrlParser: true,
  })
  .then(() => {
    console.log("\nSUCCESS: CONNECTED TO DATABASE");
    return server.listen({ port: port });
  })
  .then((res) => {
    console.log(`SERVER RUNNING AT ${res.url}\n`);
  })
  .catch((err) => {
    console.error(err);
  });
