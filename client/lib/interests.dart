import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class InterestsPage extends StatefulWidget {
  @override
  InterestsPageState createState() => InterestsPageState();
}

class InterestsPageState extends State<InterestsPage> {
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

  Widget buildRow(final topic) {
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
                    'interests': interests,
                  });
                });
              });
        });
  }

  @override
  Widget build(BuildContext context) {
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
  mutation (\$interests: [String]!){
    editUserProfile(editUserProfileInput: {
      username: "demouser"
      email: "mari.torret@gmail.com"
      password: "pZkwOeXC3CyIDgqGikUpGO5AdjONVO5Qjad03Bu4x7kVRiwoEpvu2"
      interests: \$interests
    }){
      username
      interests
    }
  }
""";
