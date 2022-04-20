import 'package:client/Screens/homepage.dart';
import 'package:flutter/material.dart';
import "Screens/homepage.dart";
import "Screens/saved.dart";
import "Screens/profile.dart";
import 'package:graphql_flutter/graphql_flutter.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
  static String routeName = '/welcome';
}

Widget HomePageSetUp() {
  return Scaffold(
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
            final articleList = result.data?['getArticlesForUser'];
            print(articleList);
            return HomePage();
          }));
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 2;

  final List<Widget> _widgetOptions = [SavedPage(), HomePage(), ProfilePage()];
  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  dynamic user;

  void updateUser() {
    Query(
        options: QueryOptions(
          document: gql(getUserGraphQL),
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
          user = result.data?['getUser'];
          return Text(user.toString());
        });
  }

  @override
  Widget build(BuildContext context) {
    updateUser();
    return Scaffold(
      body: IndexedStack(children: [
        Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}

const getUserGraphQL = """
  query {
    getUser(userId: "6244aa90a9289e13d10be99c"){
      id
      username
      email
      password
      interests
      savedArticles {
        format
        topic
        author
        title
        url
        imageUrl
      }
    }
  }
""";

const getUserArticlesGraphQL = """
  query {
    getArticlesForUser(userId: "6244aa90a9289e13d10be99c"){
      format
      topic
      author
      title
      url
      imageUrl
    }
  }
""";
