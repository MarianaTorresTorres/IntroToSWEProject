import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'pages/register.dart';

void main() => runApp(const EdYou());

class EdYou extends StatelessWidget {
  const EdYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Application name
      title: 'edYou',
      // Application theme data, you can set the colors for the application as
      // you want
      theme: ThemeData(
        primaryColor: HexColor("#E5E5E5"),
        hintColor: Colors.black,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(secondary: HexColor("#A8C2EE")),
      ),
      // A widget which will be started on application startup
      home: const RegisterPage(),
    );
  }
}
