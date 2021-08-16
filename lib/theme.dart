
import 'package:flutter/material.dart';

final helloTheme = ThemeData(
  // This is the theme of your application.
  //
  // Try running your application with "flutter run". You'll see the
  // application has a blue toolbar. Then, without quitting the app, try
  // changing the primarySwatch below to Colors.green and then invoke
  // "hot reload" (press "r" in the console where you ran "flutter run",
  // or simply save your changes to "hot reload" in a Flutter IDE).
  // Notice that the counter didn't reset back to zero; the application
  // is not restarted.
  primarySwatch: MaterialColor(0xFF332F1F, {
    50: Color(0xFF332F1F),
    100: Color(0xFF332F1F),
    200: Color(0xFF332F1F),
    300: Color(0xFF332F1F),
    400: Color(0xFF332F1F),
    500: Color(0xFF332F1F),
    600: Color(0xFF332F1F),
    700: Color(0xFF332F1F),
    800: Color(0xFF332F1F),
    900: Color(0xFF332F1F),
  }),
  appBarTheme: AppBarTheme(
    elevation: 0, // This removes the shadow from all App Bars.
  ),
  primaryColor: Color(0xFF332F1F), // DC6262, 332F1F
  backgroundColor: Colors.white,
  cardColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    )
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        )
      ),
    )
  ),
);