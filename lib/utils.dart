import 'package:flutter/material.dart';

extension HelloDate on DateTime {
  DateTime getToday() => DateTime(this.year, this.month, this.day);

  DateTime getTodayEnd() => DateTime(this.year, this.month, this.day, 23, 59, 59);

  DateTime setDate(DateTime date) => DateTime(
    date.year,
    date.month,
    date.day, 
    this.hour, 
    this.minute, 
    this.second, 
    this.millisecond, 
    this.microsecond,
  );

  DateTime setTime(TimeOfDay time) => DateTime(
    this.year,
    this.month,
    this.day, 
    time.hour, 
    time.minute,
  );
}

const HelloBlue = Color(0xFF00B2FF);
const HelloRed = Color(0x5AFE0000);
const HelloYellow = Color(0x5AFFE073);
const HelloGreen = Color(0x5A22FF38);
const HelloGrey = Color(0x5AC4C4C4);