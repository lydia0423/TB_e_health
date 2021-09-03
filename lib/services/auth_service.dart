import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/custom_widgets/custom_alert_dialog.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/models/anonymous_user.dart';
import 'package:tb_e_health/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  AnonymousUser? _anonymousUserFromFirebaseUser(User? user) {
    return user?.uid != null ? AnonymousUser(uid: user!.uid) : null;
  }

  User? currentFirebaseUser() {
    return _auth.currentUser;
  }

  ActiveUser? currentActiveUser() {}

  Future<ActiveUser?> _activeUserFromFirebaseUser(User? user) async {
    if (user?.uid == null) {
      return null;
    } else {
      var userDetails = await FirebaseFirestore.instance
          .collection("User")
          .doc(user!.uid)
          .get();

      return ActiveUser.fromJson(userDetails.data()!);
    }
  }

  // auth change user stream
  Stream<AnonymousUser?> get user {
    return _auth
        .authStateChanges()
        .map((user) => _anonymousUserFromFirebaseUser(user));
  }

  Stream<dynamic> get activeUser {
    return _auth
        .authStateChanges()
        .map((user) => _activeUserFromFirebaseUser(user));
  }

  // sign in with email & password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      return _activeUserFromFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "invalidUser";
      } else if (e.code == 'wrong-password') {
        return "invalidPassword";
      } else if (e.code == "invalid-email") {
        return "invalidEmail";
      }
    }
  }

  UserService _user = UserService();

  // sign in with email & password
  Future signInWithUserIdAndPassword(String userId, String password) async {
    print('signInWithUserIdAndPassword: userId = ' + userId);
    String email = '';
    try {
      email = await _user.getUserEmailByUserId(userId.trim());
      print('signInWithUserIdAndPassword: email is ' + email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "invalidUser";
      }
    }
    if (email == '') {
      return "invalidUser";
    }

    try {
      UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: email.trim(), password: password);
      return _activeUserFromFirebaseUser(userCredential.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "invalidUser";
      } else if (e.code == 'wrong-password') {
        return "invalidPassword";
      } else if (e.code == "invalid-email") {
        return "invalidEmail";
      }
    }
  }

// sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('auth: ' + e.toString());
      return null;
    }
  }

// register with email & password

// reset password
  Future<void> resetPassword(BuildContext context, String email) async {
    await _auth.sendPasswordResetEmail(email: email);
    return customAlertDialog(context,
        title: 'Email has been sent out',
        content: 'Please check your mail box to reset password');
  }

  createUser(String userEmail, String defaultPassword) async {
    UserCredential user =  await _auth.createUserWithEmailAndPassword(
        email: userEmail, password: defaultPassword);
  }

}
