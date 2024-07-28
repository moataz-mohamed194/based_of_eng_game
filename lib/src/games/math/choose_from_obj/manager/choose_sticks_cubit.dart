import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/talk_tts.dart';

part 'choose_sticks_state.dart';

class ChooseSticksCubit extends Cubit<ChooseSticksInitial> {
  ChooseSticksCubit({
    required List<GameFinalModel> allGameData,
    required BasicOfGameData basicData,
  }) : super(ChooseSticksInitial(
            allGameData: allGameData,
            correctAnswers: 0,
            basicData: basicData,
            gameData: allGameData[0],
            index: 0)) {
    reFormatGameData();
    _sayLetter();
  }

  reFormatGameData() {
    int newIndex = state.index;
    GameFinalModel newData = state.allGameData[newIndex];
    List<GameChoicesGameFinalModel> gameChoices = newData.gameChoices ?? [];
    gameChoices.shuffle();
    num mainLetter = int.parse("${newData.mainLetter ?? 0}");
    emit(state.copyWith(
        gameData: newData, gameChoices: gameChoices, mainNumber: mainLetter));
  }

  addAnswer({required num userChoose}) {
    if (userChoose == state.mainNumber) {
      int countCorrectAnswers = state.correctAnswers + 1;
      emit(
          state.copyWith(correctAnswers: countCorrectAnswers, isCorrect: true));
      return true;
    } else {
      return false;
    }
  }

  reStartIsCorrect() {
    emit(state.copyWith(isCorrect: false));
  }

  updateTheCurrentGame({required int index}) {
    TalkTts.reBackTheDefaultValue();
    reStartIsCorrect();
    int newIndex = state.index;
    newIndex++;
    emit(state.copyWith(index: index));
    reFormatGameData();
    TalkTts.reStopTheDefaultValue();
  }

  _sayLetter() async {
    await TalkTts.startTalk(text: state.gameData.inst ?? '');
  }
}
