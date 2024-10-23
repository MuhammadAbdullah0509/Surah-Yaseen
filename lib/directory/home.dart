import 'package:quran/styles.dart';
import 'package:flutter/material.dart';

class MyTheme {
  static ThemeData darktheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
    brightness: Brightness.dark,
    primaryColor: Colors.white,
    dialogBackgroundColor: const Color(0xff2e2e2e),
    canvasColor: Colors.blue,
    cardColor: Colors.grey,
    shadowColor: Colors.black87,
    focusColor: Colors.black,
    dividerColor: const Color(0xff2e2e2e),
    highlightColor: Colors.white,
    primaryColorLight: Colors.white,
    //cursorColor: Colors.blue.shade800,
  );

  static final lighttheme = ThemeData(
    colorScheme: const ColorScheme.light(),
    brightness: Brightness.light,
    dialogBackgroundColor: Colors.white,
    primaryColor: const Color(0xff174780),
    canvasColor: Colors.blue,
    cardColor: Colors.grey,
    dividerColor: Styles.appbar,
    shadowColor: Colors.white70,
    focusColor: Colors.white,
    highlightColor: Colors.black,
    primaryColorLight: Colors.white,
    //canvasColor: Colors.blue.shade200,
  );
}
