import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../src_model/export_models.dart';

import '../../../core/talk_tts.dart';
part 'click_the_picture_with_word_state.dart';

class ClickThePictureWithWordCubit
    extends Cubit<ClickThePictureWithWordInitial> {
  ClickThePictureWithWordCubit(
      {required GameFinalModel gameData,
      required List<String> backGround,
      required bool isArabic})
      : super(ClickThePictureWithWordInitial(
            gameData: gameData,
            backGround: backGround,
            correctIndexes: [],
            isArabic: isArabic)) {
    List<GameImagesGameFinalModel> gameImages = state.gameData.gameImages ?? [];
    gameImages.shuffle();
    emit(state.copyWith(gameImages: gameImages));
    startGame();
    // emit(state.copyWith(gameImages: gameData.gameImages));
  }

  startGame() async {
    await TalkTts.startTalk(
        text: state.gameData.inst ?? '', isArabic: state.isArabic);

    await getTheRandomWord();
  }

  getTheRandomWord() async {
    // if () {
    List<GameImagesGameFinalModel> checkImages = state.gameImages
            ?.where(
                (element) => state.correctIndexes.contains(element.id) == false)
            .toList() ??
        [];
    // state.gameData.gameImages?.forEach((element) {
    //   if ( == false) {
    //     checkImages.add(element);
    //   }
    // });
    int countOfTheImage = checkImages.length;
    debugPrint('countOfTheImage:$countOfTheImage, ${state.chooseWord}');
    if (countOfTheImage != 0 && state.chooseWord == null) {
      Random random = Random();
      int randomNumber = random.nextInt(countOfTheImage);
      GameImagesGameFinalModel chooseWord = checkImages[randomNumber];
      debugPrint('chooseWord.word ?? ' ':${chooseWord.word ?? ''}');
      await TalkTts.startTalk(
          text: chooseWord.word ?? '', isArabic: state.isArabic);
      emit(state.copyWith(chooseWord: chooseWord));
    }
    // }
  }

  Future addTheCorrectAnswer(
      {required int idOfUserAnswer, bool? isArabic}) async {
    debugPrint('addTheCorrectAnswer');
    emit(state.clearChooseWord());

    List<int> correctAnswer = state.correctIndexes;
    correctAnswer.add(idOfUserAnswer);
    emit(state.copyWith(correctIndexes: correctAnswer));
    debugPrint("${state.chooseWord}");
    // getTheRandomWord();
  }

  sayTheLetter() async {
    await TalkTts.startTalk(
        text: state.chooseWord?.word ?? '', isArabic: state.isArabic);
  }

  // submitCorrectTheAnswer() async {
  //   int sub = state.correctAnswer ?? 0;
  //   sub = sub + 1;
  //   emit(state.copyWith(correctAnswer: sub));
  // }

  // submitWrongTheAnswer(
  //     {required Function() wrongAnimation,
  //     required Function() reStateOfAvatar}) {
  //   wrongAnimation();
  //   reStateOfAvatar();
  // }

  // sayTheCorrectAnswer() async {
  //   print('sayTheCorrectAnswer:${state.chooseWord?.word}');
  //   await TalkTts.startTalk(text: state.chooseWord?.word ?? '');
  // }
}
