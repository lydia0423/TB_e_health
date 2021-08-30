import 'package:flutter/material.dart';
import 'package:tb_e_health/models/appointment.dart';

customAlertDialog(BuildContext context,
    {String title = "", String content = "", navigateHome = false}) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        );
      });
}

cancelAppointmentDialog(BuildContext context, Appointment value) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Cancel Appointment"),
          content: Text("Would you like to cancel selected appointment?"),
          actions: [
            TextButton(
              child: Text("Not Now"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text("Confirm"),
              onPressed: () async {
                print('cancelAppointmentDialog: ${value.id}');
                await deleteAppointment(value.id);
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

customUploadVideoDialog(BuildContext context,
    {String title = "", String content = "", VoidCallback? onPressed}) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
                onPressed: () => onPressed,
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.black),
                )),
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                )),
          ],
        );
      });
}
