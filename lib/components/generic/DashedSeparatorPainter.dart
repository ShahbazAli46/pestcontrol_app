import 'package:flutter/material.dart';

class DashedSeparatorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey // Set the color of the separator
      ..strokeWidth = 1; // Set the thickness of the separator

    final dashWidth = 5; // Set the width of each dash
    final dashSpace = 3; // Set the space between each dash

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}