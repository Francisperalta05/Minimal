import 'package:flutter/material.dart';
import 'package:tots_test/src/utils/colors.dart';

class CircleBackground extends StatelessWidget {
  final double size;

  const CircleBackground({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            colorE4F353,
            Colors.white.withOpacity(0),
          ],
          stops: const [0.5, 1],
          radius: .55,
        ),
      ),
    );
  }
}
