import 'dart:isolate';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tb_e_health/services/auth_service.dart';
import 'package:tb_e_health/services/local_alert.dart';
import 'package:tb_e_health/services/user_service.dart';

class AlarmService {

  // 10pm
  static void firstReminder() async {
    final DateTime now = DateTime.now();
    print('[$now] firstReminder: started ...');
    // everyday 10pm check if the user submitted
    checkAndShowAlert();
  }

  // 11pm
  static void secondReminder() {
    final DateTime now = DateTime.now();
    print('[$now] secondReminder: started ...');
    // everyday 11pm check if the user submitted
    checkAndShowAlert();
  }

  static void checkAndShowAlert() async {
    final DateTime now = DateTime.now();
    await Firebase.initializeApp();
    UserService userService = UserService();
    bool userHasUploadedVideo = await userService.videoUploaded();
    if (!userHasUploadedVideo) {
      // call notification!
      print('[$now] firstReminder: call notification');
      LocalAlert.initializeSetting();
      LocalAlert.displayNotification('Reminder',
          'Reminder: You have yet to upload your video, please do so by 12pm.');
    }
  }

  // 12pm
  static void finalChecking() {}

  static void meetingAlarm() {
    final DateTime now = DateTime.now();
    print('[$now] meetingAlarm: started ...');
    // call notification!
    print('[$now] meetingAlarm: call notification');
  }

  // meeting
  void addMeetingAlarm(int meetingId) async {
    // add alarm for meeting, meetingId as uniqueId,
    await AndroidAlarmManager.oneShot(
      const Duration(seconds: 1),
      // Ensure we have a unique alarm ID.
      meetingId,
      meetingAlarm,
      exact: true,
      wakeup: true,
    );
  }

  void cancelAlarm(String meetingId) {
    // cancel alarm by meetingId as uniqueId,
  }

  void callNotification() {
    final DateTime now = DateTime.now();
    final int isolateId = Isolate.current.hashCode;
    print("[$now] Hello, world! isolate=$isolateId");
  }

  static initAlarm() async {
    // everyday 10 pm first reminder check
    await AndroidAlarmManager.periodic(
        const Duration(seconds: 5), 1, AlarmService.firstReminder);
    // everyday 11 pm second reminder check
    await AndroidAlarmManager.oneShotAt(
        DateTime.now(), 2, AlarmService.secondReminder);
    // everyday 12 pm final check
    await AndroidAlarmManager.periodic(
        const Duration(seconds: 15), 3, AlarmService.finalChecking);
  }
}
