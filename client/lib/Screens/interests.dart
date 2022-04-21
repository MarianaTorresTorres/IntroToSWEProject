import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InterestsPage extends StatefulWidget {
  final dynamic userData;
  const InterestsPage({required this.userData});
  @override
  InterestsPageState createState() => InterestsPageState(user: userData);
}

class InterestsPageState extends State<InterestsPage> {
  dynamic user;
  InterestsPageState({this.user});
  bool setInterest = true;
  final selectedInterests = Set<String>();

  Map<String, String> allInterests = {
    "Economics": "economics",
    "Renewable Energy": "renewableenergy",
    "Technology": "technology",
    "Art": "artistry",
    "Literature": "literature",
    "Politics": "politics",
    "Religion": "religion"
  };

  Widget buildRow(final String topic) {
    final alreadySaved = selectedInterests.contains(allInterests[topic]);
    return Mutation(
        options: MutationOptions(
          document: gql(editUserInterestsGraphQL),
        ),
        builder: (
          RunMutation runMutation,
          QueryResult? result,
        ) {
          return ListTile(
              title: Text(topic, style: TextStyle(fontSize: 18.0)),
              trailing: Icon(
                  alreadySaved ? Icons.star : Icons.star_border_outlined,
                  color: alreadySaved ? Colors.amber : null),
              onTap: () {
                setState(() {
                  if (alreadySaved) {
                    selectedInterests.remove(allInterests[topic]);
                  } else {
                    selectedInterests.add(allInterests[topic].toString());
                  }
                  final interests = [];
                  interests.addAll(selectedInterests);
                  runMutation({
                    'username': user['username'],
                    'email': user['email'],
                    'password': user['password'],
                    'interests': interests,
                  });
                });
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    if (setInterest) {
      String interests = user['interests'].toString();
      List<String> userInterests =
          interests.substring(1, interests.length - 1).split(', ');
      selectedInterests.addAll(userInterests);
      setInterest = false;
    }
    final interestsArr = [];
    interestsArr.addAll(allInterests.keys);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Interests"),
          backgroundColor: Colors.transparent,
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/editInterests.png'),
                    fit: BoxFit.fill)),
          ),
        ),
        body: Mutation(
          options: MutationOptions(
            document: gql(editUserInterestsGraphQL),
          ),
          builder: (RunMutation runMutation, QueryResult? result) {
            if (result == null) {
              return const Text("result = null");
            }
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: interestsArr.length,
                itemBuilder: (context, index) {
                  return buildRow(interestsArr[index]);
                });
          },
        ));
  }
}

const editUserInterestsGraphQL = """
  mutation (\$username: String!, \$email: String!, \$password: String!, \$interests: [String]!){
    editUserProfile(editUserProfileInput: {
      username: \$username
      email: \$email
      password: \$password
      interests: \$interests
    }){
      username
      interests
    }
  }
""";
