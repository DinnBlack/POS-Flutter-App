import 'package:flutter/material.dart';
import '../constants/constants.dart';

class AppTextStyle {
  static TextStyle light(double size, [Color color = kColorBlack, bool isItalic = false]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w100,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal, // Add italic option
    );
  }

  static TextStyle regular(double size, [Color color = kColorBlack, bool isItalic = false]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w300,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal, // Add italic option
    );
  }

  static TextStyle medium(double size, [Color color = kColorBlack, bool isItalic = false]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w500,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal, // Add italic option
    );
  }

  static TextStyle semibold(double size, [Color color = kColorBlack, bool isItalic = false]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w700,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal, // Add italic option
    );
  }

  static TextStyle bold(double size, [Color color = kColorBlack, bool isItalic = false]) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: FontWeight.w900,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal, // Add italic option
    );
  }
}
