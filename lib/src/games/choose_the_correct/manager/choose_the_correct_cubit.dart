import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/talk_tts.dart';

part 'choose_the_correct_state.dart';

class ChooseTheCorrectCubit extends Cubit<ChooseTheCorrectInitial> {
  ChooseTheCorrectCubit(
      {required int index, required List<GameFinalModel> listGameData})
      : super(ChooseTheCorrectInitial(
          index: index,
          listGameData: listGameData,
          gameData: listGameData[index],
          choose: [],
          images: [],
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
    debugPrint('updateTheCurrentGame:${state.gameData.id}, $index');
    emit(state.copyWith(gameData: state.listGameData[index], index: index));
    debugPrint('updateTheCurrentGame:${state.gameData.id}');
    reForMateGame();
  }

  bool addAnswer({required String userChoose}) {
    String choose = state.gameData.correctAns ?? '';
    print('userChoose:$userChoose , $choose');
    if (userChoose.toLowerCase() == choose.toLowerCase()) {
      int countCorrectAnswers = state.countCorrectAnswers + 1;
      emit(state.copyWith(
          countCorrectAnswers: countCorrectAnswers, isCorrect: true));
      return true;
    } else {
      return false;
    }
  }

  _sayLetter() async {
    if (state.index == 0) {
      await TalkTts.startTalk(
          text:
              "${state.gameData.inst ?? ''} ${state.gameData.sentence ?? ''}");
    } else {
      await TalkTts.startTalk(text: state.gameData.sentence ?? '');
    }
  }
}
