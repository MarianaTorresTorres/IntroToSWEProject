import 'package:flutter/material.dart';
import 'package:client/components/buttons.dart';
import './../pages/saved.dart';

class Navigation extends StatefulWidget {
  Navigation({Key? key}) : super(key: key);

  @override
  _NavigationState createState() => _NavigationState();
  static String routeName = '/navigation';
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = [SavedPage(), Home(), Profile()];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: [
        Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      child: const Center(
        child: Text('Home'),
      ),
    );
  }
}

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final double coverHeight = 200;
  final double profileHeight = 120;
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
        children: const [
          SizedBox(height: 10),
          Text(
            'Yair Temkin',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            'yairrrrrrrrrr@gmail.com',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      );

  Widget buildEditInterestButtons() => ButtonWidget(
        text: '   Edit Interest   ',
        onClicked: () {},
      );

  Widget buildLogoutButtons() => ButtonWidget(
        text: ' Logout ',
        onClicked: () {},
      );

  Widget buildCoverImage() => Container(
        color: Colors.purple,
        child: Image.asset(
          'assets/shortBack.jpeg',
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
