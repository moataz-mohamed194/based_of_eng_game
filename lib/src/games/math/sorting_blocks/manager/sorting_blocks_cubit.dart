import 'package:based_of_eng_game/src/cubit/current_game_phonetics_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';

part 'sorting_blocks_state.dart';

class SortingBlocksCubit extends Cubit<SortingBlocksInitial> {
  SortingBlocksCubit(
      {required GameFinalModel gameData,
      required ToolsOfMath tools,
      required CurrentGamePhoneticsCubit subBloc})
      : super(SortingBlocksInitial(
          // allGameData: allGameData,
          correctAnswers: [],
          tools: tools,
          gameData: gameData,
          // index: 0
        )) {
    subAction(subBloc: subBloc);
    reFormatGameData();
    _sayLetter();
  }

  reFormatGameData() {
    GameFinalModel newData = state.gameData;
    List<GameChoicesGameFinalModel> gameChoices = newData.gameChoices ?? [];
    List<GameChoicesGameFinalModel> gameChoices2 =
        gameChoices.reversed.toList();
    gameChoices.shuffle();
    gameChoices2.shuffle();
    GameChoicesGameFinalModel mainLetter = gameChoices.reduce((current, next) {
      return int.parse(current.choice ?? '0') > int.parse(next.choice ?? '0')
          ? current
          : next;
    });
    emit(state.copyWith(
        gameData: newData,
        gameChoices: gameChoices,
        mainNumber: int.parse(mainLetter.choice ?? '0'),
        secondGameChoices: gameChoices2));
  }

  addAnswer({required num userChoose, required num secondChoose}) {
    print('userChoose:$userChoose, $secondChoose');
    if (userChoose == secondChoose) {
      List<int> countCorrectAnswers = state.correctAnswers;
      countCorrectAnswers.add(userChoose.toInt());
      emit(state.copyWith(correctAnswers: countCorrectAnswers));
      return true;
    } else {
      return false;
    }
  }

  // updateTheCurrentGame({required int index}) {
  //   TalkTts.reBackTheDefaultValue();
  //   int newIndex = state.index;
  //   newIndex++;
  //   emit(state.copyWith(index: index));
  //   reFormatGameData();
  //   TalkTts.reStopTheDefaultValue();
  // }

  _sayLetter() async {
    await TalkTts.startTalk(text: state.gameData.inst ?? '');
  }

  subAction({required CurrentGamePhoneticsCubit subBloc}) {
    subBloc.getStateOfStars(
        mainCountOfQuestion: state.gameData.gameChoices?.length ?? 0);
    subBloc.saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.stopTalk,
        stateOfStringWillSay: state.gameData.inst ?? '');
  }
}
