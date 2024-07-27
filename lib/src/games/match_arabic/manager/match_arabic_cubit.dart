import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/talk_tts.dart';

part 'match_arabic_state.dart';

class MatchArabicCubit extends Cubit<MatchArabicInitial> {
  MatchArabicCubit({
    required GameFinalModel gameData,
  }) : super(MatchArabicInitial(
          gameData: gameData,
          // listGameData: listGameData,
          answers: gameData.gameLetters ?? [],
          positions: [],
          countQuestions: gameData.gameImages?.length ?? 0,
          widgetKey: [],
          imageAnswers: gameData.gameImages ?? [],
        )) {
    reFormatAnswers();
  }

  reFormatAnswers() {
    GameFinalModel data = state.gameData;
    List<GameLettersGameFinalModel> answers = data.gameLetters ?? [];
    List<GameImagesGameFinalModel> imageAnswers = state.imageAnswers;
    imageAnswers.shuffle();
    emit(state.copyWith(
      imageAnswers: imageAnswers,
      answers: answers,
      positions: List.generate(answers.length, (index) => [null, null]),
      widgetKey: List.generate(answers.length * 3, (index) => GlobalKey()),
    ));
    print('reFormatAnswers:${state.answers.first.id}');
    print('reFormatAnswers:${data.gameImages?.first.id}');
  }

  int addCorrectAnswer(
      {required Offset endPosition,
      required Offset startPosition,
      required int answerId,
      required int imageAnswerId}) {
    int countOfCorrect = state.countCorrectAnswers;
    countOfCorrect++;
    List<List<Offset?>> positions = state.positions;
    positions.insert((countOfCorrect - 1), [startPosition, endPosition]);
    emit(state.copyWith(
        countCorrectAnswers: countOfCorrect, positions: positions));
    List<GameLettersGameFinalModel> answers = state.answers;
    List<GameImagesGameFinalModel> imageAnswers = state.imageAnswers;
    GameLettersGameFinalModel answer2 =
        answers.where((test) => test.id == answerId).first;
    int indexAnswer = answers.indexOf(answer2);
    answers[indexAnswer] =
        GameLettersGameFinalModel(letter: answers[indexAnswer].letter);
    GameImagesGameFinalModel answerImageAnswers2 =
        imageAnswers.where((test) => test.id == imageAnswerId).first;
    int indexImageAnswers = imageAnswers.indexOf(answerImageAnswers2);
    imageAnswers[indexImageAnswers] = GameImagesGameFinalModel(
        word: imageAnswers[indexImageAnswers].word,
        image: imageAnswers[indexImageAnswers].image);
    emit(state.copyWith(
      imageAnswers: imageAnswers,
      answers: answers,
    ));
    return countOfCorrect;
  }

  // updateTheCurrentGame({required int index}) {
  //   debugPrint('updateTheCurrentGame:${state.gameData.id}, $index');
  //   emit(state.copyWith(gameData: state.listGameData[index], index: index));
  //   debugPrint('updateTheCurrentGame:${state.gameData.id}');
  //   reFormatAnswers();
  // }
}
