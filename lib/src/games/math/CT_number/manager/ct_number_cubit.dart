import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../src_model/export_models.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';

part 'ct_number_state.dart';

class CtNumberCubit extends Cubit<CtNumberInitial> {
  CtNumberCubit(
      {required List<GameFinalModel> allGameData,
      required SymbolsMath tools,
      required CurrentGamePhoneticsCubit subBloc})
      : super(CtNumberInitial(
          gameData: allGameData[0],
          index: 0,
          allGameData: allGameData,
          tools: tools,
        )) {
    subAction(subBloc: subBloc);
    reFormatGame();
  }

  reFormatGame() async {
    GameFinalModel gameData = state.allGameData[state.index ?? 0];
    List<GameLettersGameFinalModel>? gameLetters = gameData.gameLetters;
    String correctAns = gameData.correctAns ?? '';
    emit(state.copyWith(
        gameLetters: gameLetters,
        correctAnswer: correctAns,
        gameData: gameData));
    await TalkTts.startTalk(text: state.gameData.inst ?? '');
  }

  addAnswer({required String? userChoose}) {
    print('addAnswer:$userChoose , ${state.correctAnswer}');
    if (userChoose == state.correctAnswer) {
      int totalOfCorrectAnswer = state.countOfCorrectAnswers ?? 0;
      totalOfCorrectAnswer = totalOfCorrectAnswer + 1;
      emit(state.copyWith(
          countOfCorrectAnswers: totalOfCorrectAnswer,
          currentAnswer: userChoose));
      print('addAnswer:${state.currentAnswer}');

      return true;
    } else {
      return false;
    }
  }

  updateTheCurrentGame({required int newIndex}) {
    TalkTts.reBackTheDefaultValue();
    print('updateTheCurrentGame:$newIndex');
    // int newIndex = state.index;
    // newIndex++;
    emit(state.copyWith(index: newIndex));
    emit(state.clearCurrentAnswer());
    reFormatGame();
    TalkTts.reStopTheDefaultValue();
  }

  subAction({required CurrentGamePhoneticsCubit subBloc}) {
    subBloc.getStateOfStars(mainCountOfQuestion: state.allGameData.length);
    subBloc.saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.stopTalk,
        stateOfStringWillSay: state.gameData.inst ?? '');
  }
}
