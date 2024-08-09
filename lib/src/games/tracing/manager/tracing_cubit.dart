import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:based_of_eng_game/based_of_eng_game.dart';
import 'package:based_of_eng_game/src_model/model/letter_paths_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:svg_path_parser/svg_path_parser.dart';
import '../../../../src_model/export_models.dart';
import '../../../../src_model/model/trace_model.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/talk_tts.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import 'dart:math' as math;
part 'tracing_state.dart';

class TracingCubit extends Cubit<TracingState> {
  TracingCubit({
    required GameFinalModel gameData,
    required CurrentGamePhoneticsState stateOfGame,
    required List<TraceModel> traceLetter,
    required bool isArabic,
  }) : super(TracingState(
            gameData: gameData,
            stateOfGame: stateOfGame,
            traceLetter: traceLetter,
            letterPathsModels: [],
            isArabic: isArabic)) {
    print('inits');
    _initialize();
  }

  void _initialize() {
    emit(state.clearData());
    TalkTts.startTalk(text: state.gameData.inst ?? '');
  }

  Future<void> loadAssets(Size viewSize) async {
    emit(state.copyWith(drawingStates: DrawingStates.loading));
    print('111');
    for (var e in state.traceLetter) {
      final letterModel = e;
      final parsedPath = parseSvgPath(letterModel.letterPath);

      final dottedIndexPath = parseSvgPath(letterModel.indexPath);
      final dottedPath = parseSvgPath(letterModel.dottedPath);

      final transformedPath = _applyTransformation(
        parsedPath,
        viewSize,
      );

      final letterIndex = _applyTransformationForOtherPaths(dottedPath,
          viewSize, letterModel.poitionDottedPath, letterModel.scaledottedPath);
      final dottedIndex = _applyTransformationForOtherPaths(dottedIndexPath,
          viewSize, letterModel.poitionIndexPath, letterModel.scaleIndexPath);

      final allStrokePoints =
          await _loadPointsFromJson(letterModel.pointsJsonFile, viewSize);
      final anchorPos =
          allStrokePoints.isNotEmpty ? allStrokePoints[0][0] : Offset.zero;

      state.letterPathsModels.add(LetterPathsModel(
          strokeWidth: state.traceLetter[state.activeIndex].strokeWidth,
          dottedIndex: dottedIndex,
          letterIndex: letterIndex,
          dottedColor: state.traceLetter[state.activeIndex].dottedColor,
          indexColor: state.traceLetter[state.activeIndex].indexColor,
          innerPaintColor: state.traceLetter[state.activeIndex].innerPaintColor,
          outerPaintColor: state.traceLetter[state.activeIndex].outerPaintColor,
          allStrokePoints: allStrokePoints,
          letterImage: transformedPath,
          anchorPos: anchorPos,
          indexPathPaintStyle:
              state.traceLetter[state.activeIndex].indexPathPaintStyle,
          dottedPathPaintStyle:
              state.traceLetter[state.activeIndex].dottedPathPaintStyle));
    }

    emit(state.copyWith(
      drawingStates: DrawingStates.loaded,
    ));
  }

  Path _applyTransformation(
    Path path,
    Size viewSize,
  ) {
    // Get the bounds of the original path
    final Rect originalBounds = path.getBounds();
    final Size originalSize = Size(originalBounds.width, originalBounds.height);

    // Calculate the scale factor to fit the SVG within the view size
    final double scaleX = viewSize.width / originalSize.width;
    final double scaleY = viewSize.height / originalSize.height;
    double scale = math.min(scaleX, scaleY);
    // Calculate the translation needed to center the path within the view size
    final double translateX =
        (viewSize.width - originalSize.width * scale) / 2 -
            originalBounds.left * scale;
    final double translateY =
        (viewSize.height - originalSize.height * scale) / 2 -
            originalBounds.top * scale;

    // Create a matrix for the transformation

    Matrix4 matrix = Matrix4.identity()
      ..scale(scale, scale)
      ..translate(translateX, translateY);

    // Apply the transformation to the path
    return path.transform(matrix.storage);
  }

