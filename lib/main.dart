import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tb_e_health/models/anonymous_user.dart';
import 'package:tb_e_health/screens/daily_progress_board.dart';
import 'package:tb_e_health/screens/login.dart';
import 'package:tb_e_health/screens/teleconsultation/session_screen.dart';
import 'package:tb_e_health/screens/wrapper.dart';
import 'package:tb_e_health/services/auth_service.dart';

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
    return StreamProvider<AnonymousUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
