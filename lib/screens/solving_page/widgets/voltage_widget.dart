import 'package:flutter/material.dart';

class VoltageSource extends StatelessWidget {
  final List<double> topLeft;
  final double width;
  final double height;
  final double canvasWidth;
  final double canvasHeight;


  VoltageSource({required this.topLeft,
    required this.width,
    required this.height,
    required this.canvasWidth,
    required this.canvasHeight,
  } );

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: topLeft[0] * canvasWidth,
      top: topLeft[1] * canvasHeight,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[400],
        ),
        width: width * canvasWidth,
        height: height * canvasHeight,
      ),
    );
  }
}
