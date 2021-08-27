class Appointment {
  final DateTime datetime;
  final bool awaiting;

  Appointment({
    required this.datetime,
    this.awaiting = true,
  });
}