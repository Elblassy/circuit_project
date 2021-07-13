import 'package:flutter/material.dart';

class Resistance extends StatelessWidget {
  final List<double> topLeft;
  final double width;
  final double height;
  final double canvasWidth;
  final double canvasHeight;
  final int index;
  final int selectedIndex;

  Resistance(
      {required this.topLeft,
        required this.width,
        required this.height,
        required this.canvasWidth,
        required this.canvasHeight,
        required this.index,
        required this.selectedIndex
      });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: topLeft[0] * canvasWidth,
      top: topLeft[1] * canvasHeight,
      child: Container(
        width: width * canvasWidth,
        height: height * canvasHeight,
        color: index == selectedIndex ?Colors.red :Colors.grey[400],
      ),
    );
  }
}
