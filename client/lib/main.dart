import 'package:client/nav.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() {
  final HttpLink httpLink = HttpLink("http://localhost:5000/");

  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  ));

  var app = GraphQLProvider(client: client, child: EdYouApp());

  runApp(app);
}

class EdYouApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 92, 35, 199)),
      debugShowCheckedModeBanner: false,
      title: 'Profile Page',
      //theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: Navigation.routeName,
      routes: routes,
    );
  }
}
