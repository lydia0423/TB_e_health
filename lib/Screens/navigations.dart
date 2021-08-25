import 'package:flutter/material.dart';
import 'package:tb_e_health/Screens/profile.dart';
import 'package:tb_e_health/Screens/ques_ans.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'home_screen.dart';

class Navigations extends StatefulWidget {
  @override
  _NavigationsState createState() => _NavigationsState();
}

class _NavigationsState extends State<Navigations> {
  // int _currentIndex = 1;

  // final List<Widget> _pages = [QnA(), HomeScreen(), Profile()];
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 1);

  // void onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      navBarStyle:
          NavBarStyle.style6, // Choose the nav bar style with this property.
    );
    // return Scaffold(
    //     body: _pages[_currentIndex],
    //     bottomNavigationBar: Container(
    //       height: MediaQuery.of(context).size.height / 11.0,
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.only(
    //             topLeft: Radius.circular(25),
    //             topRight: Radius.circular(25),
    //           ),
    //           boxShadow: [
    //             BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5)
    //           ]),
    //       child: ClipRRect(
    //         borderRadius: BorderRadius.only(
    //           topLeft: Radius.circular(25),
    //           topRight: Radius.circular(25),
    //         ),
    //         child: BottomNavigationBar(
    //           selectedItemColor: Colors.black,
    //           unselectedItemColor: Colors.grey[400],
    //           onTap: onTabTapped,
    //           currentIndex: _currentIndex,
    //           items: [
    //             BottomNavigationBarItem(
    //                 icon: Padding(
    //                   padding: const EdgeInsets.only(top: 10.0),
    //                   child: Icon(
    //                     Icons.question_answer_rounded,
    //                     size: 30,
    //                   ),
    //                 ),
    //                 label: 'TB Info'),
    //             BottomNavigationBarItem(
    //                 icon: Padding(
    //                   padding: const EdgeInsets.only(top: 10.0),
    //                   child: Icon(
    //                     Icons.home,
    //                     size: 30,
    //                   ),
    //                 ),
    //                 label: 'Home'),
    //             BottomNavigationBarItem(
    //                 icon: Padding(
    //                   padding: const EdgeInsets.only(top: 10.0),
    //                   child: Icon(
    //                     Icons.person,
    //                     size: 30,
    //                   ),
    //                 ),
    //                 label: 'Profile')
    //           ],
    //         ),
    //       ),
    //     ));
  }

  List<Widget> _buildScreens() {
    return [
      QnA(),
      HomeScreen(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.question_answer_rounded,
          size: 30,
        ),
        title: ("TB Info"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey[400],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.home,
          size: 30,
        ),
        title: ("Home"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey[400],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          Icons.person,
          size: 30,
        ),
        title: ("Profile"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey[400],
      ),
    ];
  }
}
