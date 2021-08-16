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

// customAlertDialogWithTextField(BuildContext context,
//     {String title = "",
//     String content = "",
//     navigateHome = false,
//     TextEditingController? textEditingController,
//     VoidCallback? onPressed}) {
//   return showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(title),
//           content: TextField(
//             controller: textEditingController,
//             decoration: InputDecoration(hintText: 'Enter your email'),
//             onChanged: (value) {
//               setState(() {
//                     content = value;
//                   });
//             },
//           ),
//           actions: [
//             TextButton(
//                 onPressed: onPressed,
//                 child: Text(
//                   'OK',
//                   style: TextStyle(color: Colors.black),
//                 ))
//           ],
//         );
//       });
// }


