import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/export_models.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';

part 'drag_type_rod_line_state.dart';

class DragTypeRodLineCubit extends Cubit<DragTypeRodLineInitial> {
  DragTypeRodLineCubit(
      {required ToolsOfMath tools, required List<GameFinalModel> allGameData})
      : super(DragTypeRodLineInitial(
            index: 0,
            gameData: allGameData.first,
            allGameData: allGameData,
            tools: tools)) {
    reFormatGameData();
    _sayLetter();
  }

  reStartIsCorrect() {
    emit(state.copyWith(isCorrect: false));
  }

  reFormatGameData() {
    reStartIsCorrect();
    int newIndex = state.index;
    GameFinalModel newData = state.allGameData[newIndex];
    List<GameChoicesGameFinalModel> gameChoices = newData.gameChoices ?? [];

    // gameChoices.forEach((action){
    //   if()
    // });
    GameChoicesGameFinalModel correctAnswer = (newData.gameChoices ?? [])
        .where((element) => element.isCorrect == 1)
        .toList()
        .first;
    List<GameLettersGameFinalModel> gameLetters = newData.gameLetters ?? [];
    List<GameLettersGameFinalModel> finalGameLetters = [];
    for (int i = 0; i < gameLetters.length; i++) {
      if (i != 0) {
        finalGameLetters.add(GameLettersGameFinalModel(letter: '+'));
      }
      finalGameLetters.add(gameLetters[i]);
    }
    gameChoices.shuffle();
    emit(state.copyWith(
        gameData: newData,
        gameChoices: gameChoices,
        finalGameLetters: finalGameLetters,
        correctAnswer: correctAnswer));
  }

  addAnswer({required GameChoicesGameFinalModel? userChoose}) {
    if (userChoose?.isCorrect == 1) {
      int countCorrectAnswers = state.correctAnswers + 1;
      emit(state.copyWith(
          correctAnswers: countCorrectAnswers, isCorrectDrag: true));
      return true;
    } else {
      return false;
    }
  }

  addAnswerType({required String? userChoose}) async {
    if (state.isCorrectDrag != true) {
      await TalkTts.startTalk(text: 'drag first');
      return;
    }
    if (userChoose == state.correctAnswer?.choice) {
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
