import 'package:circuit_project/circuit_page.dart';
import 'package:circuit_project/upload_image.dart';
import 'package:circuit_project/utils/tools.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.deepPurple, // status bar color
    statusBarBrightness: Brightness.light, //status bar brightness
    statusBarIconBrightness: Brightness.light, //status barIcon Brightness
  ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: isMobile() ? Size(640, 1136) : Size(1536, 2048),
      builder: () => MaterialApp(
        navigatorKey: navKey,
        home: UploadImage(),
        title: 'Circuit Solver',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
      ),
    );
  }
}
