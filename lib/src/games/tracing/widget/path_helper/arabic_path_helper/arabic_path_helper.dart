import 'package:based_of_eng_game/src/games/tracing/manager/tracing_cubit.dart';
import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/path_helper/path_helper.dart';
import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class ArabicShapePathHelper extends PathHelper {
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
      print('local pointt' + localPosition.toString());

if(currentModel.isDotFill &&path.contains(localPosition)){
     cubit.saveCurrentPosition(
          currentModel: currentModel,
          point: localPosition,
        );
       PathHelper.changeIndex(
    currentPathIndex: stateOfGame.currentDrawingIndex,
    customPaths: stateOfGame.stateOfGame.basicData!.pathsModels,
    tracingCubit: cubit,
  );
}else
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

        // to check last stroke
      }
    }
  }

  static bool checkStrokeOnly({
    required List<Offset> points,
    required Offset startPoint,
    required Offset newPoint,
    required Direction fillDirection,
    double tolerance = 0.0,
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

      return isInCorrectDirection &&
          (startPoint - newPoint).distance <= tolerance;
    } else {
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

      return isCloseToLastPoint && isNotInExcludedDirection;
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

      return isInCorrectDirection &&
          (startPoint - newPoint).distance <= tolerance;
    } else {
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

      return isCloseToLastPoint && isNotInExcludedDirection;
    }
  }
}
