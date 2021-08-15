import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/Custom_Widget/hello_calendar_selection.dart';

import 'package:tb_e_health/utils.dart';

class SchedulerScreen extends StatefulWidget {
  @override
  _SchedulerScreenState createState() => _SchedulerScreenState();
}


class _SchedulerScreenState extends State<SchedulerScreen> {

  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now().getToday();
    // TODO: get state on appointment
    return Scaffold(
      // TODO: primary color
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          HelloCalendarSelection(
            year: today.year,
            month: today.month,
            // TODO: get from state
            from: DateTime(2021, 8, 5),
            to: DateTime(2021, 8, 30),
            appointment: DateTime(2021, 8, 18),
            onSelect: (date) {
              dateTime = dateTime?? date;
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
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (time) {
                  setState(() {
                    dateTime = dateTime!.setTime(time);
                  });
                },
              ),
            ),
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
                  // TODO: action save the appointment
                  onPressed: () {},
                  child: Text('Confirm Session'),
                ),
              ),
            )
        ],
      ),
    );
  }
}