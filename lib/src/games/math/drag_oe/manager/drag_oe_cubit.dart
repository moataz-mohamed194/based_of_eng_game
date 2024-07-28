import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';

part 'drag_oe_state.dart';

class DragOeCubit extends Cubit<DragOeInitial> {
  DragOeCubit(
      {required List<GameFinalModel> allGameData,
      // required BasicOfGameData basicData,
      required ToolsOfMath tools,
      required CurrentGamePhoneticsCubit subBloc})
      : super(DragOeInitial(
            allGameData: allGameData,
            correctAnswers: [],
            countOfCorrect: 0,
            countOfQuestions: allGameData.fold(
                0,
                (previousValue, element) =>
                    previousValue +
                    (element.gameChoices
                            ?.where((ele) => ele.isCorrect == 1)
                            .length ??
                        0)),
            tools: tools,
            gameData: allGameData[0],
            index: 0)) {
    subAction(subBloc: subBloc);
    reFormatGameData();
  }
  reFormatGameData() {
    int newIndex = state.index;
    GameFinalModel newData = state.allGameData[newIndex];
    List<GameChoicesGameFinalModel> gameChoices = newData.gameChoices ?? [];
    // int totalOfCorrectAnswer = correctAnswers.length + state.countOfCorrect;
    gameChoices.shuffle();
    emit(state.copyWith(
      gameData: newData,
      gameChoices: gameChoices,
      correctAnswers: [],
    ));
    _sayLetter();
  }

  updateTheCurrentGame({required int newIndex}) {
    TalkTts.reBackTheDefaultValue();
    // int newIndex = state.index;
    // newIndex++;
    emit(state.copyWith(index: newIndex));
    reFormatGameData();
    TalkTts.reStopTheDefaultValue();
  }

  _sayLetter() async {
    await TalkTts.startTalk(text: state.gameData.inst ?? '');
  }

  Future<bool> checkIsNeedToIncreaseIndex() async {
    // List<GameFinalModel> allGameData =
    //     state.allGameData.sublist(0, state.index + 1);
    int count =
        state.gameData.gameChoices?.where((ele) => ele.isCorrect == 1).length ??
            0;
    int countOfCorrect = state.correctAnswers.length;
    print("%%:$count , $countOfCorrect , ${(count == countOfCorrect)}");
    if (count == countOfCorrect) {
      return true;
    } else {
      return false;
    }
  }

  addAnswer({required GameChoicesGameFinalModel? userChoose}) {
    if (userChoose?.isCorrect == 1) {
      List<GameChoicesGameFinalModel> countCorrectAnswers =
          state.correctAnswers;
      countCorrectAnswers.add(userChoose!);
      int totalOfCorrectAnswer = state.countOfCorrect;
      totalOfCorrectAnswer = totalOfCorrectAnswer + 1;
      emit(state.copyWith(
          correctAnswers: countCorrectAnswers,
          countOfCorrect: totalOfCorrectAnswer));
      print('totalOfCorrectAnswer:$totalOfCorrectAnswer');
      return true;
    } else {
      return false;
    }
  }

  subAction({required CurrentGamePhoneticsCubit subBloc}) {
    print('listener:${state.countOfQuestions}');
    subBloc.getStateOfStars(mainCountOfQuestion: state.countOfQuestions);
    subBloc.saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.stopTalk,
        stateOfStringWillSay: state.gameData.inst ?? '');
  }
}
