import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class NotificationLocal extends StatefulWidget {
  @override
  _NotificationLocalState createState() => _NotificationLocalState();
}

class _NotificationLocalState extends State<NotificationLocal> {
  // TODO : call notification
  @override
  void initState() {
    initializeSetting();
    tz.initializeTimeZones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              size: 30,
              color: Colors.blue,
            ),
            onPressed: () {
              displayNotification('test notification');
            },
          ),
          ElevatedButton(
              onPressed: () {
                print('back to wrapper');
              },
              child: Text('OK')),
        ],
      ),
    );
  }

  Future<void> displayNotification(String title) async {
    flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        'Message content',
        tz.TZDateTime.now(tz.local).add(
          Duration(seconds: 2),
        ),
        NotificationDetails(
            android: AndroidNotificationDetails(
                'chn id', 'chn name', 'chn description')),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

  void initializeSetting() async {
    var androidInitialize =
        new AndroidInitializationSettings('ic_stat_add_comment');
    var initializationsSettings =
        new InitializationSettings(android: androidInitialize);
    flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }
}
