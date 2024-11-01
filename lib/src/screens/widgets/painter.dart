import 'package:flutter/material.dart';
import 'package:tots_test/src/extensions/sizer.dart';
import 'package:tots_test/src/utils/colors.dart';

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = colorE4F353
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    double dashWidth = 5; // Largo de cada segmento
    double dashSpace = 5; // Espacio entre segmentos

    // Radio del círculo (ligeramente mayor al del CircleAvatar)
    double radius = size.width * .45.w + 10;

    // Dibujar líneas discontinuas en el círculo
    double circumference = 2 * 3.14159265359 * radius;
    double dashCount = circumference / (dashWidth + dashSpace);

    for (int i = 0; i < dashCount; i++) {
      double startAngle = i * (dashWidth + dashSpace) / radius;
      double endAngle = startAngle + dashWidth / radius;

      canvas.drawArc(
        Rect.fromCircle(
            center: Offset(size.width * 0.5, size.height * 0.5),
            radius: radius),
        startAngle,
        endAngle - startAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
