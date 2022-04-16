import 'package:client/nav.dart';
import 'package:client/routes.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() => runApp(const EdYou());

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
    );
  }
}
