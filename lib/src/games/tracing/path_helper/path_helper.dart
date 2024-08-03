import 'dart:ui';
import 'package:based_of_eng_game/src/games/tracing/manager/tracing_cubit.dart';
import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';
import 'dart:math' as math;

import 'package:svg_path_parser/svg_path_parser.dart';
import 'package:vector_math/vector_math_64.dart';

class PathHelper {
  static bool checkConsecutiveAndDirection({
    required List<Offset> points,
    required Offset startPoint,
    required Offset newPoint,
    double tolerance = 70.0,
    double directionThreshold = 30.0,
  }) {
    if (points.isEmpty) {
      return (startPoint - newPoint).distance <= tolerance;
    } else {
      Offset lastPoint = points.last;

      // bool isConsecutive = (newPoint - lastPoint).distance <= tolerance;
      // bool isSameDirection =
      //     _isSameDirection(points, newPoint, directionThreshold);

      // return isConsecutive && isSameDirection;
      return true;
    }
  }

  static bool _isSameDirection(
      List<Offset> points, Offset newPoint, double threshold) {
    if (points.length < 2) return true;

    final Vector2 lastDirection = Vector2(
      points.last.dx - points[points.length - 2].dx,
      points.last.dy - points[points.length - 2].dy,
    );

    final Vector2 newDirection = Vector2(
      newPoint.dx - points.last.dx,
      newPoint.dy - points.last.dy,
    );

    double dotProduct = lastDirection.dot(newDirection);
    double cosineAngle =
        dotProduct / (lastDirection.length * newDirection.length);

    // Convert threshold from degrees to radians manually
    double thresholdInRadians = threshold * math.pi / 180;

    // Check if the angle between the directions is within the threshold
    return cosineAngle >= math.cos(thresholdInRadians);
  }

  static void removeDuplicatePoints(List<Offset> points) {
    const double minDistance = 5.0;
    List<Offset> uniquePoints = [];

    if (points.isNotEmpty) {
      uniquePoints.add(points.first);
      for (int i = 1; i < points.length; i++) {
        if ((points[i] - uniquePoints.last).distance > minDistance) {
          uniquePoints.add(points[i]);
        }
      }
    }

    points.clear();
    points.addAll(uniquePoints);
  }

  static bool isOppositeDirection(List<Offset> points, Offset newPoint) {
    if (points.length < 2) return false;

    final Vector2 lastDirection = Vector2(
      points.last.dx - points[points.length - 2].dx,
      points.last.dy - points[points.length - 2].dy,
    );

    final Vector2 newDirection = Vector2(
      newPoint.dx - points.last.dx,
      newPoint.dy - points.last.dy,
    );

    double dotProduct = lastDirection.dot(newDirection);
    double cosineAngle =
        dotProduct / (lastDirection.length * newDirection.length);

    double threshold = 0.7;
    return cosineAngle < -threshold;
  }

  static bool isConsecutive(List<Offset> points, double tolerance) {
    for (int i = 1; i < points.length; i++) {
      if ((points[i] - points[i - 1]).distance > tolerance) {
        return false;
      }
    }
    return true;
  }

  static void checkPathCompletion({
  required int currentPathIndex,
  required List<PathProviderModel> customPaths,
  required TracingCubit tracingCubit,
  double minDistanceThreshold = 5.0, // Adjust this value as needed
}) {
  if (currentPathIndex >= customPaths.length) return;

  final currentModel = customPaths[currentPathIndex];
  Path currentPath =
      parseSvgPath(currentModel.path).shift(currentModel.startPoint);

  final int minPointsThreshold = currentModel.pointsLimitToRatio;

  if (currentModel.points.length < minPointsThreshold) {
    print('Not enough points drawn yet');
    return;
  }

  double totalPathLength = 0.0;
  double coveredLength = 0.0;
  Offset? lastValidPoint;

  // Compute the total path length using the metrics
  for (PathMetric metric in currentPath.computeMetrics()) {
    totalPathLength += metric.length;
  }

  // Traverse the path and measure the covered length with a minimum distance threshold
  for (var point in currentModel.points) {
    if (currentPath.contains(point)) {
      if (lastValidPoint != null) {
        double distance = (point - lastValidPoint).distance;
        if (distance >= minDistanceThreshold) {
          coveredLength += distance;
          lastValidPoint = point;
        }
      } else {
        lastValidPoint = point;
      }
    }
  }

  // Calculate the coverage ratio
  double coverageRatio = coveredLength / totalPathLength;

  print('Path ${currentPathIndex + 1} Coverage ratio: $coverageRatio');

  // Check if the path is complete
  if (coverageRatio >= currentModel.finishRatio) {
    print('Path ${currentPathIndex + 1} completed');
    if (currentPathIndex < customPaths.length - 1) {
      tracingCubit.shiftIndex(index: ++currentPathIndex);
    } else {
      tracingCubit.gameFinished(index: customPaths.length);
      print('All paths completed');
    }
  } else {
    print('Path ${currentPathIndex + 1} not yet completed');
  }
}

}
