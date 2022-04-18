import 'package:client/Screens/homepage.dart';
import 'package:flutter/material.dart';
import "Screens/homepage.dart";
import "Screens/saved.dart";
import "Screens/profile.dart";

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
  static String routeName = '/navigation';
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 1;

  final List<Widget> _widgetOptions = [SavedPage(), HomePage(), ProfilePage()];

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
