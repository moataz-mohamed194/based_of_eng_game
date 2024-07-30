import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../src_model/export_models.dart';

import '../../../core/talk_tts.dart';
part 'spelling_state.dart';

class SpellingCubit extends Cubit<SpellingInitial> {
  // final GameFinalModel gameData;
  // final List<GameFinalModel> allGames;
  // final String background;
  // final int index;
  SpellingCubit(
      {required String background,
      required int index,
      required List<GameFinalModel> allGames,
      bool isArabic = false})
      : super(SpellingInitial(
          woodenBackground: background,
          correctAnswers: List.generate(
              (allGames.first.correctAns ?? '').split('').length,
              (index) => ''),
          allGames: allGames,
          gameData: allGames.first,
          index: index,
          isArabic: isArabic,
        )) {
    // emit(state.copyWith(gameData: allGames, correctAnswers: ['', '', '']));
    TalkTts.startTalk(
        text: state.allGames[state.index].inst ?? '', isArabic: state.isArabic);
  }

  addTheCorrectAnswer({required String answer, required int index}) async {
    List<String> correctAnswer = state.correctAnswers;
    correctAnswer.removeAt(index);
    correctAnswer.insert(index, answer);
    emit(state.copyWith(correctAnswers: correctAnswer));
  }

  // increaseCountOfCorrectAnswers() async {
  //   int sub = state.correctAnswer ?? 0;
  //   sub = sub + 1;
  //   emit(state.copyWith(correctAnswer: sub));
  //   return state.correctAnswer;
  // }

  // increaseIndexOfCorrectAnswers() async {
  //   int sub = state.index ?? 0;
  //   sub = sub + 1;
  //   emit(state.copyWith(index: sub));
  //   clearAnswers();
  //   return state.correctAnswer;
  // }

  // increaseCountOfWrongAnswers({int? count}) async {
  //   emit(state.copyWith(countOfWrong: count ?? state.countOfWrong + 1));
  // }

  clearAnswers() {
    emit(state.copyWith(
        correctAnswers: List.generate(
            (state.allGames[state.index].correctAns ?? '').split('').length,
            (index) => '')));
  }

  // bool checkIfIsTheLastGameOfLesson() {
  //   int currentIndex = state.index ?? 0;
  //   currentIndex = currentIndex + 1;
  //   print('currentIndex:${currentIndex}');
  //
  //   if ((state.gameData.length ?? 0) > currentIndex &&
  //       (state.gameData[currentIndex].gameTypes?.name?.toLowerCase() ==
  //           GameTypes.spelling.text().toLowerCase())) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  Future<bool> checkIsCorrectAnswer() async {
    bool stateOfAnswer = state.gameData?.correctAns?.toLowerCase() ==
        state.correctAnswers.join().toLowerCase();
    if (stateOfAnswer) {
      TalkTts.startTalk(
          text: "${state.gameData?.correctAns ?? ''}  ",
          isArabic: state.isArabic);
      await Future.delayed(Duration(milliseconds: 500));
    }
    return stateOfAnswer;
  }

  bool checkCurrentFinished() {
    final lengthOfCorrectAnswer = state.gameData?.correctAns?.length;
    final lengthOfCurrentAnswer = state.correctAnswers.join('').length;
    final isCurrentAnswerFinished =
        lengthOfCurrentAnswer == lengthOfCorrectAnswer;

    return isCurrentAnswerFinished;
  }

  updateTheCurrentGame({required int index}) async {
    await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(gameData: state.allGames[index], index: index));
    clearAnswers();
  }
}
