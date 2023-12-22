import 'package:flutter/material.dart';
import 'package:healthcare/screens/newhome.dart';
import 'package:healthcare/screens/messages_screen.dart';
import 'package:healthcare/screens/schedule_screen.dart';
import 'package:healthcare/screens/settings_screen.dart';

class WelcomePageWithNavBar extends StatefulWidget {
  @override
  _WelcomePageWithNavBarState createState() => _WelcomePageWithNavBarState();
}

class _WelcomePageWithNavBarState extends State<WelcomePageWithNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    MessagesScreen(),
    ScheduleScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}