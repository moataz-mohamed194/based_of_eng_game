import 'package:flutter/material.dart';

import '../../../core/phonetics_color.dart';

class FinalMatchingPainter extends CustomPainter {
  final List<List<Offset?>> firstPosition;

  FinalMatchingPainter(this.firstPosition);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < firstPosition.length; i++) {
      if (firstPosition[i].isNotEmpty &&
          firstPosition[i].first != null &&
          firstPosition[i].last != null) {
        final paint = Paint()
          ..color = AppColorPhonetics.darkBlueColor
          ..strokeWidth = 4.0
          ..strokeCap = StrokeCap.round;

        canvas.drawLine(firstPosition[i].first!, firstPosition[i].last!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
