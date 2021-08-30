import 'package:flutter/material.dart';
import 'package:tb_e_health/screens/profile.dart';
import 'package:tb_e_health/screens/ques_ans.dart';
import 'package:tb_e_health/screens/home_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'chatbot/live_chat.dart';

class Navigations extends StatefulWidget {
  @override
  _NavigationsState createState() => _NavigationsState();
}

class _NavigationsState extends State<Navigations> {
  PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white,
      // Default is Colors.white.
      handleAndroidBackButtonPress: true,
      // Default is true.
      resizeToAvoidBottomInset: true,
      // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true,
      // Default is true.
      hideNavigationBarWhenKeyboardShows: true,
      // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
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
  }

  List<Widget> _buildScreens() {
    return [
      HomeScreen(),
      QnA(),
      LiveChat(),
      Profile(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
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
          Icons.question_answer_rounded,
          size: 30,
        ),
        title: ("Useful Information"),
        activeColorPrimary: Colors.black,
        inactiveColorPrimary: Colors.grey[400],
      ),
      PersistentBottomNavBarItem(
        icon: Icon(
          // Icons.chat, Icons.comment_rounded, Icons.contact_phone_outlined,
          Icons.child_care_sharp,
          size: 30,
        ),
        title: ("Live Chat"),
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
