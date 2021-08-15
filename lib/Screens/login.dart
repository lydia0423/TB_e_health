import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tb_e_health/Custom%20Widgets/custom_alert_dialog.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();

  String enteredEmail = "";
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
                  labelText: 'Username',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0, top: 10),
                    child: Text('Forget Password?'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: OutlinedButton(
                      onPressed: null,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, left: 5.0, right: 5.0, bottom: 8.0),
                        child: Text('First Time Login',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: OutlinedButton(
                      onPressed: accountLogin,
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

  //? Login
  void accountLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailCtrl.text, password: passwordCtrl.text);

      Get.offAllNamed("/home");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        loginError(context, "invalidUser");
      } else if (e.code == 'wrong-password') {
        loginError(context, "invalidPassword");
      } else if (e.code == "invalid-email") {
        loginError(context, "invalidEmail");
      }
    }
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

  //? Disposes of the widget once login is completed
  @override
  void dispose() {
    passwordCtrl.dispose();
    emailCtrl.dispose();
    super.dispose();
  }
}
