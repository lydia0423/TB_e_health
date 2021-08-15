import 'package:tb_e_health/Custom%20Widgets/hello_calendar.dart';
import 'package:flutter/material.dart';

import 'package:tb_e_health/utils.dart';

class DailyProgressBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var today = DateTime.now().getToday();
    // TODO: get state
    var dates = {
      DateTime(2021, 8, 5): true,
      DateTime(2021, 8, 6): true,
      DateTime(2021, 8, 7): true,
      DateTime(2021, 8, 8): true,
      DateTime(2021, 8, 9): true,
      DateTime(2021, 8, 10): true,
      DateTime(2021, 8, 12): true,
      DateTime(2021, 8, 13): true,
    };
    return Scaffold(
      // TODO: primary color
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          HelloCalendar(
            year: today.year,
            month: today.month,
            // TODO: get from state
            from: DateTime(2021, 8, 5),
            to: DateTime(2021, 8, 30),
            until: DateTime(2021, 8, 26),
            dates: dates,
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: SizedBox(
              height: 200,
              width: 200,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    dates[today] ?? false
                        // today taken medication
                        ? 'YOU HAVE COMPLETED YOUR MEDICATION TODAY!'
                        : 'HAVE YOU TAKE YOUR MEDICATION?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Keep up the good work!',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
