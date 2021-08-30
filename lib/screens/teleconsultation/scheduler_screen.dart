import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/models/appointment.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/screens/shared/common_app_bar.dart';
import 'package:tb_e_health/screens/teleconsultation/datetime_picker.dart';
import 'package:tb_e_health/screens/teleconsultation/request_appointment_screen.dart';

import 'package:tb_e_health/utils.dart';

class SchedulerScreen extends StatefulWidget {
  @override
  _SchedulerScreenState createState() => _SchedulerScreenState();
}

class _SchedulerScreenState extends State<SchedulerScreen> {
  DateTime focusDateTime = DateTime.now();

  void _requestAppointment() {
    pushNewScreen(
      context,
      screen: RequestApointmentScreen(),
      withNavBar: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now().getToday();
    // TODO: get state on appointment
    return Scaffold(
      appBar: CommonAppBar(title: 'Tele Consultation Session'),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: FloatingActionButton.extended(
                key: Key('add'),
                heroTag: Key('add'),
                onPressed: _requestAppointment,
                label: Text('Book Appointment'),
                icon: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<LinkedHashMap<DateTime, List<Appointment>>>(
        future: findAppointOfActiveUserAsMapping(myActiveUser()),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: SizedBox(
                  child: Text('Facing Error'),
                ),
              );
            } else if (snapshot.hasData) {
              return SchedulerScreenContent(snapshot.data!);
            }
          }
          return Center(
            child: SizedBox(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class SchedulerScreenContent extends StatefulWidget {
  final LinkedHashMap<DateTime, List<Appointment>> content;

  SchedulerScreenContent(this.content);

  @override
  _SchedulerScreenContentState createState() => _SchedulerScreenContentState();
}

class _SchedulerScreenContentState extends State<SchedulerScreenContent> {
  DateTime focusDateTime = DateTime.now();
  late final ValueNotifier<List<Appointment>> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _selectedEvents = ValueNotifier(widget.content[focusDateTime] ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: focusDateTime,
          firstDay: DateTime.now().subtract(Duration(days: 7)),
          lastDay: DateTime.now().add(Duration(days: 90)),
          eventLoader: (dateTime) {
            return widget.content[dateTime] ?? [];
          },
          // holidayPredicate: (date) {
          //   // If not Sunday or Saturday return day as clicable
          //   if (date.weekday != 6 && date.weekday != 7) {
          //     return true;
          //   }
          //   return false;
          // },
          selectedDayPredicate: (day) {
            return isSameDay(focusDateTime, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            _selectedEvents.value = widget.content[focusedDay] ?? [];
            setState(() {
              // focusDateTime = selectedDay;
              focusDateTime = focusedDay; // update `_focusedDay` here as well
            });
          },
        ),
        Expanded(
          child: ValueListenableBuilder<List<Appointment>>(
            valueListenable: _selectedEvents,
            builder: (context, value, _) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ListTile(
                      onTap: () => print('${value[index]}'),
                      title: Text('${value[index]}'),
                    ),
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}
