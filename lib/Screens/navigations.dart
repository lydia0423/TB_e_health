import 'package:flutter/material.dart';
import 'package:tb_e_health/Screens/profile.dart';
import 'package:tb_e_health/Screens/ques_ans.dart';

import 'home_screen.dart';

class Navigations extends StatefulWidget {
  @override
  _NavigationsState createState() => _NavigationsState();
}

class _NavigationsState extends State<Navigations> {
  int _currentIndex = 1;

  final List<Widget> _pages = [QnA(), HomeScreen(), Profile()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5)
              ]),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            child: BottomNavigationBar(
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.grey[400],
              onTap: onTabTapped,
              currentIndex: _currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.question_answer_rounded,
                      size: 42,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 42,
                    ),
                    label: ''),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                      size: 42,
                    ),
                    label: '')
              ],
            ),
          ),
        ));
  }
}
