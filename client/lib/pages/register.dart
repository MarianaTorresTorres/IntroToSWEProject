import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/back.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.all(40.0),
              height: (MediaQuery.of(context).size.height) / 5,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/logo.png"),
                  fit: BoxFit.contain,
                ),
              )),
          const SizedBox(height: 100.0),
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Username',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder()),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder()),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder()),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          //  when the TextFormField in unfocused
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder()),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 50.0),
                SizedBox(
                    width: 200, // <-- Your width
                    height: 50, // <-- Your height
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(HexColor("#A8C2EE")),
                      ),
                      child:
                          const Text('SUBMIT', style: TextStyle(fontSize: 20)),
                      onPressed: () {},
                    )),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
