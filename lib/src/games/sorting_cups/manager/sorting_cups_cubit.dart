import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../src_model/export_models.dart';

import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';

part 'sorting_cups_state.dart';

class SortingCupsCubit extends Cubit<SortingCupsInitial> {
  final GameFinalModel gameData;

  SortingCupsCubit({required this.gameData, bool isArabic = false})
      : super(SortingCupsInitial(gameData: gameData, isArabic: isArabic)) {
    List<GameLettersGameFinalModel> cardsLetters = gameData.gameLetters ?? [];
    cardsLetters.shuffle();
    emit(state.copyWith(gameData: gameData, cardsLetters: cardsLetters));
    initStart();
  }

  initStart() async {
    await TalkTts.startTalk(
        text: state.gameData.inst ?? '', isArabic: state.isArabic);

    getTheRandomWord();
  }

  addTheCorrectAnswer({required int idOfUserAnswer}) async {
    emit(state.clearCurrentChoose());
    List<int> correctAnswer = state.correctIndexes ?? [];
    correctAnswer.add(idOfUserAnswer);
    emit(state.copyWith(correctIndexes: correctAnswer));
  }

  bool checkIfIsTheLastGameOfLesson() {
    int currentIndexOfAnswers = state.correctIndexes?.length ?? 0;
    int currentIndexOfLetters = state.cardsLetters?.length ?? 0;
    if (currentIndexOfAnswers != (currentIndexOfLetters)) {
      return false;
    } else {
      return true;
    }
  }

  getTheRandomWord() async {
    List<GameLettersGameFinalModel> checkImages = [];

    state.gameData.gameLetters?.forEach((element) {
      if (state.correctIndexes == null ||
          (state.correctIndexes?.contains(element.id) == false)) {
        checkImages.add(element);
      }
    });
    int countOfTheImage = checkImages.length;
    if (countOfTheImage != 0) {
      Random random = Random();
      int randomNumber = random.nextInt(countOfTheImage);
      GameLettersGameFinalModel chooseWord = checkImages[randomNumber];
      await AudioPlayerLetters.startPlaySound(
          soundPath: AssetsSoundLetters.getSoundOfLetter(
              mainGameLetter: chooseWord.letter?.toLowerCase() ?? ''));
      emit(state.copyWith(chooseWord: chooseWord));
    }
  }

  sayTheLetter() async {
    GameLettersGameFinalModel? chooseWord = state.chooseWord;
    if (chooseWord != null) {
      await AudioPlayerLetters.startPlaySound(
          soundPath: AssetsSoundLetters.getSoundOfLetter(
              mainGameLetter: chooseWord.letter?.toLowerCase() ?? ''));
    }
  }
}
