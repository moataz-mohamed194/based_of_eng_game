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
import '../../../core/phonetics_color.dart';
import '../../../core/talk_tts.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import 'dart:math' as math;
part 'tracing_state.dart';

class TracingCubit extends Cubit<TracingState> {
  TracingCubit({
    required GameFinalModel gameData,
    required CurrentGamePhoneticsState stateOfGame,
    required TracePhonetics tracePhontics,
  }) : super(TracingState(
          gameData: gameData,
          stateOfGame: stateOfGame,
          tracePhontics: tracePhontics,
          letterPathsModels: [],
        )) {
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
    for (var e in state.tracePhontics.lettersModel) {
      final letterModel = state.tracePhontics.lettersModel[state.activeIndex];
      final parsedPath = parseSvgPath(letterModel.letterPath);

      final dottedIndexPath = parseSvgPath(letterModel.indexPath);
      final dottedPath = parseSvgPath(letterModel.dottedPath);

      final originalSize = _getOriginalSvgSize(letterModel.letterPath);
     
      final scaleX = viewSize.width / originalSize.width;
      final scaleY = viewSize.height / originalSize.height;
      final scale = math.min(scaleX, scaleY);

      final matrix = Matrix4.identity()
        ..scale(scale)
        ..translate(
          (viewSize.width - (originalSize.width * scale)) / 2,
          (viewSize.height - (originalSize.height * scale)) / 2,
        );

      final transformedPath = _applyTransformation(parsedPath, matrix);
      final letterIndex = _applyTransformation(dottedPath, matrix);
      final dottedIndex = _applyTransformation(dottedIndexPath, matrix);
      final allStrokePoints =
          await _loadPointsFromJson(letterModel.pointsJsonFile, viewSize);
      final anchorPos =
          allStrokePoints.isNotEmpty ? allStrokePoints[0][0] : Offset.zero;

      state.letterPathsModels.add(LetterPathsModel(
        strokeWidth:  state.tracePhontics.lettersModel[state.activeIndex].strokeWidth,
          dottedIndex: dottedIndex,
          letterIndex: letterIndex,
          dottedColor:
              state.tracePhontics.lettersModel[state.activeIndex].dottedColor,
          indexColor:
              state.tracePhontics.lettersModel[state.activeIndex].indexColor,
          innerPaintColor: state
              .tracePhontics.lettersModel[state.activeIndex].innerPaintColor,
          outerPaintColor: state
              .tracePhontics.lettersModel[state.activeIndex].outerPaintColor,
          allStrokePoints: allStrokePoints,
          letterImage: transformedPath,
          anchorPos: anchorPos));
    }

    emit(state.copyWith(
      drawingStates: DrawingStates.loaded,
    ));
  }

  Path _applyTransformation(Path path, Matrix4 matrix) {
    final Float64List matrix4Storage = matrix.storage;
    return path.transform(matrix4Storage);
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

    if (state.letterPathsModels[state.activeIndex].currentStrokeProgress ==
            -1 &&
        state.letterPathsModels[state.activeIndex].anchorPos != null) {
      final newDrawingPath = Path()
        ..moveTo(state.letterPathsModels[state.activeIndex].anchorPos!.dx,
            state.letterPathsModels[state.activeIndex].anchorPos!.dy);

      state.letterPathsModels[state.activeIndex].currentDrawingPath =
          newDrawingPath;
      state.letterPathsModels[state.activeIndex].currentStrokeProgress = 1;
      print('hereeee');
      emit(state.copyWith(
        letterPathsModels: state.letterPathsModels,
      ));
    }
  }

  void handlePanUpdate(Offset position) {
    if (state.letterPathsModels[state.activeIndex].currentStrokeProgress >= 0 &&
        state.letterPathsModels[state.activeIndex].currentStrokeProgress <
            state
                .letterPathsModels[state.activeIndex]
                .allStrokePoints[
                    state.letterPathsModels[state.activeIndex].currentStroke]
                .length) {
      print('1234');
      if (isValidPoint(
          state.letterPathsModels[state.activeIndex].allStrokePoints[
                  state.letterPathsModels[state.activeIndex].currentStroke][
              state.letterPathsModels[state.activeIndex].currentStrokeProgress],
          position)) {
        state.letterPathsModels[state.activeIndex].currentStrokeProgress =
            state.letterPathsModels[state.activeIndex].currentStrokeProgress +
                1;
        print('22445');
        emit(state.copyWith(letterPathsModels: state.letterPathsModels));
      }

      if (state.letterPathsModels[state.activeIndex].currentStrokeProgress >
          0) {
        final point = state
                    .letterPathsModels[state.activeIndex].allStrokePoints[
                state.letterPathsModels[state.activeIndex].currentStroke][
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

    if (state.letterPathsModels[state.activeIndex].currentStrokeProgress >=
        state
            .letterPathsModels[state.activeIndex]
            .allStrokePoints[
                state.letterPathsModels[state.activeIndex].currentStroke]
            .length) {
      completeStroke();
    }
  }

  void completeStroke() {
    if (state.letterPathsModels[state.activeIndex].currentStroke <
        state.letterPathsModels[state.activeIndex].allStrokePoints.length - 1) {
      // Instead of resetting the path, keep the current one
      state.letterPathsModels[state.activeIndex].paths
          .add(state.letterPathsModels[state.activeIndex].currentDrawingPath);
      state.letterPathsModels[state.activeIndex].currentStroke =
          state.letterPathsModels[state.activeIndex].currentStroke + 1;
      state.letterPathsModels[state.activeIndex].currentStrokeProgress = 0;

      state.letterPathsModels[state.activeIndex].anchorPos =
          state.letterPathsModels[state.activeIndex].allStrokePoints[
              state.letterPathsModels[state.activeIndex].currentStroke][0];

      emit(state.copyWith(letterPathsModels: state.letterPathsModels));
    } else if (!state
        .letterPathsModels[state.activeIndex].letterTracingFinished) {
      state.letterPathsModels[state.activeIndex].letterTracingFinished = true;
      state.letterPathsModels[state.activeIndex].hasFinishedOneStroke = true;
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
    if (state.letterPathsModels[state.activeIndex].anchorPos != null) {
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
