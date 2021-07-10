import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Text(
              "Circuit Solver",
              style: GoogleFonts.mPlusRounded1c(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 60.sp,
                ),
              ),
            ),
            Lottie.asset('assets/main_lottie.json'),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF421c4b),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.upload_outlined),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Upload Image",
                        style: GoogleFonts.mPlusRounded1c(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 38.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
