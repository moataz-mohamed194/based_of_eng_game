import 'dart:ui';

import 'package:based_of_eng_game/src/core/phonetics_color.dart';

enum Direction {
  xPositive,
  xNegative,
  yPositive,
  yNegative,
  arc
}

class PathProviderModel {

  final DottedPathModel? dottedPathModel;
    final IndexPathModel? indexPathModel;

  final String path;
  final Offset startPoint;
  final double strokeWidth;
  final int index;
  List<Offset> points = []; // List to track points for this path
  final Direction fillDirection;

  final Offset? exteraFillPoint;

  Offset startPointOfShape;

  Offset endOffset;
bool isDotFill;
  PathProviderModel( {
    this.dottedPathModel, this.indexPathModel,
    required this.startPointOfShape,
    required this.endOffset,
    this.exteraFillPoint, 
    required this.fillDirection,
    required this.path,
    required this.startPoint,
    required this.strokeWidth,
    this.isDotFill =false,
    required this.index,
  });
}

class DottedPathModel {
  final String dottedPath;
  final Color dottedPathColor;

  DottedPathModel({required this.dottedPath,  this.dottedPathColor=AppColorPhonetics.greyColor});
}

class IndexPathModel {
  final String indexPathPath;
  final Color indexPathColor;

  IndexPathModel({required this.indexPathPath,  this.indexPathColor=AppColorPhonetics.white});
}
