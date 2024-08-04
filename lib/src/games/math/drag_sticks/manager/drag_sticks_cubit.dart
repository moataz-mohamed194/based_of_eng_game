import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../src_model/export_models.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/talk_tts.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';

part 'drag_sticks_state.dart';

class DragSticksCubit extends Cubit<DragSticksInitial> {
  DragSticksCubit(
      {required List<GameFinalModel> allGameData,
      required CurrentGamePhoneticsCubit subBloc})
      : super(DragSticksInitial(
            allGamesData: allGameData,
            index: 0,
            gameData: allGameData.first,
            countOfQuestions: allGameData.fold(
                0, (current, pre) => current + (pre.gameLetters?.length ?? 0)),
            countOfAnswers: 0)) {
    subAction(subBloc: subBloc);
    reFormatGameData();
  }
  addAnswer(
      {required GameImagesGameFinalModel userChoose,
      required GameLettersGameFinalModel subAnswer}) {
    print('#${userChoose.gameLetterId} = ${subAnswer.id}');
    if (userChoose.gameLetterId == subAnswer.id) {
      List<GameLettersGameFinalModel> countCorrectAnswers =
          state.gameAnswers ?? [];
      countCorrectAnswers.add(subAnswer);
      int totalOfCorrectAnswer = state.countOfAnswers;
      totalOfCorrectAnswer = totalOfCorrectAnswer + 1;
      emit(state.copyWith(
          gameAnswers: countCorrectAnswers,
          countOfAnswers: totalOfCorrectAnswer));
      print('totalOfCorrectAnswer:$totalOfCorrectAnswer');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkIsNeedToIncreaseIndex() async {
    // List<GameFinalModel> allGameData =
    //     state.allGameData.sublist(0, state.index + 1);
    int count = state.gameData.gameLetters?.length ?? 0;
    int countOfCorrect = state.gameAnswers?.length ?? 0;
    print("%%:$count , $countOfCorrect , ${(count == countOfCorrect)}");
    if (count == countOfCorrect) {
      return true;
    } else {
      return false;
    }
  }

  reFormatGameData() {
    int newIndex = state.index;
    GameFinalModel newData = state.allGamesData[newIndex];
    List<GameLettersGameFinalModel> gameLetters = newData.gameLetters ?? [];
    List<GameImagesGameFinalModel> gameImages = newData.gameImages ?? [];
    // gameLetters.shuffle();
    gameImages.shuffle();
    emit(state.copyWith(
        gameData: newData,
        gameAnswers: [],
        gameImages: gameImages,
        gameLetters: gameLetters));
    _sayLetter();
  }

  updateTheCurrentGame({required int newIndex}) {
    TalkTts.reBackTheDefaultValue();
    try {
      emit(state.copyWith(index: newIndex));
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

  subAction({required CurrentGamePhoneticsCubit subBloc}) {
    subBloc.getStateOfStars(mainCountOfQuestion: state.countOfQuestions);
    subBloc.saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.stopTalk,
        stateOfStringWillSay: state.gameData.inst ?? '');
  }
}
