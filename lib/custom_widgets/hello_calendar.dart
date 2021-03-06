import 'package:flutter/material.dart';

import '../screens/shared/utils.dart';

class HelloCalendar extends StatefulWidget {
  final int year;
  int month;
  // config data

  /// the day start TB treatment
  final DateTime from;

  /// the day complete TB treatment
  final DateTime to;

  /// the day ur supply can tahan
  final DateTime until;

  /// dates whether video is taken, true is done
  final Map<DateTime, bool> dates;

  HelloCalendar({
    required this.year,
    required this.month,
    required this.from,
    required this.to,
    required this.until,
    required this.dates,
  }) : assert(month <= DateTime.december && month >= DateTime.january);

  @override
  _HelloCalendarState createState() => _HelloCalendarState();
}

class _HelloCalendarState extends State<HelloCalendar> {
  String get _monthToString {
    switch (widget.month) {
      case DateTime.january:
        return 'january';
      case DateTime.february:
        return 'february';
      case DateTime.march:
        return 'march';
      case DateTime.april:
        return 'april';
      case DateTime.may:
        return 'may';
      case DateTime.june:
        return 'june';
      case DateTime.july:
        return 'july';
      case DateTime.august:
        return 'august';
      case DateTime.september:
        return 'september';
      case DateTime.october:
        return 'october';
      case DateTime.november:
        return 'november';
      case DateTime.december:
        return 'december';
    }
    throw Exception('Month invalid');
  }

  Widget _weekHeader() {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: Text(
              'SUN',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'MON',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'TUE',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'WED',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'THU',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'FRI',
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Text(
              'SAT',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Color? _computeColor(DateTime date) {
    print('_computeColor: date : $date');
    var b = widget.dates[date];
    if (widget.dates[date] ?? false) {
      return HelloGreen;
    }
    // today or after that
    if (date.isAfter(DateTime.now().subtract(const Duration(days: 1)))) {
      if (date.isBefore(widget.until)) {
        // still have supply
        return Colors.transparent;
      } else if (date.isBefore(widget.to)) {
        // need resupply
        return HelloGrey;
      }
    } else if (date.isAfter(widget.from)) {
      // already pass but didnt take video
      return HelloRed;
    }
    return null;
  }

  Widget _dayWidget(
    BuildContext context,
    DateTime date,
  ) {
    return DayBox(
      size: MediaQuery.of(context).size.width / 7,
      day: date.day,
      color: _computeColor(date),
      border: date.day == DateTime.now().day,
    );
  }

  _weekBuilder(BuildContext context, List<DateTime> week) {
    return Row(
      mainAxisAlignment:
          week[0].day == 1 ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: week.map((day) {
        return _dayWidget(context, day);
      }).toList(),
    );
  }

  Widget _calendarBuilder(BuildContext context) {
    List<List<DateTime>> weeks = [];
    var dayDate = DateTime(widget.year, widget.month);
    while (dayDate.month == widget.month) {
      weeks.add([]);
      do {
        weeks[weeks.length - 1].add(dayDate);
        dayDate = dayDate.add(const Duration(days: 1));
      } while (dayDate.weekday != DateTime.sunday && dayDate.month == widget.month);
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: weeks.map<Widget>((week) {
        return _weekBuilder(context, week);
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // month year
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_sharp),
                tooltip: 'Previous month',
                onPressed: () {
                  setState(() {
                    int newMonth = (widget.month-1);
                    if (newMonth < 1) {
                      newMonth = 12;
                    }
                    print('previous month: ${widget.month} to $newMonth');
                    widget.month=newMonth;
                  });
                },
              ),
              Text(
                '${_monthToString.toUpperCase()} ${widget.year}',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward_ios_sharp),
                tooltip: 'Next month',
                onPressed: () {
                  setState(() {
                    int newMonth = (widget.month+1);
                    if (newMonth > 12) {
                      newMonth = 1;
                    }
                    print('previous month: ${widget.month} to $newMonth');
                    widget.month=newMonth;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 12),
        // week header
        _weekHeader(),
        // build calendar
        _calendarBuilder(context),
      ],
    );
  }
}

class DayBox extends StatelessWidget {
  final double size;
  final int day;
  final Color? color;
  final bool border;

  DayBox({
    this.size = 60,
    this.day = 1,
    this.color,
    this.border = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      padding: EdgeInsets.all(3),
      child: Container(
        decoration: BoxDecoration(
          color: color != null? color : null,
          borderRadius: BorderRadius.all(Radius.circular(size/2-3)),
          border: border
            ? Border.all(
              color: HelloBlue,
            ) : null,
        ),
        child: Center(
          child: Text('$day'),
        ),
      ),
    );
  }
}
