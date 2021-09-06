import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/custom_widgets/hello_calendar_selection.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/models/appointment.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';
import 'package:tb_e_health/screens/shared/utils.dart';
import 'package:uuid/uuid.dart';

const int _INTERVAL = 30;

class RequestApointmentScreen extends StatefulWidget {
  @override
  _RequestApointmentScreenState createState() => _RequestApointmentScreenState();
}

class _RequestApointmentScreenState extends State<RequestApointmentScreen> {
  DateTime? dateTime;
  final futureData = findAppointOfActiveUserAsMappingFuture(myActiveUser());

  Future<void> _createAppointment() async {
    if (dateTime!.isBefore(DateTime.now())) {
      showDialog(
        barrierDismissible: true,
        context: context, 
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Cant choose before ${DateTime.now()}'),
          );
        },
      );
      return;
    }
    // 8am - 5pm
    if (dateTime!.hour < 8 || dateTime!.hour >= 17) {
      showDialog(
        barrierDismissible: true,
        context: context, 
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Cant choose before 8am or after 5pm'),
          );
        },
      );
      return;
    }
    // check if booked
    final data = await futureData;
    final appointments = data[dateTime!.getToday()]?? [];
    for (var appointment in appointments) {
      if (appointment.timestamp.isAtSameMomentAs(dateTime!)) {
        showDialog(
          barrierDismissible: true,
          context: context, 
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('You have booked on this timeslot'),
            );
          },
        );
        return;
      }
    }

    var user = await myActiveUser();

    Uuid uuid = Uuid();

    Appointment request = Appointment(
      appointmentDate: Appointment.toDate(dateTime!),
      appointmentEndTime: Appointment.toTime(dateTime!.add(Duration(minutes: 30))),
      appointmentStartTime: Appointment.toTime(dateTime!),
      appointmentStatus: AppointmentStatus.pending,
      id: uuid.v4().toString(),
      userId: user.userId,
      userName: user.name,
    );
    try {
      await createAppointment(request);
      // Get.back();
      Navigator.of(context).pop();
    } catch(e) {
      showDialog(
        barrierDismissible: true,
        context: context, 
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('$e'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now().getToday();
    // TODO: get state on appointment
    return Scaffold(
      appBar: CommonAppBar(title: 'Book Appointment'),
      body: ListView(
        children: [
          HelloCalendarSelection(
            year: today.year,
            month: dateTime != null ? dateTime!.month:today.month,
            // TODO: get from state
            from: DateTime.now().subtract(Duration(hours: 24)), 
            to: DateTime.now().add(Duration(days: 90)),
            onSelect: (date) {
              date = date.setTime(DateTime.now());
              dateTime = dateTime?? 
                  date.add(Duration(minutes: _INTERVAL - (date.minute % _INTERVAL)));
              setState(() {
                dateTime = dateTime!.setDate(date);
              });
            },
          ),
          if (dateTime != null)
            // TODO: show time picker
            SizedBox(
              height: 160,
              child: CupertinoDatePicker(
                minuteInterval: _INTERVAL,
                initialDateTime: dateTime,
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (time) {
                  setState(() {
                    dateTime = dateTime!.setTime(time);
                  });
                },
              ),
            ),
          if (dateTime != null)
            Text('Book Time will be 30 minutes'),
          if (dateTime != null)
            SizedBox(
              height: 60,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: _createAppointment,
                  child: Text('Confirm Session'),
                ),
              ),
            ),
          SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
