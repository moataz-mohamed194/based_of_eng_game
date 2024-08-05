import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:based_of_eng_game/src/games/tracing/manager/tracing_cubit.dart';
import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class PathHelper {
  static mainAddPoint(DragUpdateDetails details, TracingCubit cubit,
      TracingInitial stateOfGame, BuildContext context) {
    if (stateOfGame.currentDrawingIndex <
        stateOfGame.stateOfGame.basicData!.pathsModels.length) {
      RenderBox renderBox = context.findRenderObject() as RenderBox;
      Offset localPosition = renderBox.globalToLocal(details.globalPosition);
      final currentModel = stateOfGame
          .stateOfGame.basicData!.pathsModels[stateOfGame.currentDrawingIndex];
      final path =
          parseSvgPath(currentModel.path).shift(currentModel.startPoint);
print('local pointt'+localPosition.toString());
      if (path.contains(localPosition) &&
          isStartedFromStartPoint(
              fillDirection: currentModel.fillDirection,
              points: currentModel.points,
              startPoint: currentModel.startPointOfShape,
              newPoint: localPosition)) {
        cubit.saveCurrentPosition(
          currentModel: currentModel,
          point: localPosition,
        );

        PathHelper.removeDuplicatePoints(currentModel.points);
        PathHelper.checkPathCompletion(
          factor: 40,
          currentPathIndex: stateOfGame.currentDrawingIndex,
          customPaths: stateOfGame.stateOfGame.basicData!.pathsModels,
          tracingCubit: cubit,
        );
      }
    }
  }


  static bool isStartedFromStartPoint({
    required List<Offset> points,
    required Offset startPoint,
    required Offset newPoint,
    required Direction fillDirection,
    double tolerance = 50.0,
    double toleranceIncrementFactor = 5.0,
  }) {
    // points.clear();
    if (points.isEmpty) {
      // Check the direction of the first point relative to the startPoint
      bool isInCorrectDirection;
      switch (fillDirection) {
        case Direction.xPositive:
          isInCorrectDirection = (newPoint.dx > startPoint.dx);
          break;
        case Direction.xNegative:
          isInCorrectDirection = (newPoint.dx < startPoint.dx);
          break;
        case Direction.yPositive:
          isInCorrectDirection = (newPoint.dy > startPoint.dy);
          break;
        case Direction.yNegative:
          isInCorrectDirection = (newPoint.dy < startPoint.dy);
          break;
        case Direction.arc:
          isInCorrectDirection = true; // Placeholder logic for arc
          break;
        default:
          isInCorrectDirection = false;
      }
      double distanceToStart = (startPoint - newPoint).distance;
      print('isInCorrectDirection: $isInCorrectDirection');
      print('Distance to startPoint: $distanceToStart');
      print('Tolerance: $tolerance');

      return isInCorrectDirection &&
          (startPoint - newPoint).distance <= tolerance;
    } else {
      print('zoz');
      Offset lastPoint = points.last;
      double dynamicTolerance =
          tolerance + points.length * toleranceIncrementFactor;

      bool isNotInExcludedDirection;
      switch (fillDirection) {
        case Direction.xPositive:
          isNotInExcludedDirection = (newPoint.dx <= lastPoint.dx);
          break;
        case Direction.xNegative:
          isNotInExcludedDirection = (newPoint.dx >= lastPoint.dx);
          break;
        case Direction.yPositive:
          isNotInExcludedDirection = (newPoint.dy <= lastPoint.dy);
          break;
        case Direction.yNegative:
          isNotInExcludedDirection = (newPoint.dy >= lastPoint.dy);
          break;
        case Direction.arc:
          isNotInExcludedDirection = true; // Placeholder logic for arc
          break;
        default:
          isNotInExcludedDirection = false;
      }

      bool isCloseToLastPoint =
          (newPoint - lastPoint).distance <= dynamicTolerance;
      print('1-->' + isCloseToLastPoint.toString());
      print('2-->' + isNotInExcludedDirection.toString());
      print('pointss--->' + points.toString());
      print('pointy--->' + newPoint.toString());

      return isCloseToLastPoint && isNotInExcludedDirection;
    }
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

  static bool isConsecutive(List<Offset> points, double tolerance) {
    for (int i = 1; i < points.length; i++) {
      if ((points[i] - points[i - 1]).distance > tolerance) {
        return false;
      }
    }
    return true;
  }

  static bool isPointWithinFactor({
    required Offset point,
    required Offset endPoint,
    required double factor,
  }) {
    double distance =
        sqrt(pow(point.dx - endPoint.dx, 2) + pow(point.dy - endPoint.dy, 2));
    return distance <= factor;
  }

  static void checkPathCompletion({
    required int currentPathIndex,
    required List<PathProviderModel> customPaths,
    required TracingCubit tracingCubit,
    required double factor,
  }) {
    if (currentPathIndex < customPaths.length) {
      final currentModel = customPaths[currentPathIndex];
      Path currentPath =
          parseSvgPath(currentModel.path).shift(currentModel.startPoint);



      double pathLength = 0.0;
      double coveredLength = 0.0;
      Offset? lastPoint;

      bool isComplete = false;
      bool checkpointReached = false;

      for (PathMetric metric in currentPath.computeMetrics()) {
        pathLength += metric.length;

        for (var point in currentModel.points) {
          if (currentPath.contains(point)) {
            if (lastPoint != null) {
              coveredLength += (point - lastPoint).distance;
            }
            lastPoint = point;

            final endPoint = customPaths[currentPathIndex].endOffset;
            if (endPoint != null) {
              if (isPointWithinFactor(
                  point: point, endPoint: endPoint, factor: factor)) {
                checkpointReached = true;
                break;
              }
            }
          }
        }

        if (lastPoint != null) {
          coveredLength +=
              (metric.getTangentForOffset(metric.length)?.position ?? lastPoint)
                  .distance;
        }

        if (checkpointReached) {
          isComplete = true;
          break;
        }
      }

      if (isComplete || checkpointReached) {
        print('Path ${currentPathIndex + 1} completed');
        PathHelper.changeIndex(
    currentPathIndex: currentPathIndex,
    customPaths: customPaths,
    tracingCubit: tracingCubit,
  );
      } else {
        print('Path ${currentPathIndex + 1} not yet completed');
      }
    }
  }

 static void changeIndex({    required int currentPathIndex,
    required List<PathProviderModel> customPaths,
    required TracingCubit tracingCubit,}){
            final currentModel = customPaths[currentPathIndex];

       if (currentPathIndex < customPaths.length - 1) {
          tracingCubit.shiftIndex(
              index: ++currentPathIndex, point: currentModel.endOffset);
        } else {
          tracingCubit.gameFinished(
              index: customPaths.length, endOffset: currentModel.endOffset);
          print('All paths completed');
        }
  }
}
