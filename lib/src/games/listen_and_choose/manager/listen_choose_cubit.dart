import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';

part 'listen_choose_state.dart';

class ListenChooseCubit extends Cubit<ListenChooseInitial> {
  ListenChooseCubit(
      {required int index, required List<GameFinalModel> listGameData})
      : super(ListenChooseInitial(
          index: index,
          listGameData: listGameData,
          gameData: listGameData[index],
          choose: [],
          images: [],
        )) {
    reForMateGame();
  }
  reForMateGame() {
    emit(state.copyWith(
        choose: state.listGameData[state.index].gameLetters,
        images: state.listGameData[state.index].gameImages,
        isCorrect: false,
        gameData: state.listGameData[state.index]));
    String choose = state.gameData.correctAns ?? '';
    emit(state.copyWith(correctAnswer: choose));

    _sayLetter();
  }

  updateTheCurrentGame({required int index}) {
    // debugPrint('updateTheCurrentGame:${state.gameData.id}, $index');
    emit(state.copyWith(gameData: state.listGameData[index], index: index));
    // debugPrint('updateTheCurrentGame:${state.gameData.id}');
    reForMateGame();
  }

  bool addAnswer({required String userChoose}) {
    String choose = state.gameData.correctAns ?? '';
    print('choose:$choose , $userChoose , ${state.gameData.inst}');
    debugPrint('updateTheCurrentGame:${state.gameData.id}, ${state.index}');

    if (userChoose == choose) {
      int countCorrectAnswers = state.countCorrectAnswers + 1;
      emit(state.copyWith(
          countCorrectAnswers: countCorrectAnswers, isCorrect: true));
      return true;
    } else {
      return false;
    }
  }

  _sayLetter() async {
    await TalkTts.startTalk(text: "${state.gameData.inst ?? ''} ${state.gameData.sentence??''}");
  }
}
