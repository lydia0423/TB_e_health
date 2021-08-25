import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/Screens/daily_progress_board.dart';
import 'package:tb_e_health/Screens/login.dart';
import 'package:tb_e_health/Screens/teleconsultation/session_screen.dart';

import 'Screens/teleconsultation/scheduler_screen.dart';
import 'package:tb_e_health/Screens/navigations.dart';
import 'package:tb_e_health/theme.dart';

main() async {
  bool kReleaseMode = false;
  //~ initialises firebase instances for authentication and Cloud FireStore
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance;
  //~ Redirects users
  String myRoute = await checkLoggedIn();
  //~ Run application
  runApp(DevicePreview(
    enabled: kReleaseMode,
    builder: (context) => MyApp(myRoute),
  ));
}

class MyApp extends StatefulWidget {
  final String myRoute;
  MyApp(this.myRoute);
  @override
  _MyAppState createState() => _MyAppState();
}

//Get the state of dark mode or light mode and update it
class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: "TB e-health",
        theme: helloTheme,
        //^ named Navigator routes
        initialRoute: widget.myRoute,
        routes: {
          "/": (context) => Login(),
          "/home": (context) => Navigations(),
          "/scheduler": (context) => SchedulerScreen(),
          "/dailyProgress": (context) => DailyProgressBoardScreen(),
          "/teleSession": (context) => SessionScreen(),
        });
  }
}

Future<String> checkLoggedIn() async {
  String myRoute = "/home";
  try {
    User? currentUserId = FirebaseAuth.instance.currentUser;
    if (currentUserId == null) {
      myRoute = "/";
    } else {
      await FirebaseFirestore.instance
          .collection("User")
          .doc(currentUserId.uid)
          .get();

      myRoute = "/home";
    }
  } catch (e) {
    print("$e: User is not logged in");
  }
  return myRoute;
}
