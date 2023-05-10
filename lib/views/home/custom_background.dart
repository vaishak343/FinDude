import 'package:flutter/material.dart';

class CustomBackground extends CustomPainter {
  CustomBackground({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.moveTo(size.width, size.height);
    path.cubicTo(
      size.width - 200,
      size.height,
      size.width - 200,
      size.height,
      0,
      size.height - 200,
    );

    path.lineTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);

    path.close();

    Paint paintFill = Paint()..style = PaintingStyle.fill;
    paintFill.color = color;
    canvas.drawPath(path, paintFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
