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
    List<GameChoicesGameFinalModel> subHeadOfQuestions = [];
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

  bool addTheDragAnswer(
      {required GameChoicesGameFinalModel answer, required bool isFirst}) {
    bool result = mainAddTheDragAnswer(answer: answer, isFirst: isFirst);
    if (result == false) {
      emit(state.clearTheDataOfChoose());
    }
    return result;
  }

  bool mainAddTheDragAnswer(
      {required GameChoicesGameFinalModel answer, required bool isFirst}) {
    if (answer.isCorrect == 1) {
      if (isFirst == true) {
        emit(state.copyWith(firstChooseInDrag: answer));
        return true;
      } else if (isFirst == false) {
        int result = int.parse("${state.firstChooseInDrag?.choice ?? 0}") +
            int.parse("${answer.choice ?? 0}");
        if ("$result" == state.numberOfAnswerFirstBox) {
          int countOfCorrectAnswers = state.countOfCorrectAnswers ?? 0;
          countOfCorrectAnswers = countOfCorrectAnswers + 1;
          emit(state.copyWith(
              secondChooseInDrag: answer,
              countOfCorrectAnswers: countOfCorrectAnswers));
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
    return false;
  }

  bool addTheTypingAnswer({required String answer, required bool isFirst}) {
    bool result = mainAddTheTypingAnswer(answer: answer, isFirst: isFirst);
    if (result == false) {
      emit(state.clearTheDataOfChoose());
    }
    return result;
  }

  bool mainAddTheTypingAnswer({required String answer, required bool isFirst}) {
    if (state.firstChooseInDrag == null && state.secondChooseInDrag == null) {
      return false;
    }
    if (isFirst == true) {
      if (answer == state.numberOfAnswerFirstBox) {
        emit(state.copyWith(showTheAnswerOfFirstTyping: true));
        return true;
      }
      return false;
    } else if (isFirst == false) {
      if (state.firstChooseInDrag == null &&
          state.secondChooseInDrag == null &&
          state.showTheAnswerOfFirstTyping == true) {
        return false;
      }
      if (answer == state.correctAns) {
        emit(state.copyWith(showTheAnswerOfSecondTyping: true));
        return true;
      } else {
        return false;
      }
    }

    return false;
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
