import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/export_models.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';

part 'choose_number_from_wood_state.dart';

class ChooseNumberFromWoodCubit extends Cubit<ChooseNumberFromWoodInitial> {
  ChooseNumberFromWoodCubit(
      {required ToolsOfMath tools, required List<GameFinalModel> allGameData})
      : super(ChooseNumberFromWoodInitial(
            index: 0,
            gameData: allGameData.first,
            allGameData: allGameData,
            tools: tools)) {
    reFormatGameData();
  }

  reStartIsCorrect() {
    emit(state.copyWith(isCorrect: false));
  }

  reFormatGameData() {
    reStartIsCorrect();
    int newIndex = state.index;
    GameFinalModel newData = state.allGameData[newIndex];
    List<GameChoicesGameFinalModel> gameChoices = newData.gameChoices ?? [];
    List<GameLettersGameFinalModel> gameLetters = newData.gameLetters ?? [];
    gameChoices.shuffle();
    emit(state.copyWith(
        gameData: newData, gameChoices: gameChoices, gameLetters: gameLetters));
    _sayLetter();
  }

  addAnswer({required GameChoicesGameFinalModel userChoose}) {
    if (userChoose.isCorrect == 1) {
      int countCorrectAnswers = state.correctAnswers + 1;
      emit(
          state.copyWith(correctAnswers: countCorrectAnswers, isCorrect: true));
      return true;
    } else {
      return false;
    }
  }

  updateTheCurrentGame({required int index}) {
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
