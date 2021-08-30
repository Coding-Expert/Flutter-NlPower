import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nlpower/pages/community.dart';
import 'package:nlpower/pages/daily.dart';
import 'package:nlpower/pages/dashboard_widget.dart';
import 'package:nlpower/pages/gym.dart';
import 'package:nlpower/pages/modules.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    DailyPage(),
    GymPage(),
    CommunityPage(),
    ModulesPage(),
    DashboardWidget()
  ];
  String title = "Daily Focus";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.only(bottom: Platform.isAndroid ? 0 : 90),
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12,
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
                icon:
                    new Image.asset('assets/daily.png', width: 32, height: 32),
                title: new Text('daily')),
            BottomNavigationBarItem(
                icon: new Image.asset('assets/gym.png', width: 32, height: 32),
                title: new Text('gym')),
            BottomNavigationBarItem(
                icon: new Image.asset('assets/chat.png', width: 32, height: 32),
                title: new Text('chat')),
            BottomNavigationBarItem(
                icon: new Image.asset('assets/exercise.png',
                    width: 32, height: 32),
                title: new Text('modules')),
            BottomNavigationBarItem(
                icon: new Image.asset('assets/profile.png',
                    width: 32, height: 32),
                title: new Text('dashboard')),
          ],
        ),
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      if (index == 0) {
        title = "Daily Focus";
      }
      if (index == 1) {
        title = "Gym";
      }
      if (index == 2) {
        title = "Community";
      }
      if (index == 3) {
        title = "Exercise";
      }
      if (index == 4) {
        title = "Dashboard";
      }
      _currentIndex = index;
    });
  }
}
