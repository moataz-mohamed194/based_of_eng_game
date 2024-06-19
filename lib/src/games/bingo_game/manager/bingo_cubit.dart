import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:games_models/games_models.dart';

import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';
part 'bingo_state.dart';

class BingoCubit extends Cubit<BingoInitial> {
  BingoCubit({required GameModel gameData})
      : super(BingoInitial(gameData: gameData, correctIndexes: [])) {

    List<GameLettersModel> supList = (state.gameData.gameLetters ?? [])
        .where((element) => element.id != null)
        .toList();
    supList.insert(4, const GameLettersModel());
    emit(state.copyWith(cardsLetters: supList.toList()));
    startSayDataOfGame();
  }
  startSayDataOfGame() async {
    print('startSayDataOfGame');
    await TalkTts.startTalk(text: state.gameData.inst ?? '');
    await getTheRandomWord();
  }

  getTheRandomWord() async {
    List<GameLettersModel> checkLetters = [];

    state.cardsLetters?.forEach((element) {
      print('${state.correctIndexes}');
      if ((state.correctIndexes.contains(element.id) == false)) {
        checkLetters.add(element);
      }
    });

    int countOfTheImage = checkLetters.length;
    print('getTheRandomWord:$countOfTheImage');

    if (countOfTheImage != 0) {
      Random random = Random();
      int randomNumber = random.nextInt(countOfTheImage);
      GameLettersModel chooseWord = checkLetters[randomNumber];
      print('chooseWord:${chooseWord.letter}');
      if (chooseWord.id == null) {
        getTheRandomWord();
        return;
      }
      await AudioPlayerLetters.startPlaySound(
          soundPath: AssetsSoundLetters.getSoundOfLetter(
              mainGameLetter: chooseWord.letter?.toLowerCase() ?? ''));
      emit(state.copyWith(chooseWord: chooseWord));
    }
  }

  addTheCorrectAnswer({required int idOfUserAnswer}) async {
    List<int> correctAnswer = state.correctIndexes ?? [];
    correctAnswer.add(idOfUserAnswer);
    emit(state.copyWith(correctIndexes: correctAnswer));
  }

  sayTheLetter() async {
    await AudioPlayerLetters.startPlaySound(
        soundPath: AssetsSoundLetters.getSoundOfLetter(
            mainGameLetter: state.chooseWord?.letter?.toLowerCase() ?? ''));
  }
}
