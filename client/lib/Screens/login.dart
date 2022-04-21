import 'package:client/Screens/register.dart';
import 'package:client/Screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:client/Screens/forget.dart';
import 'package:client/nav.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

List<String> userInput = ["", ""];

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
        onChanged: (value) => userInput[index] = value,
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginBody();
  }
}

class LoginBody extends State<Login> {
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
            document: gql(loginUserGraphQL),
          ),
          builder: (RunMutation runMutation, QueryResult? result) {
            dynamic errs;
            if (result == null) {
              return const Text("result = null");
            }
            if (result.hasException) {
              try {
                String? errors = result
                    .exception?.graphqlErrors[0].extensions?.values.first
                    .toString();
                errors = errors?.substring(1, errors.length - 1);
                errs = errors?.split(",");
              } catch (e) {}
            }
            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!result.isLoading &&
                !result.hasException &&
                result.data != null) {
              dynamic user = result.data?['login'];
              return Navigation(
                userData: user,
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
                                  title: "Password", secret: true, index: 1),
                              const SizedBox(height: 100.0),
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
                                        "username": userInput[0],
                                        "password": userInput[1],
                                      });
                                    },
                                  )),
                              result.hasException
                                  ? AlertDialog(
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(32.0))),
                                      title: Text(errs.toString().substring(
                                          1, errs.toString().length - 1)),
                                    )
                                  : const Text(""),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 440,
                      right: 20,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Forget()),
                            );
                          },
                          child: const Text(
                            "Forgot Password?",
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    Positioned(
                      top: 20,
                      left: 0,
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Welcome()),
                          );
                        },
                        icon: const Icon(Icons.arrow_back_ios),
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

const loginUserGraphQL = """
  mutation (\$username: String!, \$password: String!){
    login(
      username: \$username
      password: \$password
    ){
      username
      password
      email
      id
      interests
      savedArticles{
        format
        topic
        author
        title
        url
        imageUrl
      }
    }
  }
""";
