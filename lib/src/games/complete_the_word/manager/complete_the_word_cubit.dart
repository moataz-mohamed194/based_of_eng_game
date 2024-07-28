import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';

part 'complete_the_word_state.dart';

class CompleteTheWordCubit extends Cubit<CompleteTheWordState> {
  CompleteTheWordCubit(
      {required int index,
      required List<GameFinalModel> listGameData,
      bool isArabic = false})
      : super(CompleteTheWordState(
          index: index,
          listGameData: listGameData,
          gameData: listGameData[index],
          choose: [],
          images: [],
          isArabic: isArabic,
        )) {
    reForMateGame();
  }
  reForMateGame() {
    emit(state.copyWith(
        choose: state.listGameData[state.index].gameLetters,
        images: state.listGameData[state.index].gameImages,
        isCorrect: false,
        gameData: state.listGameData[state.index]));
    String choose = state.gameData.correctAns ?? '';
    emit(state.copyWith(correctAnswer: choose));

    _sayLetter();
  }

  updateTheCurrentGame({required int index}) {
    TalkTts.reBackTheDefaultValue();
    debugPrint('updateTheCurrentGame:${state.gameData.id}, $index');
    emit(state.copyWith(gameData: state.listGameData[index], index: index));
    debugPrint('updateTheCurrentGame:${state.gameData.id}');
    reForMateGame();
  }

  bool addAnswer({required GameLettersGameFinalModel letter}) {
    final selectedLetterId = letter.id;
    final currentImageId = state.images.first.gameLetterId;
    if (selectedLetterId == currentImageId) {
      int countCorrectAnswers = state.countCorrectAnswers + 1;
      emit(state.copyWith(
          countCorrectAnswers: countCorrectAnswers, isCorrect: true));
      return true;
    } else {
      return false;
    }
  }

  _sayLetter() async {
    await TalkTts.startTalk(
        text: state.gameData.inst ?? '', isArabic: state.isArabic);
  }
}