  Path _applyTransformationForOtherPaths(
      Path path, Size viewSize, Size? size, double? pathscale) {
    // Get the bounds of the original path
    final Rect originalBounds = path.getBounds();
    final Size originalSize = Size(originalBounds.width, originalBounds.height);

    // Calculate the scale factor to fit the SVG within the view size
    final double scaleX = viewSize.width / originalSize.width;
    final double scaleY = viewSize.height / originalSize.height;
    double scale = math.min(scaleX, scaleY);
    scale = pathscale == null ? scale : scale * pathscale;

    // Calculate the translation needed to center the path within the view size
    final double translateX =
        (viewSize.width - originalSize.width * scale) / 2 -
            originalBounds.left * scale;
    final double translateY =
        (viewSize.height - originalSize.height * scale) / 2 -
            originalBounds.top * scale;

    // Create a matrix for the transformation

    Matrix4 matrix = Matrix4.identity()
      ..scale(scale, scale)
      ..translate(translateX, translateY);

    if (size != null) {
      matrix = Matrix4.identity()
        ..scale(scale, scale)
        ..translate(translateX + size.width, translateY + size.height);
    }
    // Apply the transformation to the path
    return path.transform(matrix.storage);
  }

  Size _getOriginalSvgSize(String svgPath) {
    final parsedPath = parseSvgPath(svgPath);
    final path = Path()..addPath(parsedPath, Offset.zero);
    final bounds = path.getBounds();
    return Size(bounds.width, bounds.height);
  }

  Future<ui.Image> _loadImage(String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = data.buffer.asUint8List();
    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(bytes, (ui.Image image) {
      completer.complete(image);
    });
    return completer.future;
  }

  Future<List<List<Offset>>> _loadPointsFromJson(
      String path, Size viewSize) async {
    final jsonString = await rootBundle.loadString(path);
    //     final jsonString =

    //  jsonDecode();

    final jsonData = jsonDecode(jsonString);
    final List<List<Offset>> strokePointsList = [];

    for (var stroke in jsonData['strokes']) {
      final List<dynamic> strokePointsData = stroke['points'];
      final points = strokePointsData.map<Offset>((pointString) {
        final coords =
            pointString.split(',').map((e) => double.parse(e)).toList();
        return Offset(coords[0] * viewSize.width, coords[1] * viewSize.height);
      }).toList();
      strokePointsList.add(points);
    }

    return strokePointsList;
  }

  void handlePanStart(Offset position) {
    if (!isTracingStartPoint(position)) return;

    final currentStrokePoints =
        state.letterPathsModels[state.activeIndex].allStrokePoints[
            state.letterPathsModels[state.activeIndex].currentStroke];
    if (state.letterPathsModels[state.activeIndex].currentStrokeProgress >= 0 &&
        state.letterPathsModels[state.activeIndex].currentStrokeProgress <
            currentStrokePoints.length) {
      if (currentStrokePoints.length == 1) {
        // Special case for single-point strokes
        final singlePoint = currentStrokePoints[0];
        if (isValidPoint(singlePoint, position)) {
          // Update path and complete stroke immediately
          final newDrawingPath = state
              .letterPathsModels[state.activeIndex].currentDrawingPath
            ..lineTo(
                currentStrokePoints.first.dx, currentStrokePoints.first.dy);

          state.letterPathsModels[state.activeIndex].anchorPos = singlePoint;
          state.letterPathsModels[state.activeIndex].currentDrawingPath =
              newDrawingPath;

          completeStroke();
          return;
        }
      }
    } else if (state
            .letterPathsModels[state.activeIndex].currentStrokeProgress ==
        -1) {
      final currentStrokePoints =
          state.letterPathsModels[state.activeIndex].allStrokePoints[
              state.letterPathsModels[state.activeIndex].currentStroke];

      if (currentStrokePoints.length == 1) {
        // Handle the case where there's only one point in the current stroke
        final singlePoint = currentStrokePoints[0];
        if (isValidPoint(singlePoint, position)) {
          // Fill stroke immediately
          final newDrawingPath = Path()..moveTo(singlePoint.dx, singlePoint.dy);
          state.letterPathsModels[state.activeIndex].currentDrawingPath =
              newDrawingPath..lineTo(singlePoint.dx, singlePoint.dy);
          state.letterPathsModels[state.activeIndex].currentStrokeProgress = 1;
          completeStroke();
        }
      } else {
        // Handle the case for multiple points
        if (state.letterPathsModels[state.activeIndex].anchorPos != null) {
          final newDrawingPath = Path()
            ..moveTo(state.letterPathsModels[state.activeIndex].anchorPos!.dx,
                state.letterPathsModels[state.activeIndex].anchorPos!.dy);

          state.letterPathsModels[state.activeIndex].currentDrawingPath =
              newDrawingPath;
          state.letterPathsModels[state.activeIndex].currentStrokeProgress = 1;
          emit(state.copyWith(
            letterPathsModels: state.letterPathsModels,
          ));
        }
      }
    }
  }

