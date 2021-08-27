import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tb_e_health/models/active_user.dart';
import 'package:tb_e_health/models/anonymous_user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user obj based on FirebaseUser
  AnonymousUser? _anonymousUserFromFirebaseUser(User? user) {
    return user?.uid != null ?
    AnonymousUser(uid: user!.uid) : null;
  }

  // auth change user stream
  Stream<AnonymousUser?> get user {
    return _auth.authStateChanges()
    .map((user) => _anonymousUserFromFirebaseUser(user));
  }

  // sign in anonymous
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return _anonymousUserFromFirebaseUser(userCredential.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email & password


  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('auth: '+e.toString());
      return null;
    }
  }

  // register with email & password


  // reset password


}