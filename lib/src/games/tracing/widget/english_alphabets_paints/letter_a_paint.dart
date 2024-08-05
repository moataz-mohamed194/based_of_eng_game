import 'dart:ui';

import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/letter_s4.dart';
import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class ALetterPaint extends FlipBookPainterLetterS4Test {
  ALetterPaint({required super.customPaths, required super.currentPathIndex});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < customPaths.length; i++) {
      var model = customPaths[i];

      // Check if the indexPath is not null, and draw it if present

      // Parse and shift the outer path, applying the scaling factor
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
        Path indexPath = parseSvgPath(model.indexPathModel!.indexPathPath!)
            .shift(model.startPoint);

        final indexPaint = Paint()..color = Colors.white;

        canvas.drawPath(indexPath, indexPaint);
      }

      if (i >= currentPathIndex && model.dottedPathModel != null) {
        // Draw the dotted path
        Path dottedPath = parseSvgPath(model.dottedPathModel!.dottedPath!)
            .shift(model.startPoint);

        final dottedPaint = Paint()
          ..color = AppColorPhonetics.greyColor
          ..style = PaintingStyle.fill;
        canvas.drawPath(dottedPath, dottedPaint);
      }

      // Check if the current path index is within valid bounds and points list is empty
      // model.points.clear();
      if (i == currentPathIndex &&
          i > 0 &&
          model.exteraFillPoint != null &&
          currentPathIndex < customPaths.length &&
          model.points.isEmpty) {
        // Add a point at the start of the current path
        model.points.add(model.exteraFillPoint!);
      }

      // Draw the filled half-circle paths on top
      if (i <= currentPathIndex && i != customPaths.length - 1) {
        final drawingPaint = Paint()
          ..color = AppColorPhonetics.lightBlueColor4
          ..style = PaintingStyle.fill // Use fill style for the half-circle
          ..strokeCap = StrokeCap.round;

        for (int j = 0; j < model.points.length; j++) {
          final point = model.points[j];
          final centerX = point.dx;
          final centerY = point.dy;

          // Define the radius as half the height of the outer path
          final radius = pathHeight;

          // Draw the filled half-circle based on direction
          drawHalfCircle(
            canvas: canvas,
            centerX: centerX,
            centerY: centerY,
            radius: radius,
            direction: model.fillDirection,
            paint: drawingPaint,
            outerPath: outerPath,
            size: size,
          );
        }
      }

      if (i == customPaths.length - 1) {
        // print(model.points.toString());
        final strokePaint = Paint()
          ..color = AppColorPhonetics.lightBlueColor4
          ..style = PaintingStyle.stroke // Use stroke style for lines
          ..strokeCap = StrokeCap.round
          ..strokeWidth = bounds.width + 20; // Adjust stroke width as needed

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
}
