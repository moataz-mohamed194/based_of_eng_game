import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
// import 'package:meta/meta.dart';

import '../../../../based_of_eng_game.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/talk_tts.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';

part 'magic_card_state.dart';

class MagicCardCubit extends Cubit<MagicCardInitial> {
  MagicCardCubit(
      {required GameFinalModel gameData,
      required CurrentGamePhoneticsCubit mainBloc})
      : super(MagicCardInitial(
          gameData: gameData,
          chooseSecondWord: GameLettersGameFinalModel(),
          chooseFirstWord: GameLettersGameFinalModel(),
        )) {
    reForMateGame();
    startGame(mainBloc: mainBloc);
  }

  reStartCards() {
    emit(state.restartAnswers());
  }

  reForMateGame() {
    GameFinalModel gameData = state.gameData;
    List<GameLettersGameFinalModel> gameLetters = gameData.gameLetters ?? [];
    gameLetters.shuffle();
    emit(state.copyWith(gameLetters: gameLetters));
    TalkTts.startTalk(text: state.gameData.inst ?? '');
  }

  addAnswer({required GameLettersGameFinalModel? userChoose}) {
    print(
        'state.chooseFirstWord:${state.chooseFirstWord.id}, ${state.chooseSecondWord.id}');
    if ((state.chooseFirstWord.id == null)) {
      emit(state.copyWith(chooseFirstWord: userChoose));
      return;
    } else {
      emit(state.copyWith(chooseSecondWord: userChoose));
    }
    if (state.chooseFirstWord.letter == state.chooseSecondWord.letter) {
      _addFinalAnswer();
      return true;
    } else {
      return false;
    }
  }

  _addFinalAnswer() {
    List<int> data = state.answers ?? [];
    data.add(state.chooseSecondWord.id ?? 0);
    data.add(state.chooseFirstWord.id ?? 0);
    emit(state.copyWith(answers: data));
  }

  startGame({required CurrentGamePhoneticsCubit mainBloc}) {
    mainBloc.getStateOfStars(
        mainCountOfQuestion: state.gameData.gameLetters?.length ?? 0);
    mainBloc.saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.stopTalk,
        stateOfStringWillSay: state.gameData.inst ?? '');
  }
}
