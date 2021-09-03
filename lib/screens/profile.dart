import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/Custom%20Widgets/custom_alert_dialog.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/screens/chatbot/live_chat.dart';
import 'package:tb_e_health/services/auth_service.dart';

import 'daily_progress_board.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  final oldPasswordCtrl = TextEditingController();
  final newPasswordCtrl = TextEditingController();
  final confirmPasswordCtrl = TextEditingController();
  String oldPassword = '';
  String newPassword = '';
  String confirmPassword = '';
  bool oldPasswordHidden = true;
  bool newPasswordHidden = true;
  bool confirmPasswordHidden = true;

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myActiveUser(),
        builder: (BuildContext context, AsyncSnapshot<ActiveUser> user) {
          if (user.hasData) {
            return Scaffold(
              body: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30.0, 20.0, 20.0, 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'MY PERSONAL PROFILE',
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.w500),
                        ),
                        InkWell(
                          child: Container(
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('Logout'),
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Logout'),
                                    content: Text(
                                        'Are you sure you want to logout?'),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            _auth.signOut();
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Confirm')),
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text('Not Now')),
                                    ],
                                  );
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(30.0, 20.0, 10.0, 10.0),
                        child: (user.data!.avatar.isNotEmpty)
                            ? CircleAvatar(
                                backgroundImage:
                                    NetworkImage(user.data!.avatar),
                                radius: 70.0,
                              )
                            : CircleAvatar(
                                backgroundImage: AssetImage(
                                    "assets/Images/user_profile.png"),
                                radius: 70.0,
                              ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Name: ${user.data!.name}",
                              style: TextStyle(fontSize: 18.0)),
                          SizedBox(height: 10.0),
                          Text(
                            "Age: ${user.data!.age}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(height: 10.0),
                          Text(
                            "Gender: ${user.data!.gender}",
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 110.0),
                    child: OutlinedButton(
                        onPressed: () => Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DailyProgressBoardScreen();
                            })),
                        child: Icon(
                          Icons.analytics_rounded,
                          size: 50.0,
                          color: Colors.black,
                        ),
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.all(30.0),
                          elevation: 1.5,
                        )),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "My VOTS Therapy Progress",
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "Change Password",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
                    child: Container(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              onChanged: (v) {
                                setState(() {
                                  oldPassword = v;
                                });
                              },
                              controller: oldPasswordCtrl,
                              obscureText: oldPasswordHidden,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                labelText: 'Current Password',
                                suffixIcon: IconButton(
                                  icon: Icon(oldPasswordHidden
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      oldPasswordHidden = !oldPasswordHidden;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: (v) => v!.length < 6
                                  ? 'Password at least 6 characters'
                                  : v == oldPassword
                                      ? 'Cannot Reset Password to a Previous Password'
                                      : null,
                              onChanged: (v) {
                                setState(() {
                                  newPassword = v;
                                });
                              },
                              controller: newPasswordCtrl,
                              obscureText: newPasswordHidden,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30.0)),
                                labelText: 'New Password',
                                suffixIcon: IconButton(
                                  icon: Icon(newPasswordHidden
                                      ? Icons.visibility_off_rounded
                                      : Icons.visibility_rounded),
                                  color: Colors.black,
                                  onPressed: () {
                                    setState(() {
                                      newPasswordHidden = !newPasswordHidden;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            TextFormField(
                              validator: (v) =>
                                  v != newPassword ? 'Password mismatch' : null,
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
                                      confirmPasswordHidden =
                                          !confirmPasswordHidden;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: OutlinedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        changePassword(
                                            user.data!.email,
                                            oldPasswordCtrl.text,
                                            newPasswordCtrl.text);
                                        customAlertDialog(context,
                                            title: "Success",
                                            content:
                                                'Password Updated. Kindly login using new password.');
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0,
                                          left: 45.0,
                                          right: 45.0,
                                          bottom: 8.0),
                                      child: Text(
                                        'Change Password',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                    style: OutlinedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      backgroundColor: Colors.black,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 100.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return LinearProgressIndicator();
          }
        });
  }
}

void changePassword(
    String email, String oldPassword, String newPassword) async {
  UserCredential userCredential = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: email.trim(), password: oldPassword);

  //Pass in the password to updatePassword.
  userCredential.user!.updatePassword(newPassword).then((_) {
    print("Successfully changed password. Kindly login using new password.");
  }).catchError((error) {
    print("Password can't be changed" + error.toString());
    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });

  await FirebaseAuth.instance.signOut();
}
