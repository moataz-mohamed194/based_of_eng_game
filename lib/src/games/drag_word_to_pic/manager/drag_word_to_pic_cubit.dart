import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/talk_tts.dart';

part 'drag_word_to_pic_state.dart';

class DragWordToPicCubit extends Cubit<DragWordToPicInitial> {
  DragWordToPicCubit({
    required GameFinalModel gameData,
  }) : super(DragWordToPicInitial(
          gameData: gameData,
          correctedAnswers: [],
        )) {
    List<GameImagesGameFinalModel>? gameImages = (gameData.gameImages ?? []);
    List<GameImagesGameFinalModel> gamesLetters = gameImages.reversed.toList();

    gamesLetters.shuffle();
    gameImages.shuffle();
    emit(state.copyWith(
        gameImages: _splitListIntoTwo(gameData.gameImages ?? []).first
            as List<GameImagesGameFinalModel>,
        gameImages2: _splitListIntoTwo(gameData.gameImages ?? []).last
            as List<GameImagesGameFinalModel>,
        mainGameImages: gamesLetters));
    TalkTts.startTalk(text: state.gameData.inst??'');
  }
  List<List<GameImagesGameFinalModel>>
      _splitListIntoTwo<GameImagesGameFinalModel>(
          List<GameImagesGameFinalModel> list) {
    int middleIndex = (list.length / 2).ceil();
    List<GameImagesGameFinalModel> firstHalf = list.sublist(0, middleIndex);
    List<GameImagesGameFinalModel> secondHalf = list.sublist(middleIndex);
    return [firstHalf, secondHalf];
  }

  addCorrectAnswer({required int correctAnswerId}) {
    List<int> correctedAnswers = state.correctedAnswers;
    correctedAnswers.add(correctAnswerId);
    emit(state.copyWith(correctedAnswers: correctedAnswers));
  }
}
