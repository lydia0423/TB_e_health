import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tb_e_health/screens/daily_progress_board.dart';
import 'package:tb_e_health/screens/navigations.dart';
import 'package:tb_e_health/screens/teleconsultation/scheduler_screen.dart';
import 'package:tb_e_health/screens/teleconsultation/session_screen.dart';
import 'package:tb_e_health/services/auth_service.dart';
import 'package:tb_e_health/theme.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: "TB e-health",
        theme: helloTheme,
        //^ named Navigator routes
        initialRoute: "/home",
        routes: {
          "/home": (context) => Navigations(),
          "/scheduler": (context) => SchedulerScreen(),
          "/dailyProgress": (context) => DailyProgressBoardScreen(),
          "/teleSession": (context) => SessionScreen(),
        });

  }
}
