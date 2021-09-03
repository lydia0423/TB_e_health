import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tb_e_health/models/anonymous_user.dart';
import 'package:tb_e_health/screens/wrapper.dart';
import 'package:tb_e_health/services/auth_service.dart';
import 'package:tb_e_health/screens/shared/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  await Firebase.initializeApp();

  bool kReleaseMode = false;

  runApp(DevicePreview(
    enabled: kReleaseMode,
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AnonymousUser?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: helloTheme(context),
        home: Wrapper(),
      ),
    );
  }
}
