import 'package:flutter/material.dart';

class ResponsiveHelper {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double fontSize(BuildContext context, double size) {
    return screenWidth(context) * (size / 100);
  }

  static double dynamicWidth(BuildContext context, double percent) {
    return screenWidth(context) * (percent / 100);
  }

  static double dynamicHeight(BuildContext context, double percent) {
    return screenHeight(context) * (percent / 100);
  }
}
