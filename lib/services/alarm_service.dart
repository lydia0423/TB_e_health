import 'dart:isolate';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:tb_e_health/services/reminder_call.dart';

// alarm to call reminder
class AlarmService {
  static initAlarm() async {
    DateTime now = new DateTime.now();
    dailyAlarm();
    print('initAlarm: ' + now.toString());
  }

  // meeting
  void addMeetingAlarm(int meetingId) async {
    // add alarm for meeting, meetingId as uniqueId,
    await AndroidAlarmManager.oneShot(
      const Duration(seconds: 1),
      // Ensure we have a unique alarm ID.
      meetingId,
      ReminderCallService.meetingReminder,
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

  static dailyAlarm() async {
    // everyday 10 pm first reminder check
    int alarmId0 = 0;
    print('dailyAlarm id $alarmId0 scheduled at 10pm');
    await AndroidAlarmManager.periodic(
      const Duration(minutes: 1), //Do the same every 24 hours
      // const Duration(hours: 24), //Do the same every 24 hours
      alarmId0, //Different ID for each alarm
      ReminderCallService.firstReminder,
      exact: true,
      wakeup: true, //the device will be woken up when the alarm fires
      startAt: DateTime.now(),
      // startAt: DateTime(DateTime.now().year, DateTime.now().month,
      //     DateTime.now().day, 22, 0), //Start whit the specific time 10:00 pm
      rescheduleOnReboot: true, //Work after reboot
    );
    // everyday 11 pm second reminder check
    int alarmId1 = 1;
    print('dailyAlarm id $alarmId1 scheduled at 11pm');
    await AndroidAlarmManager.periodic(
      const Duration(hours: 24), //Do the same every 24 hours
      alarmId1, //Different ID for each alarm
      ReminderCallService.secondReminder,
      exact: true,
      wakeup: true, //the device will be woken up when the alarm fires
      startAt: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 23, 0), //Start whit the specific time 11:00 pm
      rescheduleOnReboot: true, //Work after reboot
    );
    // everyday 12 pm final check
    int alarmId2 = 2;
    print('dailyAlarm id $alarmId2 scheduled at 12pm');
    await AndroidAlarmManager.periodic(
      const Duration(hours: 24), //Do the same every 24 hours
      alarmId2, //Different ID for each alarm
      ReminderCallService.finalChecking,
      exact: true,
      wakeup: true, //the device will be woken up when the alarm fires
      startAt: DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 24, 0), //Start whit the specific time 12:00 pm
      rescheduleOnReboot: true, //Work after reboot
    );
  }
}
