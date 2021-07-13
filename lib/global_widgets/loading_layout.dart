import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({required this.loadingText});

  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 6.0,
              sigmaY: 6.0,
            ),
            child: Container(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/loading.json'),
            Text(
              loadingText,
              style: GoogleFonts.mPlusRounded1c(
                textStyle: TextStyle(
                  decoration: TextDecoration.none,
                  color: Colors.black,
                  fontSize: 30.sp,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
