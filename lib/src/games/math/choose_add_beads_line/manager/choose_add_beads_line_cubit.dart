import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/export_models.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';

part 'choose_add_beads_line_state.dart';

class ChooseAddBeadsLineCubit extends Cubit<ChooseAddBeadsLineInitial> {
  ChooseAddBeadsLineCubit({
    required List<GameFinalModel> allGameData,
    required ToolsOfMath tools,
  }) : super(ChooseAddBeadsLineInitial(
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
    GameLettersGameFinalModel mainQuestion = newData.gameLetters!
        .where((element) => element.mainQuestion == 1)
        .toList()
        .first;
    GameLettersGameFinalModel subQuestion = newData.gameLetters!
        .where((element) => element.mainQuestion == 0)
        .toList()
        .first;
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
