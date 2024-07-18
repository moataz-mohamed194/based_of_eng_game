import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:flutter/material.dart';

class LinePainter extends CustomPainter {
  Offset? start;
  Offset? end;
  LinePainter(this.start, this.end);
  @override
  void paint(Canvas canvas, Size size) {
    if (start == null || end == null) {
      return;
    }
    if (start != null && end != null) {
      canvas.drawLine(
          start!,
          end!,
          Paint()
            ..strokeWidth = 4
            ..color = AppColorPhonetics.darkBlueColor);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
