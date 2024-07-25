import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../based_of_eng_game.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/talk_tts.dart';

part 'drag_oe_state.dart';

class DragOeCubit extends Cubit<DragOeInitial> {
  DragOeCubit({
    required List<GameFinalModel> allGameData,
    required BasicOfGameData basicData,
  }) : super(DragOeInitial(
            allGameData: allGameData,
            correctAnswers: [],
            basicData: basicData,
            gameData: allGameData[0],
            index: 0)) {
    reFormatGameData();
  }
  reFormatGameData() {
    int newIndex = state.index;
    GameFinalModel newData = state.allGameData[newIndex];
    List<GameChoicesGameFinalModel> gameChoices = newData.gameChoices ?? [];
    gameChoices.shuffle();
    emit(state.copyWith(gameData: newData, gameChoices: gameChoices));
    _sayLetter();
  }

  addAnswer({required GameChoicesGameFinalModel? userChoose}) {
    if (userChoose?.isCorrect == 1) {
      List<GameChoicesGameFinalModel> countCorrectAnswers =
          state.correctAnswers;
      countCorrectAnswers.add(userChoose!);
      emit(state.copyWith(correctAnswers: countCorrectAnswers));
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
