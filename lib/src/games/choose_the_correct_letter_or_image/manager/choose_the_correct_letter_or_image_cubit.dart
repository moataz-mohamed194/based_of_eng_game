import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../src_model/export_models.dart';

import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';
part 'choose_the_correct_letter_or_image_state.dart';

class ChooseTheCorrectLetterOrImageCubit
    extends Cubit<ChooseTheCorrectLetterOrImageState> {
  ChooseTheCorrectLetterOrImageCubit(
      {required GameFinalModel gameData,
      required List<GameFinalModel> allGameData,
      required int index,
      bool isLetter = false})
      : super(ChooseTheCorrectLetterOrImageState(
            gameData: gameData,
            allGameData: allGameData,
            index: index,
            isLetter: isLetter)) {
    debugPrint('DragOutCubit');
    emit(state.copyWith(gameData: allGameData[index]));
    reFormatData();
    sayTheGameThenTheLetter();
  }
  Future<void> addSuccess() async {
    emit(state.copyWith(isCorrect: true));

    await Future.delayed(const Duration(milliseconds: 500));

    emit(state.copyWith(isCorrect: false));
  }

  void reFormatData() {
    List<GameImagesGameFinalModel> gameImages = state.gameData.gameImages ?? [];
    gameImages.shuffle();
    emit(state.copyWith(gameImages: gameImages));
  }

  Future<void> updateTheCurrentGame({required int index}) async {
    debugPrint('updateTheCurrentGame:${state.gameData.id}, $index');
    emit(state.copyWith(gameData: state.allGameData[index], index: index));
    debugPrint('updateTheCurrentGame:${state.gameData.id}');
    reFormatData();
  }

  Future<void> sayTheGameThenTheLetter() async {
    await TalkTts.startTalk(text: state.gameData.inst ?? '', isArabic: true);
    await sayLetter();
  }

  Future<void> sayLetter() async {
    final isLetter = state.isLetter;
    if (isLetter) {
      await AudioPlayerLetters.startPlaySound(
          soundPath: AssetsSoundLetters.getSoundOfLetter(
              mainGameLetter: state.gameData.mainLetter ?? ''));
    } else {
      await TalkTts.startTalk(
          text: state.gameData.gameImages?.first.word ?? '', isArabic: true);
    }
  }
}
