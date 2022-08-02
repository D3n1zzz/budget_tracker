import 'package:flutter/material.dart';

class ThemeConstants {
  ThemeConstants._();

  static final textButtonThemeData = TextButtonThemeData(
      style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 18,
            fontFamily: 'Montserrat',
          )));
}
