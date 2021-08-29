import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalAlert {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initializeSetting() async {
    tz.initializeTimeZones();
    var androidInitialize =
        new AndroidInitializationSettings('ic_stat_add_comment');
    var initializationsSettings =
        new InitializationSettings(android: androidInitialize);

    flutterLocalNotificationsPlugin.initialize(initializationsSettings);
  }

  static Future<void> displayDailyNotification(String title, String message) async {
    var androidSettings = AndroidNotificationDetails(
        'chn id', 'chn name', 'chn description',
        importance: Importance.high, priority: Priority.max);

    flutterLocalNotificationsPlugin.periodicallyShow(
        1,
        title,
        message,
        RepeatInterval.daily,
        NotificationDetails(android: androidSettings),
        androidAllowWhileIdle: true);
  }

  static Future<void> displayNotification(String title, String message) async {
    var androidSettings = AndroidNotificationDetails(
        'chn id', 'chn name', 'chn description',
        importance: Importance.high, priority: Priority.max);

    flutterLocalNotificationsPlugin.zonedSchedule(
        1,
        title,
        message,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: 2)),
        NotificationDetails(android: androidSettings),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }
}
