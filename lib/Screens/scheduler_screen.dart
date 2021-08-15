import 'package:flutter/material.dart';
import 'package:tb_e_health/Custom_Widget/hello_calendar_selection.dart';

import 'package:tb_e_health/utils.dart';

class SchedulerScreen extends StatefulWidget {
  @override
  _SchedulerScreenState createState() => _SchedulerScreenState();
}


class _SchedulerScreenState extends State<SchedulerScreen> {

  DateTime? dateTime = null;

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
              dateTime = dateTime!.setDate(date);
            },
          ),
          if (dateTime != null) 
            // TODO: show time picker
            SizedBox(),
        ],
      ),
    );
  }
}