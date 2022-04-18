import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './../components/article.dart';

class SavedPage extends StatefulWidget {
  @override
  SavedPageState createState() => SavedPageState();
}

class SavedPageState extends State<SavedPage> {
  void openArticle() {}

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
            final articleList = result.data?['getArticles'];
            return Scaffold(
              body: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/background.jpeg'),
                        fit: BoxFit.fill)),
                child: ListView.builder(
                    itemCount: articleList.length,
                    itemBuilder: (context, index) {
                      return Article(article: articleList[index]);
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
      desc
      url
      imageUrl
    }
  }
""";

const getSavedArticlesGraphQL = """
  query {
    getArticles {
    }
  }
""";
