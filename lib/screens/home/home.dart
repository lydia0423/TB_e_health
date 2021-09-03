import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tb_e_health/screens/profile/daily_progress_board.dart';
import 'package:tb_e_health/screens/navigation_bar/navigations.dart';
import 'package:tb_e_health/screens/teleconsultation/scheduler_screen.dart';
import 'package:tb_e_health/screens/shared/theme.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: "TB e-health",
        theme: helloTheme(context),
        //^ named Navigator routes
        initialRoute: "/home",
        routes: {
          "/home": (context) => Navigations(),
          "/scheduler": (context) => SchedulerScreen(),
          "/dailyProgress": (context) => DailyProgressBoardScreen(),
        });

  }
}
