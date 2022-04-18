import 'package:flutter/cupertino.dart';

class Validator{
  Validator.__();

  static String? validateEmail(BuildContext context, String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Enter valid email';
    } else {
      return null;
    }
  }
  static String? validatePassword(BuildContext context, String value) {
    if (value.length < 8) {
      return '';
    } else if (!value.contains(RegExp(r'[0-9]'))) {
      return 'must contain numbers';
    } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'must contain character';
    } else if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'must contain one capital letter';
    }
    return null;
  }
}