import 'package:firebase_core/firebase_core.dart';
import 'package:tb_e_health/services/local_alert.dart';
import 'package:tb_e_health/services/user_service.dart';

class ReminderCallService {

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

  static void meetingReminder() {
    final DateTime now = DateTime.now();
    print('[$now] meetingAlarm: started ...');
    // call notification!
    print('[$now] meetingAlarm: call notification');
  }
}
