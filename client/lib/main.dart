import 'package:client/Screens/register.dart';
import 'package:client/nav.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'Screens/welcome.dart';

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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromARGB(255, 92, 35, 199)),
      title: 'edYou',
      //theme: ThemeData(fontFamily: 'Poppins'),
      home: const Welcome(),
      routes: routes,
    );
  }
}
