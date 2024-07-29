import 'package:based_of_eng_game/src/core/talk_tts.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../src_model/export_models.dart';

part 'drag_pic_to_word_state.dart';

class DragPicToWordCubit extends Cubit<DragPicToWordInitial> {
  DragPicToWordCubit({
    required GameFinalModel gameData,
    bool isArabic = false,
  }) : super(DragPicToWordInitial(
            gameData: gameData,
            // gameImages: gameData.gameImages ?? [],
            correctedAnswers: [],
            isArabic: isArabic
            // gamesLetters:[]
            )) {
    reFormatGame();
    TalkTts.startTalk(text: state.gameData.inst ?? '', isArabic: isArabic);
  }

  reFormatGame() {
    List<GameImagesGameFinalModel> gameImages = state.gameData.gameImages ?? [];
    List<GameImagesGameFinalModel> gamesLetters = gameImages.reversed.toList();
    gameImages.shuffle();
    gamesLetters.shuffle();
    emit(state.copyWith(gamesLetters: gamesLetters, gameImages: gameImages));
  }

  addCorrectAnswer({required int correctAnswerId}) {
    List<int> correctedAnswers = state.correctedAnswers;
    correctedAnswers.add(correctAnswerId);
    emit(state.copyWith(correctedAnswers: correctedAnswers));
  }
}
