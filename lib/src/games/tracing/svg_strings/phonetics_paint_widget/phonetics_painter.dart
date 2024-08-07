// For JSON parsing

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class PhoneticsPainter extends CustomPainter {
  final Path letterImage;
  // final ui.Image anchorImage;
  final List<ui.Path> paths;
  final ui.Path currentDrawingPath;
  final List<Offset> pathPoints;
  final Color strokeColor;
  final Color pointColor;
  final Offset anchorPos;
  final Size viewSize;
  final List<Offset> strokePoints;
  final double? strokeWidth;
  // New parameter for letter color
  final Color letterColor;
  final Shader? letterShader; // Optional gradient shader

  PhoneticsPainter({
    required this.strokeWidth,
    required this.strokePoints,
    required this.letterImage,
    // required this.anchorImage,
    required this.paths,
    required this.currentDrawingPath,
    required this.pathPoints,
    required this.strokeColor,
    required this.pointColor,
    required this.anchorPos,
    required this.viewSize,
    required this.letterColor, // Pass the letter color
    this.letterShader, // Optional gradient shader
  });

  @override
  void paint(Canvas canvas, Size size) {
    // print('qqq');
    // Paint for the letter path
    final letterPaint = Paint()
      ..color = letterColor
      ..style = PaintingStyle.fill;

    // Apply the shader if provided
    if (letterShader != null) {
      letterPaint.shader = letterShader;
    }

    // Draw the letter path with color
    canvas.drawPath(letterImage, letterPaint);

    // Clip the canvas to the letter path to prevent drawing outside
    canvas.save();
    canvas.clipPath(letterImage);

    // Paint for the strokes
    final strokePaint = Paint()
      ..color = strokeColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = strokeWidth ?? 80;

    // Draw the stroked paths within the clipped area
    // for (var path in paths) {
    //   canvas.drawPath(path, strokePaint);
    // }

    // Draw the current drawing path
    canvas.drawPath(currentDrawingPath, strokePaint);

    // Restore the canvas state after clipping
    canvas.restore();

    // Draw the trace image if needed
    // if (traceImage != null) {
    //   paintImage(
    //     canvas: canvas,
    //     image: traceImage!,
    //     rect: Rect.fromLTWH(0, 0, size.width, size.height),
    //     fit: BoxFit.fill,
    //   );
    // }

    // Paint for the path points
    final pointPaint = Paint()
      ..color = pointColor
      ..style = PaintingStyle.fill;

    // Draw the points on the path
    // for (var point in pathPoints) {
    //   canvas.drawCircle(point, 10, pointPaint);
    // }

    // Paint for the anchor image

    // Draw the anchor image
    // canvas.drawImageRect(
    //   anchorImage,
    //   Rect.fromLTWH(
    //       0, 0, anchorImage.width.toDouble(), anchorImage.height.toDouble()),
    //   Rect.fromCenter(center: anchorPos, width: 50, height: 50),
    //   anchorPaint,
    // );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
