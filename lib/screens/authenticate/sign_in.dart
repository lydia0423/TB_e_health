import 'package:flutter/material.dart';
import 'package:tb_e_health/Custom%20Widgets/custom_alert_dialog.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/models/anonymous_user.dart';
import 'package:tb_e_health/services/auth_service.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final resetPasswordCtrl = TextEditingController();

  final AuthService _auth = AuthService();

  String enteredEmail = "";
  String resetPasswordEmail = "";
  String email = "";
  //^ Password field attributes - password visibility toggle + icon
  bool passwordHidden = true;
  var iconShowPassword;

  //? Intialises inital value of variables
  @override
  void initState() {
    enteredEmail = "";
    passwordHidden = true;
    iconShowPassword = Icons.visibility_off_rounded;
    super.initState();
  }

  //? AlertDialog notification when login error is triggered
  void loginError(BuildContext context, String errorType) {
    String errorMsg = '';

    //^ Determines error type and the appropriate message to return
    switch (errorType) {
      case "invalidUser":
        errorMsg = "No user with this email has been found";
        break;
      case "invalidPassword":
        errorMsg = "Sorry, your password was incorrect";
        break;
      case "invalidEmail":
        errorMsg = "Please ensure that your email has been entered correctly";
        break;
    }

    //^ Build method for AlertDialog
    customAlertDialog(context, title: "Error logging in", content: errorMsg);
  }

  //? Build method for Login screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 50.0, bottom: 0.0, left: 40.0, right: 30.0),
                child: Image(
                  image: AssetImage('assets/Images/uni_logo.png'),
                  width: 350,
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0.0, bottom: 10.0, left: 75.0, right: 60.0),
                child: Image(
                  image: AssetImage('assets/Images/app_logo.png'),
                  width: 280,
                ),
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 0.0, left: 30.0, right: 30.0),
              child: TextField(
                controller: emailCtrl,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  labelText: 'Email',
                ),
                onChanged: (newText) {
                  setState(() {
                    enteredEmail = newText;
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 10.0, left: 30.0, right: 30.0),
              child: TextField(
                controller: passwordCtrl,
                obscureText: passwordHidden,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(iconShowPassword),
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        passwordHidden = !passwordHidden;
                        (passwordHidden)
                            ? iconShowPassword = Icons.visibility_off_rounded
                            : iconShowPassword = Icons.visibility_rounded;
                      });
                    },
                  ),
                ),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0, top: 10),
                    child: Text('Forget Password?'),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        barrierDismissible: true,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('ResetPassword'),
                            content: TextField(
                              controller: resetPasswordCtrl,
                              decoration:
                              InputDecoration(hintText: 'Enter your email'),
                              onChanged: (value) {
                                setState(() {
                                  resetPasswordEmail = value;
                                });
                              },
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _auth.resetPassword(email);
                                    return customAlertDialog(context,
                                        title: 'Email has been sent out',
                                        content: 'Please check your mail box to reset password');
                                  },
                                  child: Text(
                                    'OK',
                                    style: TextStyle(color: Colors.black),
                                  ))
                            ],
                          );
                        });
                  })
            ]),
            SizedBox(height: 14.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: OutlinedButton(
                      onPressed: () async {
                        dynamic result = await _auth.signInWithEmailAndPassword(
                            emailCtrl.text,
                            passwordCtrl.text
                        );
                        if (result is String) {
                          print('SignIn: error!!! '+result);
                          loginError(context, result);
                        } else {
                          print('SignIn: '+(result as ActiveUser).userId);
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 45.0, right: 45.0, bottom: 8.0),
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        backgroundColor: Colors.black,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

