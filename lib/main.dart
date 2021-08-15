// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/Screens/home_screen.dart';
import 'package:tb_e_health/Screens/login.dart';

main() async {
  //~ initialises firebase instances for authentication and Cloud FireStore
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseAuth.instance;
  //~ Redirects users
  String myRoute = "/";
  //~ Run application
  runApp(MyApp(myRoute));
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
        debugShowCheckedModeBanner: false,
        title: "TB e-health",
        theme: ThemeData.light(),
        //^ named Navigator routes
        initialRoute: widget.myRoute,
        routes: {
          "/": (context) => Login(),
          "/home": (context) => HomeScreen(),
        });
  }
}
