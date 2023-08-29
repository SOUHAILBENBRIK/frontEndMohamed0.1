import 'package:flutter/material.dart';

class AppConst {
  static getHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
  static getWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }
}
