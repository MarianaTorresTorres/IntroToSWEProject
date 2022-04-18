import 'package:client/nav.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() => runApp(EdYouApp());

class EdYouApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(primaryColor: Color.fromARGB(255, 92, 35, 199)),
      //home: Scaffold(
      //    appBar: AppBar(title: Text("Home")),
      //    body: Center(
      //      child: Text("Hello!!"),
      //    ))
      //title: 'Navigation',
      //home: Navigation(),
      title: 'Profile Page',
      //theme: ThemeData(fontFamily: 'Poppins'),
      initialRoute: Navigation.routeName,
      routes: routes,
    );
  }
}
