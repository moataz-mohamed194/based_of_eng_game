import 'dart:ui';

import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/letter_s4.dart';
import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class MLetterPaint extends FlipBookPainterLetterS4Test {
  MLetterPaint({required super.customPaths, required super.currentPathIndex});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < customPaths.length; i++) {
      var model = customPaths[i];

      // Parse and shift the outer path, applying the scaling factor
      Path outerPath = parseSvgPath(model.path).shift(model.startPoint);

      // Calculate the bounding box of the outer path
      final bounds = outerPath.getBounds();
      final pathWidth = bounds.width;

      // Draw the outer path with fill color
      final fillPaint = Paint()
        ..color = currentPathIndex > i
            ? AppColorPhonetics.lightBlueColor4
            : AppColorPhonetics.lightBlueColor2
        ..style = PaintingStyle.fill;

      // Draw the outer path
      canvas.drawPath(outerPath, fillPaint);

      // Draw the index path if present
      if (i >= currentPathIndex && model.indexPathModel != null) {
        Path indexPath = parseSvgPath(model.indexPathModel!.indexPathPath!)
            .shift(model.startPoint);

        final indexPaint = Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke;
        canvas.drawPath(indexPath, indexPaint);
      }

      // Draw the dotted path if present
      if (i >= currentPathIndex && model.dottedPathModel != null) {
        Path dottedPath = parseSvgPath(model.dottedPathModel!.dottedPath!)
            .shift(model.startPoint);

        final dottedPiant = Paint()
          ..color = model.indexPathModel!.indexPathColor
          ..style = PaintingStyle.stroke;
        canvas.drawPath(dottedPath, dottedPiant);
      }

      // Clip the canvas only for the current path index
      if (i <= currentPathIndex) {
        // Save the canvas state before clipping
        canvas.save();

        // Clip the canvas to the outer path to ensure drawing stays inside it
        canvas.clipPath(outerPath);

        // Draw the rounded-cap paths inside the clipped area
        final drawingPaint = Paint()
          ..color = AppColorPhonetics.lightBlueColor4
          ..style = PaintingStyle.stroke // Use stroke style
          ..strokeCap = StrokeCap.round // Set rounded caps
          ..strokeWidth = pathWidth + 30; // Use path width as the stroke width

        final path = Path();
        for (int j = 0; j < model.points.length; j++) {
          final point = model.points[j];
          if (j == 0) {
            path.moveTo(point.dx, point.dy); // Move to the first point
          } else {
            path.lineTo(point.dx, point.dy); // Draw lines to subsequent points
          }
        }

        // Draw the path with rounded caps inside the clipped area
        canvas.drawPath(path, drawingPaint);

        // Restore the canvas to remove the clipping
        canvas.restore();
      }
    }
  }
}
