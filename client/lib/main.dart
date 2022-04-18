import 'package:client/components/nav.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'pages/register.dart';

void main() {
  final HttpLink httpLink = HttpLink("http://localhost:5000/");

  ValueNotifier<GraphQLClient> client = ValueNotifier(GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(store: InMemoryStore()),
  ));

  var app = GraphQLProvider(client: client, child: const EdYou());

  runApp(app);
}

class EdYou extends StatelessWidget {
  const EdYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'edYou',
      theme: ThemeData(
        primaryColor: HexColor("#E5E5E5"),
        hintColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(secondary: HexColor("#A8C2EE")),
      ),
      initialRoute: Navigation.routeName,
      routes: routes,
      //home: const RegisterPage(),
    );
  }
}
