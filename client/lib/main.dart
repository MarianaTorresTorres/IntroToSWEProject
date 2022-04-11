import 'package:flutter/material.dart';

void main() => runApp(EdYouApp());

class EdYouApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primaryColor: Color.fromARGB(255, 92, 35, 199)),
        home: Scaffold(
            appBar: AppBar(title: Text("Home")),
            body: Center(
              child: Text("Hello World"),
            )));
  }
}
