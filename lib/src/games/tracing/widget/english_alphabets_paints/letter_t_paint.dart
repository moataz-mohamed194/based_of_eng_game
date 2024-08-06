import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/letter_s4.dart';

class TLetterPaint extends FlipBookPainterLetterS4Test {
  TLetterPaint({required super.customPaths, required super.currentPathIndex});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < customPaths.length; i++) {
      var model = customPaths[i];

      // Parse and shift the outer path
      Path outerPath = parseSvgPath(model.path).shift(model.startPoint);

      // Calculate the bounding box of the outer path
      final bounds = outerPath.getBounds();
      final pathHeight = bounds.height;

      // Draw the outer path with fill color
      final fillPaint = Paint()
        ..color = currentPathIndex > i
            ? AppColorPhonetics.lightBlueColor4
            : AppColorPhonetics.lightBlueColor2
        ..style = PaintingStyle.fill;

      canvas.drawPath(outerPath, fillPaint);

      if (model.indexPathModel != null) {
        Path indexPath = parseSvgPath(model.indexPathModel!.indexPathPath)
            .shift(model.startPoint);
        final indexPaint = Paint()
          ..color = model.indexPathModel!.indexPathColor;
        canvas.drawPath(indexPath, indexPaint);
      }

      if (i >= currentPathIndex && model.dottedPathModel != null) {
        // Draw the dotted path
        Path dottedPath = parseSvgPath(model.dottedPathModel!.dottedPath)
            .shift(model.startPoint);
        final dottedPaint = Paint()
          ..color = model.dottedPathModel!.dottedPathColor
          ..style = PaintingStyle.fill;
        canvas.drawPath(dottedPath, dottedPaint);
      }

      if (i == currentPathIndex &&
          i > 0 &&
          currentPathIndex < customPaths.length &&
          model.points.isEmpty) {
        // Add a point at the start of the current path
        // model.points.add(model.exteraFillPoint!);
      }

      // Draw strokes on top
      if (i <= currentPathIndex) {
        final strokePaint = Paint()
          ..color = AppColorPhonetics.lightBlueColor4
          ..style = PaintingStyle.stroke // Use stroke style for lines
          ..strokeCap = StrokeCap.round
          ..strokeWidth = i == 0
              ? bounds.width
              : bounds.height + 20; // Adjust stroke width as needed

        // Clip the canvas to the outer path
        canvas.save();
        canvas.clipPath(outerPath);

        for (int j = 0; j < model.points.length; j++) {
          final point = model.points[j];
          final centerX = point.dx;
          final centerY = point.dy;

          // Draw stroke inside the clipped path
          drawStroke(
            canvas: canvas,
            centerX: centerX,
            centerY: centerY,
            strokePaint: strokePaint,
            pathHeight: pathHeight,
          );
        }

        // Restore the canvas to its original state
        canvas.restore();
      }
    }
  }

  // Draws a stroke based on direction instead of a half-circle
  
}
