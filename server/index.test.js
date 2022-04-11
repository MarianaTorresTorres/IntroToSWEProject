const typeDefs = require("./graphql/typeDefs.js");
const resolvers = require("./graphql/resolvers/");
const { ApolloServer } = require("apollo-server");

/*jest.setTimeout(30000);

test("creates a user called testUser", async () => {
  const testServer = new ApolloServer({
    typeDefs,
    resolvers,
  });

  const result = await testServer.executeOperation({
    query: "query ($id: ID!) {getUser(userId: $id) {username email}}",
    variables: { id: "62421d6d0904c988ec53ced3" },
  });

  expect(result.errors).toBeUndefined();
  expect(result.data.username).toBe("userone");
  expect(result.data.email).toBe("fpakmwocinzmmdijuc@kvhrr.com");
});*/

/*const result = await testServer.executeOperation({
    query: `mutation {
        createArticle (createArticleInput: {
        topic: "test topic"
        format: "article"
        title: "test title"
        author: "test author"
        desc: "test description"
        url: "www.test.url.com"
        imageUrl: "www.test.url.image.com"
      }){
        topic
        format
        title
      }
    }`,
  });*/
