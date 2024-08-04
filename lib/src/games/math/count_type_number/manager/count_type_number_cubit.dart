import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/export_models.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';

part 'count_type_number_state.dart';

class CountTypeNumberCubit extends Cubit<CountTypeNumberInitial> {
  CountTypeNumberCubit(
      {required ToolsOfMath tools, required List<GameFinalModel> allGameData})
      : super(CountTypeNumberInitial(
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
    List<GameLettersGameFinalModel> gameLetters = newData.gameLetters ?? [];
    String correctAns = newData.correctAns ?? '';
    emit(state.copyWith(
        gameData: newData, gameLetters: gameLetters, correctAns: correctAns));
    _sayLetter();
  }

  addAnswer({required String userChoose}) {
    if (userChoose == state.correctAns) {
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
