import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/talk_tts.dart';

part 'sorting_state.dart';

class SortingCubit extends Cubit<SortingInitial> {
  SortingCubit(
      {required List<GameFinalModel> listGameData,
      required String background,
      required int index,
      bool isArabic = false})
      : super(SortingInitial(
            gameData: listGameData[index],
            woodenBackground: background,
            currentImages: [],
            index: index,
            correctAnswersData: [],
            correctAnswersIds: [],
            listGameData: listGameData,
            isArabic: isArabic,
            countOfQuestion: listGameData.fold(
                0,
                (previousValue, element) =>
                    previousValue + (element.gameImages?.length ?? 0)))) {
    print('###index:${index}');
    emit(state.copyWith(
        cardsLetters: state.listGameData.first.gameLetters,
        correctAnswersIds: []));
    changeImages();
    TalkTts.startTalk(
        text: state.listGameData.first.inst ?? '', isArabic: state.isArabic);
  }

  changeImages() {
    List<GameImagesGameFinalModel> newList =
        (state.listGameData[state.index].gameImages ?? [])
            .where((element) =>
                state.correctAnswersIds.contains(element.id) == false)
            .toList();
    newList.shuffle();
    emit(state.copyWith(currentImages: newList));
  }

  addTheCorrectAnswer({required GameImagesGameFinalModel answer}) async {
    List<GameImagesGameFinalModel> correctAnswersData =
        state.correctAnswersData;
    List<int> correctAnswersIds = state.correctAnswersIds;
    correctAnswersData.add(answer);
    List<GameImagesGameFinalModel> newImagesList = state.currentImages;
    newImagesList.removeWhere((element) => element.id == answer.id);
    correctAnswersIds.add(answer.id ?? 0);
    emit(state.copyWith(
        correctAnswersData: correctAnswersData,
        currentImages: newImagesList,
        correctAnswersIds: correctAnswersIds));
  }

  clearAnswers() {
    emit(state.copyWith(correctAnswersIds: []));
  }

  updateTheCurrentGame({required int index}) {
    debugPrint('updateTheCurrentGame:${state.gameData.id}, $index');
    emit(state.copyWith(
      gameData: state.listGameData[index],
      index: index,
      cardsLetters: state.listGameData[index].gameLetters,
    ));
    changeImages();
    debugPrint('updateTheCurrentGame:${state.gameData.id}');
  }

  bool _checkIds(List<int> ids, List<GameImagesGameFinalModel> objs) {
    for (var obj in objs) {
      if (ids.contains(obj.id)) {
        // print('Object with ID ${obj.id} is in the list.');
      } else {
        return false;
      }
    }
    return true;
  }

  bool checkIfIsTheLastQuestionOfGame() {
    // int x= state.correctAnswersIds.where(test)
    // state.listGameData[state.index].gameImages.where((test)=> test.id == )
    // state.listGameData[state.index].gameLetters.
    // _checkIds(state.correctAnswersIds,state.listGameData[state.index].gameImages??[]);
    if (_checkIds(state.correctAnswersIds,
        state.listGameData[state.index].gameImages ?? [])) {
      return true;
    } else {
      return false;
    }
  }
}
