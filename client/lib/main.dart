import 'package:client/Screens/forget.dart';
import 'package:client/Screens/register.dart';
import 'package:client/Screens/welcome.dart';
import 'package:client/Screens/login.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() => runApp(EdYouApp());

class EdYouApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      title: 'edYou',
      theme: ThemeData(
        primaryColor: HexColor("#E5E5E5"),
        hintColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(secondary: HexColor("#A8C2EE")),
      ),
      home: const Welcome(),
    );
  }
}
