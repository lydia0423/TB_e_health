import 'package:flutter/material.dart';
import 'package:tb_e_health/screens/authenticate/authenticate.dart';
import 'package:tb_e_health/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // listen to changes, return home or authenticate widget
    return Authenticate();

  }
}

