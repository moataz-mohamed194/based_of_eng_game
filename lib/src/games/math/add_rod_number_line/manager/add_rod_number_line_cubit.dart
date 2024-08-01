import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/export_models.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';

part 'add_rod_number_line_state.dart';

class AddRodNumberLineCubit extends Cubit<AddRodNumberLineInitial> {
  AddRodNumberLineCubit(
      {required ToolsOfMath tools, required List<GameFinalModel> allGameData})
      : super(AddRodNumberLineInitial(
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
    List<GameChoicesGameFinalModel> gameChoices = newData.gameChoices ?? [];

    // gameChoices.forEach((action){
    //   if()
    // });
    GameChoicesGameFinalModel correctAnswer = (newData.gameChoices ?? [])
        .where((element) => element.isCorrect == 1)
        .toList()
        .first;
    List<GameLettersGameFinalModel> gameLetters = newData.gameLetters ?? [];
    List<GameLettersGameFinalModel> finalGameLetters = [];
    for (int i = 0; i < gameLetters.length; i++) {
      if (i != 0) {
        finalGameLetters.add(GameLettersGameFinalModel(letter: '+'));
      }
      finalGameLetters.add(gameLetters[i]);
    }
    gameChoices.shuffle();
    emit(state.copyWith(
        gameData: newData,
        gameChoices: gameChoices,
        finalGameLetters: finalGameLetters,
        correctAnswer: correctAnswer));
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
