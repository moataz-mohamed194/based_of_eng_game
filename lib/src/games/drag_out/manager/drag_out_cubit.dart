import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../src_model/export_models.dart';

import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';
part 'drag_out_state.dart';

class DragOutCubit extends Cubit<DragOutInitial> {
  // final GameFinalModel _gameData;
  DragOutCubit(
      {required GameFinalModel gameData,
      required List<GameFinalModel> allGameData,
      required int index,
      bool? isArabic})
      : super(DragOutInitial(
            gameData: gameData, allGameData: allGameData, index: index)) {
    // emit(state.copyWith(gameData: gameData));
    debugPrint('DragOutCubit');
    emit(state.copyWith(gameData: allGameData[index]));
    reFormatData();
    sayLetter(isArabic: isArabic);
  }
  reFormatData() {
    List<GameImagesGameFinalModel> gameImages = state.gameData.gameImages ?? [];
    gameImages.shuffle();
    emit(state.copyWith(gameImages: gameImages));
  }

  updateTheCurrentGame({required int index}) {
    debugPrint('updateTheCurrentGame:${state.gameData.id}, $index');
    emit(state.copyWith(gameData: state.allGameData[index], index: index));
    debugPrint('updateTheCurrentGame:${state.gameData.id}');
    reFormatData();
  }

  sayLetter({bool? isArabic}) async {
    await TalkTts.startTalk(
        text: state.gameData.inst ?? '', isArabic: isArabic ?? false);

    await AudioPlayerLetters.startPlaySound(
        soundPath: AssetsSoundLetters.getSoundOfLetter(
            mainGameLetter: state.gameData.mainLetter ?? ''));
  }
}
