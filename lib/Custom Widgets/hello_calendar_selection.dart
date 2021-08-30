import 'package:flutter/material.dart';

import '../utils.dart';
import 'hello_calendar.dart';

class HelloCalendarSelection extends StatefulWidget {
  final int year;
  int month;

  // config data

  /// the day start TB treatment
  final DateTime from;

  /// the day complete TB treatment
  final DateTime to;

  final void Function(DateTime) onSelect;

  // load color for appointment
  final DateTime? appointment;
  final bool awaiting;

  HelloCalendarSelection({
    required this.year,
    required this.month,
    required this.from,
    required this.to,
    required this.onSelect,
    this.appointment,
    this.awaiting = true,
  }) : assert(month <= DateTime.december && month >= DateTime.january);

  _HelloCalendarSelection createState() => _HelloCalendarSelection();
}

class _HelloCalendarSelection extends State<HelloCalendarSelection> {
  DateTime? selected;

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
    if (widget.appointment == null) {
      return null;
    }
    var a = widget.appointment!.getToday();
    if (a.day == date.day && a.month == date.month && a.year == date.year) {
      return widget.awaiting ? HelloYellow : HelloGreen;
    }
    return null;
  }

  Widget _dayWidget(
    BuildContext context,
    DateTime date,
  ) {
    bool isSelectable = date.isAfter(widget.from) && date.isBefore(widget.to);
    var child = GestureDetector(
      onTap: isSelectable
          ? () {
              setState(() {
                selected = date;
              });
              widget.onSelect(date);
            }
          : null,
      child: SelectableDayBox(
        size: MediaQuery.of(context).size.width / 7 - 8,
        day: date.day,
        color: _computeColor(date),
        border: date.day == DateTime.now().day,
        selectable: isSelectable,
      ),
    );
    return SizedBox(
      width: MediaQuery.of(context).size.width / 7,
      height: MediaQuery.of(context).size.width / 7,
      child: selected == date
          ? Card(
              child: child,
            )
          : child,
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
      } while (
          dayDate.weekday != DateTime.sunday && dayDate.month == widget.month);
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

class SelectableDayBox extends DayBox {
  final bool selectable;

  SelectableDayBox({
    this.selectable = true,
    double? size,
    int day = 1,
    Color? color,
    bool border = false,
  }) : super(
          size: size ?? 60,
          day: day,
          color: color,
          border: border,
        );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DefaultTextStyle(
        style: TextStyle(
          color: selectable ? Colors.black : Colors.grey,
        ),
        child: super.build(context),
      ),
    );
  }
}
