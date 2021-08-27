import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/screens/daily_progress_board.dart';
import 'package:tb_e_health/screens/login.dart';
import 'package:tb_e_health/screens/teleconsultation/session_screen.dart';
import 'package:tb_e_health/screens/wrapper.dart';

import 'screens/teleconsultation/scheduler_screen.dart';
import 'package:tb_e_health/screens/navigations.dart';
import 'package:tb_e_health/theme.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper(),
    );
  }
}
