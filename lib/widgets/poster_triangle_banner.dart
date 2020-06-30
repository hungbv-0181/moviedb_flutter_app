import 'package:flutter/material.dart';
import 'dart:math';

class PosterTriangleBanner extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    final bounds = Rect.fromLTWH(0, 2*size.height/3, size.width, size.height/3);
    final paint = Paint()..color = Colors.white;
    final path = Path()
      ..moveTo(bounds.left, bounds.bottom)
      ..lineTo(bounds.left, bounds.top)
      ..lineTo(bounds.right, bounds.bottom)
      ..lineTo(bounds.left, bounds.bottom)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PosterTriangleBanner oldDelegate) {
    return false;
  }
}
