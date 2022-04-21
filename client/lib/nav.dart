import 'package:client/Screens/homepage.dart';

import 'package:flutter/material.dart';
import "Screens/homepage.dart";
import "Screens/saved.dart";
import "Screens/profile.dart";
import 'package:graphql_flutter/graphql_flutter.dart';

class Navigation extends StatefulWidget {
  final dynamic userData;
  const Navigation({required this.userData});
  @override
  _NavigationState createState() => _NavigationState(userData: userData);
  static String routeName = '/welcome';
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 2;
  dynamic userData;
  _NavigationState({this.userData});
  //final List<Widget> _widgetOptions = [SavedPage(), HomePage(), ProfilePage()];
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
          child: _selectedIndex == 0
              ? SavedPage(userData: userData)
              : _selectedIndex == 1
                  ? HomePage(userData: userData)
                  : ProfilePage(user: userData),
          // _widgetOptions.elementAt(_selectedIndex),
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
