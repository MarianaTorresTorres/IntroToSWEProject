import 'package:client/Screens/welcome.dart';
import 'package:flutter/material.dart';
import 'package:client/buttons.dart';
import 'interests.dart';

class ProfilePage extends StatefulWidget {
  final dynamic user;
  const ProfilePage({required this.user});
  @override
  _ProfilePageState createState() => _ProfilePageState(user: user);
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 200;
  final double profileHeight = 120;
  final dynamic user;
  _ProfilePageState({this.user});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
          const SizedBox(height: 80),
          Center(child: buildEditInterestButtons()),
          const SizedBox(height: 80),
          Center(child: buildLogoutButtons()),
        ],
      ),
    );
  }

  Widget buildTop() {
    final top = coverHeight - profileHeight / 2;
    final bottom = profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        ),
      ],
    );
  }

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 10),
          Text(
            user['username'].toString(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            user['email'].toString(),
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      );

  Widget buildEditInterestButtons() => ButtonWidget(
        text: '   Edit Interest   ',
        onClicked: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return InterestsPage(
              userData: user,
            );
          }));
        },
      );

  Widget buildLogoutButtons() => ButtonWidget(
        text: ' Logout ',
        onClicked: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return Welcome();
          }));
        },
      );

  Widget buildCoverImage() => Container(
        color: Colors.purple,
        child: Image.asset(
          'assets/background.jpeg',
          width: double.infinity,
          height: coverHeight,
          fit: BoxFit.cover,
        ),
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: const AssetImage('assets/user_default.png'),
      );
}
