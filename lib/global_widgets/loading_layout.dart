import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';



class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0,),
            child: Container(
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('assets/loading.json'),
            Text("Uploading and solving Circuit",style: TextStyle(fontSize: 18),)
          ],
        )
      ],
    );
  }
}
