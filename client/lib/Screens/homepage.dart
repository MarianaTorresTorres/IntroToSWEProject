import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  final dynamic userData;
  const HomePage({required this.userData});
  @override
  HomePageState createState() => HomePageState(user: userData);
}

class HomePageState extends State<HomePage> {
  dynamic user;
  HomePageState({this.user});

  var articleList = [];
  final savedArticles = Set<String>();

  Widget buildCard(final index) {
    final article = articleList[index];
    if (article == null) return Text("");
    final alreadySaved = savedArticles.contains(article['title']);
    return Card(
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Mutation(
        options: MutationOptions(
          document: gql(adjustavedArticlesGraphQL),
          onCompleted: (dynamic resultData) {
            print(resultData);
          },
        ),
        builder: (
          RunMutation runMutation,
          QueryResult? result,
        ) {
          if (result == null) {
            return const Text("result = null");
          }
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
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
                        padding: const EdgeInsets.all(16)
                            .copyWith(bottom: 0, top: 4),
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
                    setState(() {
                      if (alreadySaved) {
                        savedArticles.remove(article['title']);
                      } else {
                        savedArticles.add(article['title']);
                      }
                    });
                    runMutation({
                      'username': user['username'],
                      'topic': article['topic'],
                      'format': article['format'],
                      'title': article['title'],
                      'author': article['author'],
                      'url': article['url'],
                      'imageUrl': article['imageUrl'],
                      'saved': alreadySaved,
                    });
                    //user = result.data?['user'];
                  },
                )
              ])
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return Text(user["id"].toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
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
            variables: {
              'userId': user["id"],
            },
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            articleList = result.data?['getArticlesForUser'];
            return Scaffold(
                body: RefreshIndicator(
                    child: Container(
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
                    onRefresh: () {
                      return Future.delayed(
                        Duration(seconds: 1),
                        () {
                          setState() {
                            articleList.clear();
                            fetchMore!(FetchMoreOptions(updateQuery:
                                (previousResultData, fetchMoreResultData) {
                              articleList =
                                  fetchMoreResultData?['getArticlesForUser'];
                            }));
                          }
                        },
                      );
                    }));
          }),
    );
  }
}

const getUserArticlesGraphQL = """
  query (\$userId: ID!){
    getArticlesForUser(userId: \$userId){
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
  mutation (\$username: String!, \$format: String!, \$topic: String!, \$title: String!, \$author: String!, \$url: String!, \$imageUrl: String!, \$saved: Boolean!){
    adjustSavedArticles(saveArticleInput: {
      username: \$username
      topic: \$topic
      format: \$format
      title: \$title
      author: \$author
      url: \$url
      imageUrl: \$imageUrl
      saved: \$saved
    }){
      username
      password
      email
      id
      interests
      savedArticles{
        title
        }
      }
    }
""";
