import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/talk_tts.dart';

part 'choose_number_state.dart';

class ChooseNumberCubit extends Cubit<ChooseNumberInitial> {
  ChooseNumberCubit({
    required List<GameFinalModel> allGameData,
    required BasicOfGameData basicData,
  }) : super(ChooseNumberInitial(
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
    emit(state.copyWith(isCorrect:false,
        gameData: newData, gameChoices: gameChoices, mainNumber: mainLetter));
  }

  reStartIsCorrect() {
    emit(state.copyWith(isCorrect: false));
  }
  addAnswer({required num userChoose}) {
    if (userChoose == state.mainNumber) {
      int countCorrectAnswers = state.correctAnswers + 1;
      emit(state.copyWith(
          correctAnswers: countCorrectAnswers, currentAnswer: userChoose, isCorrect: true));
      return true;
    } else {
      return false;
    }
  }

  updateTheCurrentGame({required int index}) {
    reStartIsCorrect();

    TalkTts.reBackTheDefaultValue();
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
