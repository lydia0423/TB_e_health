import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tb_e_health/Custom%20Widgets/custom_alert_dialog.dart';
import 'package:tb_e_health/common/constants.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/screens/authenticate/first_time_login.dart';
import 'package:tb_e_health/services/auth_service.dart';

import '../shared/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final resetPasswordCtrl = TextEditingController();
  String errorMsg = '';
  bool loading = false;

  final AuthService _auth = AuthService();

  String userId = '';
  String email = '';
  String password = '';

  //^ Password field attributes - password visibility toggle + icon
  bool passwordHidden = true;
  var iconShowPassword;

  //? Intialises inital value of variables
  @override
  void initState() {
    email = '';
    passwordHidden = true;
    super.initState();
  }

  void loginError(BuildContext context, String errorType) {
    switch (errorType) {
      case "invalidUser":
        setState(() {
          errorMsg = "User not found";
        });
        break;
      case "invalidPassword":
        setState(() {
          errorMsg = "Incorrect password";
        });
        break;
      case "invalidEmail":
        setState(() {
          errorMsg = "Please ensure that your email has been entered correctly";
        });
        break;
    }
  }

  //? Build method for Login screen
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
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

                  // LOGO
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
                    height: 30,
                  ),
                  if (errorMsg.isNotEmpty)
                    Text('$errorMsg', style: TextStyle(color: Colors.red)),
                  SizedBox(
                    height: 30,
                  ),

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
                              validator: (v) => v!.isEmpty
                                  ? 'Enter an valid user id (e.g. RN1234)'
                                  : null,
                              onChanged: (v) {
                                setState(() {
                                  email = v;
                                });
                              },
                              controller: emailCtrl,
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

                  // FORGET PASSWORD
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
                                    decoration: InputDecoration(
                                        hintText: 'Enter your email'),
                                    onChanged: (value) {
                                      setState(() {
                                        email = value;
                                      });
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          (email.isEmpty)
                                              ? customAlertDialog(context,
                                                  title:
                                                      'Email cannot be empty',
                                                  content:
                                                      'Please enter your registered email')
                                              : _auth.resetPassword(
                                                  context, email);
                                        },
                                        child: Text(
                                          'OK',
                                          style: TextStyle(color: Colors.black),
                                        )),
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Cancel'))
                                  ],
                                );
                              });
                        })
                  ]),

                  SizedBox(height: 14.0),

                  // LOGIN BUTTON
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: OutlinedButton(
                            onPressed: () async {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => FirstTimeLogin()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'First Time Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Constants.buttonFs),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: OutlinedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                dynamic result =
                                    await _auth.signInWithUserIdAndPassword(
                                        emailCtrl.text, passwordCtrl.text);
                                if (result is String) {
                                  print('SignIn: error!!! ' + result);
                                  loginError(context, result);
                                } else {
                                  print('SignIn: ' +
                                      (result as ActiveUser).userId);
                                }
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: Constants.buttonFs),
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              backgroundColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                  SizedBox(height: 150.0),
                ],
              ),
            ),
          );
  }
}
