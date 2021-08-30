import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tb_e_health/models/anonymous_user.dart';
import 'package:tb_e_health/screens/authenticate/authenticate.dart';
import 'package:tb_e_health/screens/home/home.dart';
import 'package:tb_e_health/services/alarm_service.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AnonymousUser?>(context);
    // listen to changes, return home or authenticate widget
    if (user == null) {
      print('Widget -> Authenticate: ');
      // open this to create dummy user record...
      return Authenticate();
    } else {
      print('Widget -> Home: ' + user.uid);
      AlarmService.initAlarm();
      return Home();
    }
  }
}
