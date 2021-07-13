import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navKey = new GlobalKey<NavigatorState>();

bool isMobile() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  return data.size.shortestSide < 600;
}

bool isNumeric(String? str) {
  if (str == null) {
    return false;
  }
  return int.tryParse(str) != null;
}
