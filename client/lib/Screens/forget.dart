import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:client/Screens/login.dart';

class RegField extends StatelessWidget {
  final String title;

  const RegField({required this.title, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: TextFormField(
        decoration: InputDecoration(
            labelText: title,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              //  when the TextFormField in unfocused
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
              //  when the TextFormField in focused
            ),
            border: const UnderlineInputBorder()),
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

class Forget extends StatefulWidget {
  const Forget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ForgetBody();
  }
}

class ForgetBody extends State<Forget> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/back.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.all(40.0),
                        height: (MediaQuery.of(context).size.height) / 5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/logo.png"),
                            fit: BoxFit.contain,
                          ),
                        )),
                    const SizedBox(height: 100.0),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const RegField(title: "Username"),
                          const RegField(title: "Email"),
                          const SizedBox(height: 100.0),
                          SizedBox(
                              width: 200, // <-- Your width
                              height: 50, // <-- Your height
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50.0),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      HexColor("#A8C2EE")),
                                ),
                                child: const Text('RESET',
                                    style: TextStyle(fontSize: 20)),
                                onPressed: () {},
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    icon: Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    iconSize: 30,
                  ),
                ),
              ],
            )));
  }
}
