import 'dart:ffi';
import 'package:client/Screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

String username = "";
String email = "";
String password = "";
String confirmPassword = "";

List<String> userData = ["", "", "", ""];

class RegField extends StatelessWidget {
  final String title;
  final bool secret;
  final int index;

  const RegField(
      {required this.title,
      Key? key,
      required this.secret,
      required this.index})
      : super(key: key);
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
        obscureText: secret,
        enableSuggestions: !secret,
        autocorrect: false,
        onChanged: (value) => userData[index] = value.toString(),
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Mutation(
          options: MutationOptions(
            document: gql(registerUserGraphQL),
          ),
          builder: (RunMutation runMutation, QueryResult? result) {
            dynamic errs;
            if (result == null) {
              return const Text("result = null");
            }
            if (result.hasException) {
              if (result.hasException) {
                try {
                  String? errors = result
                      .exception?.graphqlErrors[0].extensions?.values.first
                      .toString();
                  errors = errors?.substring(1, errors.length - 1);
                  errs = errors?.split(",");
                } catch (e) {}
              }
            }

            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
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
                              const RegField(
                                  title: "Username", secret: false, index: 0),
                              const RegField(
                                  title: "Email", secret: false, index: 1),
                              const RegField(
                                  title: "Password", secret: true, index: 2),
                              const RegField(
                                  title: "Confirm Password",
                                  secret: true,
                                  index: 3),
                              const SizedBox(height: 50.0),
                              SizedBox(
                                  width: 200, // <-- Your width
                                  height: 50, // <-- Your height
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              HexColor("#A8C2EE")),
                                    ),
                                    child: const Text('SUBMIT',
                                        style: TextStyle(fontSize: 20)),
                                    onPressed: () {
                                      runMutation({
                                        "username": userData[0],
                                        "email": userData[1],
                                        "password": userData[2],
                                        "confirmPassword": userData[3],
                                      });
                                      if (!result.isLoading &&
                                          !result.hasException &&
                                          result.data != null) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const Welcome()),
                                        );
                                      }
                                    },
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
                            MaterialPageRoute(builder: (context) => Welcome()),
                          );
                        },
                        icon: Icon(Icons.arrow_back_ios),
                        color: Colors.white,
                        iconSize: 30,
                      ),
                    ),
                  ],
                ));
          },
        ));
  }
}

const registerUserGraphQL = """
  mutation (\$username: String!, \$email: String!, \$password: String!, \$confirmPassword: String!){
    register(registerInput: {
      username: \$username
      email: \$email
      password: \$password
      confirmPassword: \$confirmPassword
    }) {
      username
      password
      email
      id
    }
  }
""";
