import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_models/games_models.dart';
import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';
import '../widget/dice_pop_up.dart';

part 'dice_state.dart';

class DiceCubit extends Cubit<DiceInitial> with ChangeNotifier {
  // final GameModel gameData;

  DiceCubit({required GameModel gameData})
      : super(DiceInitial(gameData: gameData, correctIndexes: [])) {
    TalkTts.startTalk(text: gameData.inst ?? '');
    List<GameImagesModel> gameImages = gameData.gameImages ?? [];
    gameImages.shuffle();
    List<String> letterDices = [];

    gameData.gameLetters?.forEach((element) {
      letterDices.add(element.letter?.toLowerCase() ?? '');
    });
    // for (int i = (gameData.gameLetters?.length ?? 0); i < 6; i++) {
    //   letterDices.add('');
    // }
    print('letterDices:$letterDices');
    emit(state.copyWith(
        gameData: gameData, letterDices: letterDices, gameImages: gameImages));
    // playTheDice(context: context);
  }

  addTheCorrectAnswer({required int idOfUserAnswer}) async {
    List<int> correctAnswer = state.correctIndexes ?? [];
    print('correctAnswer:${correctAnswer.length}');
    correctAnswer.add(idOfUserAnswer);
    emit(state.clearCurrentAnswer());
    emit(state.copyWith(correctIndexes: correctAnswer));

    print('correctAnswer:${correctAnswer.length}');
  }

  playTheDice(
      {required BuildContext context,
      required void Function(String currentAlphabet)
          functionOfSaveWords}) async {
    print('playTheDice');
    checkTheDiceLetters();
    final p = context.read<DiceCubit>();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => BlocProvider.value(
          value: p,
          child: DicePopUp(
            functionOfSaveWords: functionOfSaveWords,
          )),
    );
  }

  bool checkIfIsTheLastGameOfLesson() {
    int currentIndexOfAnswers = state.correctIndexes?.length ?? 0;
    int currentIndexOfLetters = state.gameData?.gameImages?.length ?? 0;
    if (currentIndexOfAnswers != (currentIndexOfLetters)) {
      return false;
    } else {
      return true;
    }
  }

  checkTheDiceLetters() {
    print('checkTheDiceLetters:${state.gameData}');
    Set<String?> collectedFirstChars = state.gameData?.gameImages
            ?.where((model) =>
                (model.word?.isNotEmpty ?? false) &&
                ((state.correctIndexes?.contains(model.id) == false) ||
                    state.correctIndexes?.contains(model.id) == null))
            .map((model) => model.word?[0])
            .toList()
            .toSet() ??
        {};
    print('collectedFirstChars:$collectedFirstChars');
    List<String?> tempList = collectedFirstChars.toList();
    List<String> tempLetterDices = [];
    for (int i = 0; i < 6; i++) {
      try {
        tempLetterDices.add(tempList[i] ?? '');
      } catch (e) {
        tempLetterDices.add('');
      }
    }
    print('tempLetterDices:${tempLetterDices}');
    emit(state.copyWith(letterDices: tempLetterDices));
  }

  updateSelectedLetter({required String newSelectedLetter}) async {
    emit(state.copyWith(chooseWord: newSelectedLetter));
    await AudioPlayerLetters.startPlaySound(
        soundPath: AssetsSoundLetters.getSoundOfLetter(
            mainGameLetter: newSelectedLetter));
  }
}