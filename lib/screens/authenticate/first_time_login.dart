import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/Custom%20Widgets/custom_alert_dialog.dart';
import 'package:tb_e_health/Screens/shared/common_app_bar.dart';

class FirstTimeLogin extends StatefulWidget {
  const FirstTimeLogin({Key? key}) : super(key: key);

  @override
  _FirstTimeLoginState createState() => _FirstTimeLoginState();
}

class _FirstTimeLoginState extends State<FirstTimeLogin> {
  final _formKey = GlobalKey<FormState>();

  final userIdCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();

  String userId = '';
  String password = '';
  String confirmPassword = '';
  bool passwordHidden = true;
  bool confirmPasswordHidden = true;

  @override
  void initState() {
    userId = '';
    passwordHidden = true;
    confirmPasswordHidden = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'First Time Login'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // LOGIN FORM
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
              child: Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (v) =>
                            v!.isEmpty ? 'Enter userId (e.g. RN1234)' : null,
                        onChanged: (v) {
                          setState(() {
                            userId = v;
                          });
                        },
                        controller: userIdCtrl,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          labelText: 'User Id (e.g. RN1234)',
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (v) => v!.length < 6
                            ? 'Password at least 6 characters'
                            : null,
                        onChanged: (v) {
                          setState(() {
                            password = v;
                          });
                        },
                        controller: passwordCtrl,
                        obscureText: passwordHidden,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(passwordHidden
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                passwordHidden = !passwordHidden;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        validator: (v) =>
                            v != password ? 'Password mismatch' : null,
                        onChanged: (v) {
                          setState(() {
                            confirmPassword = v;
                          });
                        },
                        controller: confirmPasswordCtrl,
                        obscureText: confirmPasswordHidden,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          labelText: 'Confirm Password',
                          suffixIcon: IconButton(
                            icon: Icon(confirmPasswordHidden
                                ? Icons.visibility_off_rounded
                                : Icons.visibility_rounded),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                confirmPasswordHidden = !confirmPasswordHidden;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 14.0),

            // LOGIN BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: OutlinedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        changePassword(userIdCtrl.text, passwordCtrl.text);
                        customAlertDialog(context,
                            title: "Success", content: 'Password Updated');
                        // Navigator.of(context).pop(true);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 45.0, right: 45.0, bottom: 8.0),
                      child: Text(
                        'Confirm Registration',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
              ],
            ),

            // DUMMY USER BUTTON
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Padding(
            //       padding: const EdgeInsets.only(left: 15.0),
            //       child: OutlinedButton(
            //         onPressed: () async {
            //           generateUser(userIdCtrl.text);
            //           customAlertDialog(context, title: "Success", content: 'User created');
            //         },
            //         child: Padding(
            //           padding: const EdgeInsets.only(
            //               top: 8.0, left: 45.0, right: 45.0, bottom: 8.0),
            //           child: Text(
            //             'Generate user',
            //             style: TextStyle(color: Colors.white, fontSize: 18),
            //           ),
            //         ),
            //         style: OutlinedButton.styleFrom(
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(30)),
            //           backgroundColor: Colors.black,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}

void changePassword(String userId, String password) async {
  // get the user email by userId, the email is just userId+@email.com now!
  String email = userId + "@email.com";
  // the default password is password.
  String defaultPassword = "password";

  UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(
          email: email.trim(), password: defaultPassword);

  //Pass in the password to updatePassword.
  userCredential.user!.updatePassword(password).then((_) {
    print("Successfully changed password");
  }).catchError((error) {
    print("Password can't be changed" + error.toString());
    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });

  await FirebaseAuth.instance.signOut();
}

void generateUser(String userId) async {
  // get the user email by userId, the email is just userId+@email.com now!
  String email = userId + "@email.com";
  // the default password is password.
  String defaultPassword = "password";

  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: defaultPassword);

  await FirebaseFirestore.instance
      .collection("User")
      .doc(userCredential.user!.uid)
      .set({
    "UserId": userId,
    "UserEmail": email,
    "UserGender": "Female",
    "UserAddress": "No. 25, Taman University, 46300, Selangor DM",
    "TherapyStartDate": "2021-08-20",
    "TherapyEndDate": "2021-10-30",
    "UserHealthInfo": "Diabetes",
    "UserName": "Melissa Tee",
    "UserNotificationPreferences": true,
    "UserAvatar":
        "https://www.nicepng.com/png/full/52-521023_download-free-icon-female-vectors-blank-facebook-profile.png",
    "UserAge": "58"
  });

  await FirebaseAuth.instance.signOut();
}
