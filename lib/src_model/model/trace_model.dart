import 'dart:ui';

import 'package:flutter/material.dart';

class TraceModel {
  final String letterPath;
  final String pointsJsonFile;
  // final Color pointColor;
  final String dottedPath;
  final String indexPath;

  final Color outerPaintColor;
  final Color innerPaintColor;
  final Color dottedColor;
  final Color indexColor;
  final double strokeWidth;

final PaintingStyle? indexPathPaintStyle;
final PaintingStyle? dottedPathPaintStyle;

final Size? poitionIndexPath;
final Size? poitionDottedPath;
final double? scaleIndexPath;
final double? scaledottedPath;

  TraceModel({
    this.scaledottedPath,
    this.scaleIndexPath,
    this.poitionIndexPath,    this.poitionDottedPath,

    this.indexPathPaintStyle,
    this.dottedPathPaintStyle,
    this.strokeWidth=55,
     this.indexColor = Colors.black,
    this.outerPaintColor = Colors.red,
    this.innerPaintColor = Colors.blue,
    this.dottedColor = Colors.amber,
    required this.dottedPath,
    required this.indexPath,
    required this.letterPath,
    required this.pointsJsonFile,
    // required this.pointColor,

  });
}
