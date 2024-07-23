import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../src_model/export_models.dart';

import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';
part 'x_out_state.dart';

class XOutCubit extends Cubit<XOutInitial> {
  XOutCubit(
      {required List<GameFinalModel> listGameData,
      required int index,
      bool isArabic = false})
      : super(XOutInitial(
          listGameData:
              listGameData.where((element) => element.isEdited == 0).toList(),
          currentGameIndex: index,
          isArabic: isArabic,
        )) {
    emit(state.copyWith(gameData: state.listGameData[index]));
    _reFormatData();
    _startSayGame();
  }
  _reFormatData() {
    List<GameImagesGameFinalModel> gameImages =
        state.gameData?.gameImages ?? [];
    gameImages.shuffle();
    emit(state.copyWith(gameImages: gameImages));
  }

  Future<void> selectItem(int index) async {
    final selectedItems = state.selectedItems ?? [];

    if (!selectedItems.contains(index)) {
      final updatedSelectedItems = List<int>.from(selectedItems)..add(index);

      emit(state.copyWith(
        selectedItems: updatedSelectedItems,
      ));
    }
  }

  updateTheCurrentGame({required int index}) async {
    await Future.delayed(const Duration(seconds: 2));

    emit(state.clearCurrentCorrectAnswers());
    emit(state.copyWith(
        gameData: state.listGameData[index], currentGameIndex: index));
    _reFormatData();
    sayTheLetter();
  }

  _startSayGame() async {
    await TalkTts.startTalk(
        text: state.gameData?.inst ?? '', isArabic: state.isArabic);
    await AudioPlayerLetters.startPlaySound(
        soundPath: AssetsSoundLetters.getSoundOfLetter(
            mainGameLetter: (state.gameData?.mainLetter ?? '')));
  }

  sayTheLetter() async {
    await Future.delayed(const Duration(seconds: 1));
    await AudioPlayerLetters.startPlaySound(
        soundPath: AssetsSoundLetters.getSoundOfLetter(
            mainGameLetter: (state.gameData?.mainLetter ?? '')));
  }

  addWrongAnswer({required int isWrong}) {
    emit(state.copyWith(isWrong: isWrong));
  }

  clearWrongAnswer() {
    emit(state.clearWrongStateAnswer());
  }
}
