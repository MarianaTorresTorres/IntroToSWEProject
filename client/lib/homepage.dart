import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  void openArticle() {}
  var articleList = [];
  final savedArticles = Set<String>();

  Widget buildCard(final index) {
    final article = articleList[index];
    final alreadySaved = savedArticles.contains(article['title']);
    return Card(
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Ink.image(
            image: NetworkImage(
              article['imageUrl'],
            ),
            height: 240,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(16).copyWith(bottom: 0),
            child: Text(
              article['title'].trim(),
              style: const TextStyle(fontSize: 16),
            ),
          ),
          article['author'] != "N/A"
              ? Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.all(16).copyWith(bottom: 0, top: 4),
                    child: Text(
                      "By: " + article['author'].toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(0).copyWith(bottom: 0),
                ),
          ButtonBar(alignment: MainAxisAlignment.end, children: [
            IconButton(
              iconSize: 36,
              icon: const Icon(Icons.open_in_new),
              onPressed: () async {
                await launch(article['url']);
              },
            ),
            IconButton(
              iconSize: 36,
              icon: Icon(
                  alreadySaved
                      ? Icons.bookmark
                      : Icons.bookmark_border_outlined,
                  color: alreadySaved ? Colors.amber : null),
              onPressed: () {
                /*Mutation({
                  'format': article['format'],
                  'topic': article['topic'],
                  'author': article['author'],
                  'title': article['title'],
                  'url': article['url'],
                  'imageUrl': article['imageUrl'],
                  'saved': alreadySaved
                });*/
                setState(() {
                  if (alreadySaved) {
                    savedArticles.remove(article['title']);
                  } else {
                    savedArticles.add(article['title']);
                  }
                });
              },
            )
          ])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/home-page-bar.png'),
                  fit: BoxFit.fill)),
        ),
      ),
      body: Query(
          options: QueryOptions(
            document: gql(getUserArticlesGraphQL),
          ),
          builder: (QueryResult result, {fetchMore, refetch}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            articleList = result.data?['getArticles'];
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background.jpeg'),
                        fit: BoxFit.fill)),
                child: ListView.builder(
                    itemCount: articleList.length,
                    itemBuilder: (context, index) {
                      return buildCard(index);
                    }),
              ),
            );
          }),
    );
  }
}

const getUserArticlesGraphQL = """
  query {
    getArticles {
      format
      topic
      author
      title
      url
      imageUrl
    }
  }
""";

const adjustavedArticlesGraphQL = """
  mutation (\$topic: String!, \$format: String!, \$title: String!,
    \$author: String!, \$url: String!, \$imageUrl: String!, \$saved: Boolean){
    adjustSavedArticles(saveArticleInput:
    {
      username: "demouser"
      topic: \$topic
      format: \$format
      title: \$title
      author: \$author
      url: \$url
      imageUrl: \$imageUrl
      saved: \$saved
    })
  }{
    savedArticles{
      title
    }
  }
""";
