import 'package:based_of_eng_game/src/core/assets_sound_letters.dart';
import 'package:based_of_eng_game/src/core/audio_player_game.dart';
import 'package:based_of_eng_game/src/core/audio_player_letters.dart';
import 'package:based_of_eng_game/src/core/talk_tts.dart';
import 'package:based_of_eng_game/src_model/model/game_images_model.dart';
import 'package:based_of_eng_game/src_model/model/game_letters_model.dart';
import 'package:based_of_eng_game/src_model/model/game_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'click_to_choose_state.dart';

class ClickToChooseCubit extends Cubit<ClickToChooseState> {
  ClickToChooseCubit(
      {required int index,
      required List<GameFinalModel> listGameData,
      required ClickToChooseType type})
      : super(ClickToChooseState(
          type: type,
          index: index,
          listGameData: listGameData,
          gameData: listGameData[index],
          mainImage: [],
          choices: [],
        )) {
    reForMateGame();
  }
  void reForMateGame() {
    emit(state.copyWith(
        mainImage: state.listGameData[state.index].gameLetters,
        choices: state.listGameData[state.index].gameImages,
        isCorrect: false,
        gameData: state.listGameData[state.index]));
    String choose = state.gameData.correctAns ?? '';
    emit(state.copyWith(correctAnswer: choose));

    _sayLetter();
  }

  void updateTheCurrentGame({required int index}) {
    TalkTts.reBackTheDefaultValue();
    debugPrint('updateTheCurrentGame:${state.gameData.id}, $index');
    emit(state.copyWith(gameData: state.listGameData[index], index: index));
    debugPrint('updateTheCurrentGame:${state.gameData.id}');
    reForMateGame();
  }

  bool addAnswer({required GameImagesGameFinalModel image}) {
    if (image.correct == 1) {
      int countCorrectAnswers = state.countCorrectAnswers + 1;
      emit(state.copyWith(
          countCorrectAnswers: countCorrectAnswers, isCorrect: true));
      return true;
    } else {
      return false;
    }
  }

  Future<void> _sayLetter() async {
    await TalkTts.startTalk(
      text: state.gameData.inst ?? '',
    );
  }

  Future<void> makeSoundOfImage() async {
    await AudioPlayerLetters.startPlaySound(
        soundPath: AssetsSoundLetters.getSoundOfLetter(
            mainGameLetter: state.mainImage.first.letter ?? ''));
  }
}
