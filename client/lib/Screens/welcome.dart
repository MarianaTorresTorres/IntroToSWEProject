import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:client/Screens/register.dart';
import 'package:client/Screens/forget.dart';
import 'login.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return WelcomeBody();
  }
}

class WelcomeBody extends State<Welcome> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/welcome.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 500.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 0),
                      child: SizedBox(
                          width: 200, // <-- Your width
                          height: 50, // <-- Your height
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                                width: 3,
                              ),
                              primary: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                            ),
                            child: const Text('LOGIN',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()),
                              );
                            },
                          )),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const SizedBox(height: 600.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 0),
                      child: SizedBox(
                          width: 200, // <-- Your width
                          height: 50, // <-- Your height
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Colors.white,
                                width: 3,
                              ),
                              primary: Colors.white,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                            ),
                            child: const Text('SIGN UP',
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const RegisterPage()),
                              );
                            },
                          )),
                    )
                  ],
                ),
              ],
            )));
  }
}
