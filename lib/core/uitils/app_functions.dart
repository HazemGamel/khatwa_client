import 'package:flutter/material.dart';


class AppFunction {
  static Future<void> pushAndRemove(
    BuildContext context,
    Widget screen,
  ) async {
    await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }

  static Future<void> pushTo(
    BuildContext context,
    Widget screen,
  ) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

}
