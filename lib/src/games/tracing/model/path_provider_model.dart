
import 'dart:ui';
enum Direction {
  xPositive,
  xNegative,
  yPositive,
  yNegative,
}
class PathProviderModel {
  final String path;
  final Offset startPoint;
  final double strokeWidth;
  final int index;
  List<Offset> points = []; // List to track points for this path
final double finishRatio;
final int pointsLimitToRatio;
final Offset startPaintingOffset;
final Direction fillDirection;
  final String dottedPath;


  PathProviderModel( {
    required this.fillDirection,
    required this.dottedPath,

 required   this.startPaintingOffset,
        required this.finishRatio,
        required this.pointsLimitToRatio,

    required this.path,
    required this.startPoint,
    required this.strokeWidth,
    required this.index,
  });
}