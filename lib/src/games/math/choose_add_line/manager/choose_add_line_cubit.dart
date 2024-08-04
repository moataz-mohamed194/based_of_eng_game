import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/export_models.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';

part 'choose_add_line_state.dart';

class ChooseAddLineCubit extends Cubit<ChooseAddLineInitial> {
  ChooseAddLineCubit({
    required List<GameFinalModel> allGameData,
    required ToolsOfMath tools,
  }) : super(ChooseAddLineInitial(
            allGameData: allGameData,
            correctAnswers: 0,
            tools: tools,
            gameData: allGameData[0],
            index: 0)) {
    reFormatGameData();
  }

  reFormatGameData() {
    reStartIsCorrect();
    int newIndex = state.index;
    GameFinalModel newData = state.allGameData[newIndex];
    List<GameChoicesGameFinalModel> gameChoices = newData.gameChoices ?? [];
    gameChoices.shuffle();
    GameLettersGameFinalModel mainQuestion;
    GameLettersGameFinalModel subQuestion;
    try {
      mainQuestion = newData.gameLetters!
          .where((element) => element.mainQuestion == 1)
          .toList()
          .first;
      subQuestion = newData.gameLetters!
          .where((element) => element.mainQuestion == 0)
          .toList()
          .first;
    } catch (e) {
      mainQuestion = newData.gameLetters!.first;
      subQuestion = newData.gameLetters!.last;
    }
    emit(state.copyWith(
        gameData: newData,
        gameChoices: gameChoices,
        mainQuestion: mainQuestion,
        subQuestion: subQuestion));
    _sayLetter();
  }

  addAnswer({required GameChoicesGameFinalModel? userChoose}) {
    if (userChoose?.isCorrect == 1) {
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
    try {
      int newIndex = state.index;
      newIndex++;
      emit(state.copyWith(index: index));
      reFormatGameData();
      TalkTts.reStopTheDefaultValue();
    } catch (e) {
      reFormatGameData();
      TalkTts.reStopTheDefaultValue();
    }
  }

  _sayLetter() async {
    await TalkTts.startTalk(text: state.gameData.inst ?? '');
  }
}
