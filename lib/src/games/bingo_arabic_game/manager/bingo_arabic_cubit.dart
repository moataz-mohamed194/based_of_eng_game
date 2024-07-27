import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/assets_game_sound.dart';
import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_game.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';
part 'bingo_arabic_state.dart';

class BingoArabicCubit extends Cubit<BingoArabicState> {
  BingoArabicCubit({required GameFinalModel gameData})
      : super(BingoArabicState(gameData: gameData, correctAnswersIds: [])) {
    emit(state.copyWith(cardsLetters: state.gameData.gameLetters ?? []));
    startSayDataOfGame();
  }
  startSayDataOfGame() async {
    debugPrint('startSayDataOfGame');
    await TalkTts.startTalk(text: state.gameData.inst ?? '', isArabic: true);
    await getTheRandomWord();
  }

  getTheRandomWord() async {
    TalkTts.reBackTheDefaultValue();
    List<GameLettersGameFinalModel> checkLetters = [];

    state.cardsLetters?.forEach((element) {
      debugPrint('${state.correctAnswersIds}');
      if ((state.correctAnswersIds.contains(element.id) == false)) {
        checkLetters.add(element);
      }
    });

    int countOfTheImage = checkLetters.length;
    debugPrint('getTheRandomWord:$countOfTheImage');

    if (countOfTheImage != 0) {
      Random random = Random();
      int randomNumber = random.nextInt(countOfTheImage);
      GameLettersGameFinalModel chooseWord = checkLetters[randomNumber];
      debugPrint('chooseWord:${chooseWord.letter}');
      if (chooseWord.id == null) {
        getTheRandomWord();
        return;
      }
      await AudioPlayerLetters.startPlaySound(
          soundPath: AssetsSoundLetters.getSoundOfLetter(
              mainGameLetter: chooseWord.letter?.toLowerCase() ?? ''));
      emit(state.copyWith(chooseWord: chooseWord));
    }
    TalkTts.reStopTheDefaultValue();
  }

  addTheCorrectAnswer({required int idOfUserAnswer, required int index}) async {
    List<int> correctAnswer = state.correctAnswersIds;
    List<int> correctAnswersIndices = List.from(state.correctAnswersIndices);
    correctAnswersIndices.add(index);
    correctAnswer.add(idOfUserAnswer);

    emit(state.copyWith(
      correctAnswersIds: correctAnswer,
      correctAnswersIndices: correctAnswersIndices,
    ));

    _checkForWin(correctAnswersIndices);
  }

  void _checkForWin(List<int> correctAnswersIndices) {
    int winCaseCount = state.countOfBingoLetters;
    List<Set<int>> newCountedWinCases =
        List.from(state.countedOfRowsOrColumnsCompleted);
    List<Set<int>> winCases = [
      // Rows
      {0, 1, 2},
      {3, 4, 5},
      {6, 7, 8},
      // Columns
      {0, 3, 6},
      {1, 4, 7},
      {2, 5, 8},
    ];

    for (Set<int> winCase in winCases) {
      if (_isNewWinCase(winCase, correctAnswersIndices, newCountedWinCases)) {
        newCountedWinCases.add(winCase);
        winCaseCount++;
      }
    }

    emit(state.copyWith(
      countOfBingoLetters: winCaseCount,
      countedOfRowsOrColumnsCompleted: newCountedWinCases,
    ));
  }

  bool _isNewWinCase(Set<int> winCase, List<int> correctAnswersIndices,
      List<Set<int>> countedWinCases) {
    return winCase.every((index) => correctAnswersIndices.contains(index)) &&
        !countedWinCases.any((existingWinCase) =>
            existingWinCase.containsAll(winCase) &&
            winCase.containsAll(existingWinCase));
  }

  sayTheLetter() async {
    await AudioPlayerLetters.startPlaySound(
        soundPath: AssetsSoundLetters.getSoundOfLetter(
            mainGameLetter: state.chooseWord?.letter?.toLowerCase() ?? ''));
  }

  actionOfCompleteGame() async {
    print('actionOfCompleteGame');
    // await TalkTts.startTalk(text: 'Bingo');
    AudioPlayer playerCorrect = AudioPlayer();

    await AudioPlayerGame.startPlaySoundOfCorrect(
        playerCorrect2: playerCorrect, soundPath: AppGameSound.bingo);
  }
}
