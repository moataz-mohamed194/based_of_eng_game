import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../src_model/export_models.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/talk_tts.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';

part 'ddt_number_state.dart';

class DDTChangeCubit extends Cubit<DDTChangeInitial> {
  DDTChangeCubit(
      {required List<GameFinalModel> allGameData,
      required CurrentGamePhoneticsCubit subBloc})
      : super(DDTChangeInitial(
          gameData: allGameData[0],
          index: 0,
          allGameData: allGameData,
        )) {
    subAction(subBloc: subBloc);
    reFormatGame();
  }

  reFormatGame() async {
    GameFinalModel gameData = state.allGameData[state.index ?? 0];
    List<GameImagesGameFinalModel> headOfQuestions = gameData.gameImages ?? [];
    List<GameChoicesGameFinalModel> chooseOfQuestions =
        gameData.gameChoices ?? [];
    String numberOfAnswerFirstBox = gameData.gameLetters?.first.letter ?? "";
    String numberWillAddToAnswerFirstBox =
        gameData.gameLetters?.first.secLetter ?? "";
    String correctAns = gameData.correctAns ?? "";
    emit(state.copyWith(
        headOfQuestions: headOfQuestions,
        chooseOfQuestions: chooseOfQuestions,
        numberOfAnswerFirstBox: numberOfAnswerFirstBox,
        numberWillAddToAnswerFirstBox: numberWillAddToAnswerFirstBox,
        correctAns: correctAns,
        gameData: gameData));
    await TalkTts.startTalk(text: state.gameData.inst ?? '');
  }

  addAnswerOfDrag({required GameChoicesGameFinalModel? userChoose}) {
    if (userChoose?.isCorrect == 1) {
      GameChoicesGameFinalModel? first;
      GameChoicesGameFinalModel? second;

      if (state.firstChooseInDrag == null) {
        first = userChoose;
        emit(state.copyWith(firstChooseInDrag: userChoose));
      } else if (state.secondChooseInDrag == null) {
        second = userChoose;
        emit(state.copyWith(secondChooseInDrag: userChoose));
      }
      if (first != null && second != null) {
        int resultOfDrag =
            int.parse(first.choice ?? '0') + int.parse(second.choice ?? '0');
        if (resultOfDrag == int.parse(state.numberOfAnswerFirstBox ?? '0')) {
          return true;
        } else {
          return false;
        }
      }
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
    emit(state.clearTheDataOfChoose());
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
