import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/export_models.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';

part 'sub_rods_choose_number_state.dart';

class SubRodsChooseNumberCubit extends Cubit<SubRodsChooseNumberInitial> {
  SubRodsChooseNumberCubit(
      {required ToolsOfMath tools, required List<GameFinalModel> allGameData})
      : super(SubRodsChooseNumberInitial(
            index: 0,
            gameData: allGameData.first,
            allGameData: allGameData,
            tools: tools)) {
    reFormatGameData();
  }

  reStartIsCorrect() {
    emit(state.copyWith(isCorrect: false));
  }

  reFormatGameData() {
    reStartIsCorrect();
    int newIndex = state.index;
    GameFinalModel newData = state.allGameData[newIndex];
    List<GameLettersGameFinalModel> gameLetters = newData.gameLetters ?? [];
    List<GameChoicesGameFinalModel> gameChoices = newData.gameChoices ?? [];
    List<GameLettersGameFinalModel> finalGameLetters = [];
    gameLetters.sort((a, b) {
      int aValue = a.mainQuestion ?? -1;
      int bValue = b.mainQuestion ?? -1;
      return aValue.compareTo(bValue);
    });
    for (int i = 0; i < gameLetters.length; i++) {
      if (i != 0) {
        finalGameLetters.add(GameLettersGameFinalModel(letter: '-'));
      }
      finalGameLetters.add(gameLetters[i]);
    }
    emit(state.copyWith(
        gameData: newData,
        finalGameLetters: finalGameLetters,
        gameChoices: gameChoices));
    _sayLetter();
  }

  addAnswer({required GameChoicesGameFinalModel? userChoose}) {
    if (userChoose?.isCorrect == 1) {
      int countCorrectAnswers = state.correctAnswers + 1;
      emit(
          state.copyWith(correctAnswers: countCorrectAnswers, isCorrect: true));
      return true;
    } else {
      return false;
    }
  }

  updateTheCurrentGame({required int index}) {
    TalkTts.reBackTheDefaultValue();
    int newIndex = state.index;
    newIndex++;
    emit(state.copyWith(index: index));
    reFormatGameData();
    TalkTts.reStopTheDefaultValue();
  }

  _sayLetter() async {
    await TalkTts.startTalk(text: state.gameData.inst ?? '');
  }
}
