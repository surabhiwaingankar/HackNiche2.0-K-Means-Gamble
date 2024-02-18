import 'package:flutter/material.dart';

class GlobalVariables {
  static const url = "http://127.0.0.1:5000";
  static const String tagline =
      "Unleash Infinite Potential with AI-Driven Function Generation";
  static const String description =
      "Empower your coding journey with our AI Function Generator. Tailored solutions, precise algorithms, no trial and error. Revolutionize your approach to coding with AI innovation.";
  static const String versionControlTitle = "Manage your GitHub account easily";
  static const colorEnabled = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(0, 124, 239, 1),
        Color.fromRGBO(84, 255, 101, 1),
      ],
      stops: [
        0.3,
        1
      ]);
  static const colorDisabled = LinearGradient(colors: [
    Colors.transparent,
    Colors.transparent,
  ], stops: [
    0.5,
    1
  ]);
  static const colorDisabledAlternate = LinearGradient(colors: [
    Colors.transparent,
    Colors.transparent,
  ], stops: [
    0.5,
    1
  ]);
}
