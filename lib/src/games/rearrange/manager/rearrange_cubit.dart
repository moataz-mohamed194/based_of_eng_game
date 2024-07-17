import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/talk_tts.dart';

part 'rearrange_state.dart';

class RearrangeCubit extends Cubit<RearrangeInitial> {
  RearrangeCubit({
    required List<GameFinalModel> listGameData,
    required int index,
  }) : super(RearrangeInitial(
          gameData: listGameData[index],
          index: index,
          listGameData: listGameData,
          correctAnswers: [],
          finalAnswer: '',
          userAnswers: [],
        )) {
    TalkTts.startTalk(text: state.gameData.inst ?? '');

    reFormatAnswers();
  }

  reFormatAnswers() {
    GameFinalModel data = state.gameData;
    String word = data.gameImages?.first.word ?? '';
    List<String> wordAnswers =
        data.gameLetters?.map((element) => element.letter ?? '').toList() ?? [];
    print('wordAnswers:${wordAnswers.length}, ${data.gameLetters?.length}');
    List<String> showAnswers = wordAnswers;
    showAnswers.shuffle();
    emit(state.copyWith(
        correctAnswers: showAnswers,
        finalAnswer: word,
        userAnswers: List.generate(showAnswers.length, (x) => '')));
  }

  bool? addUserAnswer({required int index, required String answer}) {
    List<String> showAnswers = state.userAnswers;
    print('addUserAnswer:$showAnswers , $index , $answer');

    showAnswers[index] = answer;
    emit(state.copyWith(userAnswers: showAnswers));
    bool userAnswer = _checkIfAnswerCompleted();
    print('addUserAnswer:$showAnswers');

    if (userAnswer == true) {
      return _checkCorrectAnswer();
    } else {
      return null;
    }
  }

  bool _checkIfAnswerCompleted() {
    int countOfComplete =
        state.userAnswers.where((element) => element != '').length;
    int countOfAnswer = state.correctAnswers.length;
    if (countOfAnswer == countOfComplete) {
      return true;
    } else {
      return false;
    }
  }

  _checkCorrectAnswer() {
    String correctAnswer = state.finalAnswer;
    String userAnswer = state.userAnswers.join(' ');
    print('userAnswer:$userAnswer , $correctAnswer');
    if (correctAnswer.replaceAll(' ', '') == userAnswer.replaceAll(' ', '')) {
      return true;
    } else {
      return false;
    }
  }

  updateTheCurrentGame({required int index}) {
    debugPrint('updateTheCurrentGame:${state.gameData.id}, $index');
    emit(state.copyWith(gameData: state.listGameData[index], index: index));
    debugPrint('updateTheCurrentGame:${state.gameData.id}');
    reFormatAnswers();
  }

  clearUserAnswer() {
    GameFinalModel data = state.gameData;
    String word = data.gameImages?.first.word ?? '';
    List<String> wordAnswers = word.split(' ').toList() ?? [];
    emit(state.copyWith(
        userAnswers: List.generate(wordAnswers.length, (x) => '')));
  }
}