  void handlePanUpdate(Offset position) {
    final currentStrokePoints =
        state.letterPathsModels[state.activeIndex].allStrokePoints[
            state.letterPathsModels[state.activeIndex].currentStroke];

    if (state.letterPathsModels[state.activeIndex].currentStrokeProgress >= 0 &&
        state.letterPathsModels[state.activeIndex].currentStrokeProgress <
            currentStrokePoints.length) {
      if (currentStrokePoints.length == 1) {
        // Special case for single-point strokes
        final singlePoint = currentStrokePoints[0];
        if (isValidPoint(singlePoint, position)) {
          // Update path and complete stroke immediately
          final newDrawingPath = state
              .letterPathsModels[state.activeIndex].currentDrawingPath
            ..lineTo(
                currentStrokePoints.first.dx, currentStrokePoints.first.dy);

          state.letterPathsModels[state.activeIndex].anchorPos = singlePoint;
          state.letterPathsModels[state.activeIndex].currentDrawingPath =
              newDrawingPath;

          completeStroke();
          return;
        }
      } else {
        // Handle multiple points normally
        if (isValidPoint(
            currentStrokePoints[state
                .letterPathsModels[state.activeIndex].currentStrokeProgress],
            position)) {
          state.letterPathsModels[state.activeIndex].currentStrokeProgress =
              state.letterPathsModels[state.activeIndex].currentStrokeProgress +
                  1;

          final point = currentStrokePoints[
              state.letterPathsModels[state.activeIndex].currentStrokeProgress -
                  1];

          final newDrawingPath = state
              .letterPathsModels[state.activeIndex].currentDrawingPath
            ..lineTo(point.dx, point.dy);

          state.letterPathsModels[state.activeIndex].anchorPos = point;
          state.letterPathsModels[state.activeIndex].currentDrawingPath =
              newDrawingPath;

          emit(state.copyWith(letterPathsModels: state.letterPathsModels));
        }
      }
    }

    if (state.letterPathsModels[state.activeIndex].currentStrokeProgress >=
        currentStrokePoints.length) {
      completeStroke();
    }
  }

  void completeStroke() {
    final currentModel = state.letterPathsModels[state.activeIndex];
    final currentStrokeIndex = currentModel.currentStroke;

    if (currentStrokeIndex < currentModel.allStrokePoints.length - 1) {
      // Instead of resetting the path, add the current one to paths
      currentModel.paths.add(currentModel.currentDrawingPath);

      // Update to the next stroke
      currentModel.currentStroke = currentStrokeIndex + 1;
      currentModel.currentStrokeProgress = 0;

      // Start the new stroke path from the end point of the previous stroke
      final previousStrokePoints =
          currentModel.allStrokePoints[currentStrokeIndex];
      final endPointOfPreviousStroke = previousStrokePoints.isNotEmpty
          ? currentModel.allStrokePoints[currentStrokeIndex].first
          : Offset.zero;

      final newStrokePoints =
          currentModel.allStrokePoints[currentModel.currentStroke];
      final newDrawingPath = Path()
        ..moveTo(endPointOfPreviousStroke.dx, endPointOfPreviousStroke.dy);
      currentModel.currentDrawingPath = newDrawingPath;
      currentModel.anchorPos =
          currentModel.allStrokePoints[currentModel.currentStroke].first;
      print('33444');
      // Emit updated state
      emit(state.copyWith(letterPathsModels: state.letterPathsModels));
    } else if (!currentModel.letterTracingFinished) {
      // Finish tracing if it's the last stroke
      currentModel.letterTracingFinished = true;
      currentModel.hasFinishedOneStroke = true;
      if (state.activeIndex < state.letterPathsModels.length - 1) {
        emit(state.copyWith(
          activeIndex: (state.activeIndex + 1),
          letterPathsModels: state.letterPathsModels,
        ));
      } else {
        emit(state.copyWith(
            activeIndex: (state.activeIndex),
            letterPathsModels: state.letterPathsModels,
            drawingStates: DrawingStates.gameFinished));
      }
      // Call any final actions like widget.onFinish() or widget.onTraceFinished() if needed.
    }
  }

  bool isTracingStartPoint(Offset position) {
    final currentStrokePoints =
        state.letterPathsModels[state.activeIndex].allStrokePoints[
            state.letterPathsModels[state.activeIndex].currentStroke];

    // If there's only one point, we can immediately proceed without further checks
    if (currentStrokePoints.length == 1) {
      return true; // Let handlePanStart handle the logic
    } else if (state.letterPathsModels[state.activeIndex].anchorPos != null) {
      final anchorRect = Rect.fromCenter(
          center: state.letterPathsModels[state.activeIndex].anchorPos!,
          width: 50,
          height: 50);
      return anchorRect.contains(position);
    }
    return false;
  }

  bool isValidPoint(Offset point, Offset position) {
    const validArea = 30.0;
    return (position - point).distance < validArea;
  }
}
