import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatTime(DateTime dateTime) {
    return DateFormat('dd.MM.yyyy').format(dateTime);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }

  static void pushWidget(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }
}
