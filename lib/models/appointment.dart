import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'active_user.dart';

class AppointmentStatus {
  static const String pending = 'Pending';
  static const String accept = 'Accept';
}

class Appointment {
  final String id;
  final String appointmentDate;
  final String appointmentEndTime;
  final String appointmentStartTime;
  final String appointmentStatus;
  final String userId;
  final String userName;

  Appointment({
    this.id = '',
    this.appointmentDate = "2021-08-26",
    this.appointmentEndTime = "09:00",
    this.appointmentStartTime = "09:00",
    this.appointmentStatus = AppointmentStatus.pending,
    this.userId = "UM00001",
    this.userName = "Lydia",
  });

  DateTime get timestamp {
    // "2012-02-27 13:27:00";
    return DateTime.parse('$appointmentDate $appointmentStartTime:00');
  }

  static String toDate(DateTime timestamp) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(timestamp);
  }

  static String toTime(DateTime timestamp) {
    final DateFormat formatter = DateFormat('HH:mm');
    return formatter.format(timestamp);
  }

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json["id"] ?? '',
      appointmentDate: json["AppointmentDate"] ?? "2021-08-26",
      appointmentEndTime: json["AppointmentEndTime"] ?? '09:30',
      appointmentStartTime: json["AppointmentStartTime"] ?? '09:00',
      appointmentStatus: json["AppointmentStatus"] ?? AppointmentStatus.pending,
      userId: json["UserId"] ?? 'UM00001',
      userName: json["UserName"] ?? 'Lydia',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'AppointmentDate': appointmentDate,
      'AppointmentEndTime': appointmentEndTime,
      'AppointmentStartTime': appointmentStartTime,
      'AppointmentStatus': appointmentStatus,
      'UserId': userId,
      'UserName': userName,
    };
  }

  @override
  String toString() {
    return 'Appointment $appointmentStartTime -> $appointmentEndTime';
  }
}

Future<List<Appointment>> findAppointOfActiveUser(ActiveUser user) async {
  String userId = user.userId;
  List<Appointment> result = [];
  try {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection("Appointment")
        .where("UserId", isEqualTo: userId);
    QuerySnapshot snapshot = await query.get();
    for (var doc in snapshot.docs) {
      print('${doc.id} ${doc.data()}');
      var submission = Appointment.fromJson(doc.data() as Map<String, dynamic>);
      result.add(submission);
    }
    return result;
  } catch (e) {
    print(e);
    return result;
  }
}

int _getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

Future<LinkedHashMap<DateTime, List<Appointment>>>
    findAppointOfActiveUserAsMappingFuture(Future<ActiveUser> userFuture) async {
  var user = await userFuture;
  final List<Appointment> result = await findAppointOfActiveUser(user);
  final LinkedHashMap<DateTime, List<Appointment>> map =
      LinkedHashMap<DateTime, List<Appointment>>(
    equals: isSameDay,
    hashCode: _getHashCode,
  )..addAll(<DateTime, List<Appointment>>{
          for (var r in result) r.timestamp: 
              // block 8am - 5pm
              (r.timestamp.hour >= 8 && r.timestamp.hour < 17)
                  ? [r]
                  : []
        });
  return map;
}

Future<LinkedHashMap<DateTime, List<Appointment>>>
    findAppointOfActiveUserAsMapping(ActiveUser userFuture) async {
  final List<Appointment> result = await findAppointOfActiveUser(userFuture);
  final LinkedHashMap<DateTime, List<Appointment>> map =
      LinkedHashMap<DateTime, List<Appointment>>(
    equals: isSameDay,
    hashCode: _getHashCode,
  )..addAll(<DateTime, List<Appointment>>{
          for (var r in result) r.timestamp: 
              // block 8am - 5pm
              (r.timestamp.hour >= 8 && r.timestamp.hour < 17)
                  ? [r]
                  : []
        });
  return map;
}

Future<void> createAppointment(Appointment request) async {
  await FirebaseFirestore.instance
      .collection('Appointment')
      .add(request.toJson());
}

Future<void> deleteAppointment(String id) async {
  await FirebaseFirestore.instance
      .collection('Appointment')
      .where('id', isEqualTo: id)
      .get()
      .then((value) => value.docs.forEach((element) {
            print(element.id);
            FirebaseFirestore.instance
                .collection('Appointment')
                .doc(element.id)
                .delete();
          }));
}
