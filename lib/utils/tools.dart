import 'package:flutter/material.dart';


final GlobalKey<NavigatorState> navKey = new GlobalKey<NavigatorState>();

bool isMobile() {
  final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
  return data.size.shortestSide < 600;
}