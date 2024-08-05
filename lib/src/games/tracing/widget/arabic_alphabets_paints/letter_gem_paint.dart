import 'dart:math';
import 'dart:ui';

import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/letter_s4.dart';
import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class GemLetterPaint extends FlipBookPainterLetterS4Test {
  GemLetterPaint({required super.customPaths, required super.currentPathIndex});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < customPaths.length; i++) {
      var model = customPaths[i];
      // print(model.points.toString());
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

      // Draw the filled half-circle paths on top
      if (i <= currentPathIndex) {
        final drawingPaint = Paint()
          ..color = AppColorPhonetics.lightBlueColor4
          ..style = PaintingStyle.fill // Use fill style for the half-circle
          ..strokeCap = StrokeCap.round
          ..strokeWidth = bounds.width + 50; // Adjust stroke width as needed

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
    }
  }

  void drawHalfCircle({
    required Canvas canvas,
    required double centerX,
    required double centerY,
    required double radius,
    required Direction direction,
    required Paint paint,
    required Path outerPath,
    required Size size,
  }) {
    final drawingPath = Path();
    final oppositeDrawingPath = Path();

    // Define a smaller radius for the opposite half-circle
    final smallerRadius = radius * 0.5; // Adjust this factor as needed

    switch (direction) {
      case Direction.arc:
        drawingPath.addArc(
          Rect.fromCircle(
              center: Offset(centerX, centerY), radius: radius + 20),
          pi / 2, // Start angle (top of the circle)
          pi, // Sweep angle (half-circle)
        );
        oppositeDrawingPath.addArc(
          Rect.fromCircle(
              center: Offset(centerX, centerY), radius: smallerRadius),
          -pi / 2, // Opposite half-circle (bottom of the circle)
          pi, // Sweep angle (half-circle)
        );
        break;
        break;
      case Direction.xNegative:
        drawingPath.addArc(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          pi / 2, // Start angle (top of the circle)
          pi, // Sweep angle (half-circle)
        );
        oppositeDrawingPath.addArc(
          Rect.fromCircle(
              center: Offset(centerX, centerY), radius: smallerRadius),
          -pi / 2, // Opposite half-circle (bottom of the circle)
          pi, // Sweep angle (half-circle)
        );
        break;
      case Direction.xPositive:
        drawingPath.addArc(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          -pi / 2, // Start angle (bottom of the circle)
          pi, // Sweep angle (half-circle)
        );
        oppositeDrawingPath.addArc(
          Rect.fromCircle(
              center: Offset(centerX, centerY), radius: smallerRadius),
          pi / 2, // Opposite half-circle (top of the circle)
          pi, // Sweep angle (half-circle)
        );
        break;
      case Direction.yPositive:
        drawingPath.addArc(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          -pi, // Start angle (left of the circle)
          pi, // Sweep angle (half-circle)
        );
        oppositeDrawingPath.addArc(
          Rect.fromCircle(
              center: Offset(centerX, centerY), radius: smallerRadius),
          0, // Opposite half-circle (right of the circle)
          pi, // Sweep angle (half-circle)
        );
        break;
      case Direction.yNegative:
        drawingPath.addArc(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          0, // Start angle (right of the circle)
          -pi, // Sweep angle (half-circle)
        );
        oppositeDrawingPath.addArc(
          Rect.fromCircle(
              center: Offset(centerX, centerY), radius: smallerRadius),
          -pi, // Opposite half-circle (left of the circle)
          pi, // Sweep angle (half-circle)
        );
        break;
    }

    // Clip the path to ensure the stroke stays within bounds
    canvas.saveLayer(Rect.fromLTWH(0, 0, size.width, size.height), Paint());
    canvas.clipPath(outerPath);

    // Draw the filled half-circle
    canvas.drawPath(drawingPath, paint);

    // Draw the opposite half-circle with the smaller radius
    canvas.drawPath(oppositeDrawingPath, paint);

    // Restore canvas
    canvas.restore();
  }
}
