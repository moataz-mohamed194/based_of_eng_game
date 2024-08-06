import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/talk_tts.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';

part 'tracing_state.dart';

class TracingCubit extends Cubit<TracingInitial> {
  TracingCubit(
      {required GameFinalModel gameData,
      required CurrentGamePhoneticsState stateOfGame})
      : super(TracingInitial(
          gameData: gameData,
          stateOfGame: stateOfGame,
          paths: [],
        )) {
  
    emit(state.clearData());

    TalkTts.startTalk(text: state.gameData.inst ?? '');

  }

  // Future<List<Offset>> getOffsetsFromPath(Path path) {
  //   // Get the path metrics
  //   List<Offset> offsets = [];
  //   PathMetrics pathMetrics = path.computeMetrics();
  //
  //   // Traverse each segment of the path
  //   for (PathMetric pathMetric in pathMetrics) {
  //     double length = pathMetric.length;
  //
  //     // Sample points along the path at regular intervals
  //     for (double distance = 0; distance < length; distance += 1) {
  //       Tangent? tangent = pathMetric.getTangentForOffset(distance);
  //       if (tangent != null) {
  //         offsets.add(tangent.position);
  //       }
  //     }
  //   }
  //   return Future.value(offsets);
  // }

  // checkTheLocationOfPoint({required Offset point, required Size size}) async {
  //   try {
  //     if (state.stateOfGame.basicData?.checkTheIndexOfPath != null) {
  //       List<Offset> subOffest = state.paths;
  //       subOffest.add(point);
  //       emit(state.copyWith(paths: subOffest));
  //       (Path, int)? mainDataOfPath = state
  //           .stateOfGame.basicData?.checkTheIndexOfPath!(point, size, false);
  //       // Path? finalPath = mainDataOfPath?.$1;
  //       // if (finalPath != null) {
  //       List<Offset> subPaths = state.paths;
  //       //   List<Offset> newSubPaths = await getOffsetsFromPath(finalPath);
  //       //   subPaths.addAll(newSubPaths);
  //       subPaths.add(point);
  //       emit(state.copyWith(paths: subPaths));
  //       // }
  //       int indexOfPoint = mainDataOfPath?.$2 ?? 0;
  //       // debugPrint('before:${state.paths.length}');

  //       if (indexOfPoint == 1 &&
  //           state.colorsOfPaths
  //               .where((element) => element == null)
  //               .isNotEmpty) {
  //         indexOfPoint = indexOfPoint - 1;
  //         List<Color?> tempColors = state.colorsOfPaths;
  //         tempColors[indexOfPoint] = AppColorPhonetics.lightBlueColor4;
  //         emit(state.copyWith(colorsOfPaths: tempColors));
  //       } else if (state.colorsOfPaths[indexOfPoint - 2] != null) {
  //         indexOfPoint = indexOfPoint - 1;
  //         List<Color?> tempColors = state.colorsOfPaths;
  //         tempColors[indexOfPoint] = AppColorPhonetics.lightBlueColor4;
  //         emit(state.copyWith(colorsOfPaths: tempColors));
  //       }
  //       // debugPrint('after:${state.colorsOfPaths}');
  //     }
  //   } catch (e) {
  //     debugPrint('check:$e');
  //   }
  // }

  saveCurrentPosition({
    required PathProviderModel currentModel,
    required Offset point,
  }) {
    try {
      currentModel.points.add(point);

      emit(state.copyWith(currentPosition: point));
    } catch (e) {
      debugPrint('check:$e');
    }
  }

  shiftIndex({
    required int index,
    required Offset point
  }) {
    if (index < state.stateOfGame.basicData!.pathsModels.length) {
      state.stateOfGame.basicData!.setDrawingShapeCurrentIndex = index;

      emit(state.copyWith(currentDrawingIndex: index,currentPosition:point));
      print('index' +
          state.stateOfGame.basicData!.getDrawingShapeCurrentIndex.toString());
    }
  }

  gameFinished({
    required int index,
    required Offset endOffset
  }) {
          state.stateOfGame.basicData!.setDrawingShapeCurrentIndex = index;

    emit(state.copyWith(currentDrawingIndex: index,currentPosition: endOffset));
  }
}
