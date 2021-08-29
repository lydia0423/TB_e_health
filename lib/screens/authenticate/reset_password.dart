import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/services/auth_service.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {

  final _formKey = GlobalKey<FormState>();

  final userIdCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  String userId = '';
  String password = '';
  bool passwordHidden = true;

  @override
  void initState() {
    userId = '';
    passwordHidden = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 35.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
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
                        validator: (v) => v!.isEmpty ? 'Enter userId (e.g. RN1234)' : null,
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
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8.0, left: 45.0, right: 45.0, bottom: 8.0),
                      child: Text(
                        'Change Password',
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
      .signInWithEmailAndPassword(email: email.trim(), password: defaultPassword);

  //Pass in the password to updatePassword.
  userCredential.user!.updatePassword(password).then((_) {
    print("Successfully changed password");
  }).catchError((error) {
    print("Password can't be changed" + error.toString());
    //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  });

  await FirebaseAuth.instance.signOut();
}
