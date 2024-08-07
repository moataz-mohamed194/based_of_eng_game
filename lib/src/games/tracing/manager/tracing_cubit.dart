import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:async';
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
  }) : super(TracingState(
          gameData: gameData,
          stateOfGame: stateOfGame,
          paths: [],
        )) {
    emit(state.clearData());
    TalkTts.startTalk(text: state.gameData.inst ?? '');
  }

  Future<void> loadAssets({
    // required String letterPath,
    // required String tracingAssets,
    // required bool needInstruction,
    // required String pointsJsonFile,
    required Size viewSize,
  }) async {
    emit(state.copyWith(drawingStates: DrawingStates.loading));
    try {
      // Load and parse the SVG path
      Path parsedPath = parseSvgPath(state.stateOfGame.basicData!.letterPath);

      // Compute the SVG bounding box size
      final originalSize =
          _getOriginalSvgSize(state.stateOfGame.basicData!.letterPath);

      // Calculate scale factors
      final scaleX = viewSize.width / originalSize.width;
      final scaleY = viewSize.height / originalSize.height;
      final scale = math.min(scaleX, scaleY);

      // Create a transformation matrix
      final matrix = Matrix4.identity()
        ..scale(scale)
        ..translate(
          (viewSize.width - (originalSize.width * scale)) / 2,
          (viewSize.height - (originalSize.height * scale)) / 2,
        );

      // Apply the transformation to the path
      final transformedPath = _applyTransformation(parsedPath, matrix);

      ui.Image? traceImage;
      // if (needInstruction) {
      //   traceImage = await _loadImage(tracingAssets);
      // }
      final allStrokePoints = await _loadPointsFromJson(
          state.stateOfGame.basicData!.pointsJsonFile, viewSize);

      final anchorPos =
          allStrokePoints.isNotEmpty ? allStrokePoints[0][0] : Offset.zero;
      emit(state.copyWith(
        paths: [],
        traceImage: traceImage,
        anchorImage: null,
        letterImage: transformedPath,
        allStrokePoints: allStrokePoints,
        anchorPos: anchorPos,
        viewSize: viewSize,
        drawingStates: DrawingStates.loaded,
      ));
    } catch (e) {
      debugPrint('Error loading assets: $e');
    }
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


//   Future<List<List<Offset>>> _loadPointsFromJson(
//       String path, Size viewSize) async {

//     print('qqqqq');
//     // final jsonString =
//     //     await rootBundle.loadString('packages/based_of_eng_game/' + path);
//         final jsonString =
     
//      jsonDecode('''{
//   "id" : "9CACB3FA-1EAF-40E7-A06B-73117DDDC659",
//   "style" : "default",
//   "char" : "S",
//   "strokes":[
//     {"points":["0.0775,0.14","0.09,0.3175","0.1025,0.465","0.1075,0.62","0.1075,0.7675"]

// },
  
// {"points":["0.285,0.21","0.455,0.195","0.4925,0.3675","0.4975,0.55","0.4925,0.745"]},

// {
//   "points":["0.615,0.2525","0.7925,0.18","0.885,0.2825","0.8975,0.4375","0.8925,0.595","0.89,0.7475"]}

// ]}

// ''');
    
//     final jsonData = jsonString;
//     print(jsonData.toString());
//     final List<List<Offset>> strokePointsList = [];

//     for (var stroke in jsonData['strokes']) {
//       final List<dynamic> strokePointsData = stroke['points'];
//       final points = strokePointsData.map<Offset>((pointString) {
//         final coords =
//             pointString.split(',').map((e) => double.parse(e)).toList();
//         return Offset(coords[0] * viewSize.width, coords[1] * viewSize.height);
//       }).toList();
//       strokePointsList.add(points);
//     }

//     return strokePointsList;
//   }


  Future<List<List<Offset>>> _loadPointsFromJson(
      String path, Size viewSize) async {

    final jsonString =
        await rootBundle.loadString( path);
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

    if (state.currentStrokeProgress == -1 && state.anchorPos != null) {
      final newDrawingPath = Path()
        ..moveTo(state.anchorPos!.dx, state.anchorPos!.dy);
      emit(state.copyWith(
        currentDrawingPath: newDrawingPath,
        currentStrokeProgress: 1,
      ));
    }
  }
void handlePanUpdate(Offset position) {
    if (state.currentStrokeProgress >= 0 &&
        state.currentStrokeProgress <
            state.allStrokePoints[state.currentStroke].length &&
        isOverlapped(position)) {
        
        if (isValidPoint(
            state.allStrokePoints[state.currentStroke]
                [state.currentStrokeProgress],
            position)) {

            emit(state.copyWith(
                currentStrokeProgress: state.currentStrokeProgress + 1));
        }

        if (state.currentStrokeProgress > 0) {
            final point = state.allStrokePoints[state.currentStroke]
                [state.currentStrokeProgress - 1];

            final newDrawingPath = state.currentDrawingPath
              ..lineTo(point.dx, point.dy);

            emit(state.copyWith(
              anchorPos: point,
              currentDrawingPath: newDrawingPath,
            ));
        }
    }

    if (state.currentStrokeProgress >=
        state.allStrokePoints[state.currentStroke].length) {
        completeStroke();
    }
}

void completeStroke() {
    if (state.currentStroke < state.allStrokePoints.length - 1) {
        // Instead of resetting the path, keep the current one
        emit(state.copyWith(
          paths: state.paths..add(state.currentDrawingPath),
          currentStroke: state.currentStroke + 1,
          currentStrokeProgress: 0, // Reset stroke progress to start new stroke
          anchorPos: state.allStrokePoints[state.currentStroke + 1][0],
          hasFinishedOneStroke: true,
        ));
    } else if (!state.letterTracingFinished) {
        emit(state.copyWith(
            letterTracingFinished: true,
            hasFinishedOneStroke: true,
            drawingStates: DrawingStates.gameFinished));
        // Call any final actions like widget.onFinish() or widget.onTraceFinished() if needed.
    }
}

  bool isTracingStartPoint(Offset position) {
    if (state.anchorPos != null) {
      final anchorRect =
          Rect.fromCenter(center: state.anchorPos!, width: 50, height: 50);
      return anchorRect.contains(position);
    }
    return false;
  }

  bool isOverlapped(Offset position) {
    return true; // Implement actual logic
  }

  bool isValidPoint(Offset point, Offset position) {
    const validArea = 30.0;
    return (position - point).distance < validArea;
  }
}
