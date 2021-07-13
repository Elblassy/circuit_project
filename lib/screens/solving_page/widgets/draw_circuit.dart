import 'package:flutter/material.dart';

class DrawCircle extends CustomPainter {
  final double xCenter;
  final double yCenter;
  final double height;
  final int index;
  final int selectedIndex;

  DrawCircle(
      {required this.xCenter,
      required this.yCenter,
      required this.height,
      required this.index,
      required this.selectedIndex});

  // ..strokeWidth = 16
  // ..style = PaintingStyle.stroke;
  @override
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = index == selectedIndex ? Colors.red : Colors.grey;
    canvas.drawCircle(Offset(xCenter, yCenter), height / 2, paint1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
