import 'package:flutter/material.dart';

class appSettings {
  TextStyle get defaultTextStyle {
    return TextStyle(
        fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black);
  }

  TextStyle get titleTextStyle {
    return TextStyle(
        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white);
  }

  TextStyle get hintTextStyle {
    return TextStyle(
        fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black);
  }

  Widget? get ItemCard {
    return Text('Test');
  }
}
