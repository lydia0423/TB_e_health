import 'package:flutter/material.dart';

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
