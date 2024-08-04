import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/talk_tts.dart';

part 'match_state.dart';

class MatchCubit extends Cubit<MatchInitial> {
  MatchCubit({
    required GameFinalModel gameData,
  }) : super(MatchInitial(
          gameData: gameData,
          // listGameData: listGameData,
          answers: [],
          idsOfCorrectAnswers: [],
          positions: [],
          countQuestions: gameData.gameImages?.length ?? 0,
          widgetKey: [],
          imageAnswers: [],
        )) {
    reFormatAnswers();
  }

  reFormatAnswers() {
    GameFinalModel data = state.gameData;

    List<GameLettersGameFinalModel> answers = data.gameLetters ?? [];
    List<GameImagesGameFinalModel> imageAnswers = data.gameImages ?? [];
    answers.shuffle();
    imageAnswers.shuffle();
    emit(state.copyWith(
      imageAnswers: imageAnswers,
      answers: answers,
      idsOfCorrectAnswers: [],
      positions: List.generate(answers.length, (index) => [null, null]),
      widgetKey: List.generate(answers.length * 3, (index) => GlobalKey()),
    ));
    _sayLetter();
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
    // List<GameLettersGameFinalModel> answers = state.answers;
    List<GameImagesGameFinalModel> imageAnswers = state.imageAnswers;
    // GameLettersGameFinalModel answer2 =
    //     answers.where((test) => test.id == answerId).first;
    List<int> idsOfCorrectAnswers =
        state.idsOfCorrectAnswers; //.indexOf(answer2);
    idsOfCorrectAnswers.add(answerId);
    // answers[indexAnswer] = GameLettersGameFinalModel(letter: answers[indexAnswer].letter);
    GameImagesGameFinalModel answerImageAnswers2 =
        imageAnswers.where((test) => test.id == imageAnswerId).first;
    int indexImageAnswers = imageAnswers.indexOf(answerImageAnswers2);
    imageAnswers[indexImageAnswers] = GameImagesGameFinalModel(
        word: imageAnswers[indexImageAnswers].word,
        image: imageAnswers[indexImageAnswers].image);
    emit(state.copyWith(
      imageAnswers: imageAnswers,
      idsOfCorrectAnswers: idsOfCorrectAnswers,
    ));
    return countOfCorrect;
  }

  _sayLetter() async {
    await TalkTts.startTalk(text: state.gameData.inst ?? '');
  }
  // updateTheCurrentGame({required int index}) {
  //   debugPrint('updateTheCurrentGame:${state.gameData.id}, $index');
  //   emit(state.copyWith(gameData: state.listGameData[index], index: index));
  //   debugPrint('updateTheCurrentGame:${state.gameData.id}');
  //   reFormatAnswers();
  // }
}
