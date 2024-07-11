import 'package:flutter/material.dart';

class ModeClass {
  static final lightMode=ThemeData(
    useMaterial3: true,
    primarySwatch: Colors.amber,

    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.white,
        primary: Colors.deepOrange
    ),



  );

  static final darkMode=ThemeData(
    useMaterial3: true,

    colorScheme: ColorScheme.dark(
        surface: Colors.grey,
        primary: Colors.grey.shade900
    ),

    primarySwatch: Colors.brown,


    brightness:Brightness.dark ,

  );
}