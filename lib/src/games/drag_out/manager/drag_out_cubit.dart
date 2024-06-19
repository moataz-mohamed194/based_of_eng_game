import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:games_models/games_models.dart';

import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';
part 'drag_out_state.dart';

class DragOutCubit extends Cubit<DragOutInitial> {
  // final GameModel _gameData;
  DragOutCubit(
      {required GameModel gameData,
      required List<GameModel> allGameData,
      required int index})
      : super(DragOutInitial(
            gameData: gameData, allGameData: allGameData, index: index)) {
    // emit(state.copyWith(gameData: gameData));
    print('DragOutCubit');
    emit(state.copyWith(gameData: allGameData[index]));
    sayLetter();
  }

  // Future<int> increaseCountOfCorrectAnswers() async {
  //   int sub = state.correctAnswer ?? 0;
  //   sub = sub + 1;
  //   emit(state.copyWith(correctAnswer: sub));
  //   return Future.value(state.correctAnswer);
  // }

  // bool checkIfIsTheLastGameOfLesson() {
  //   int currentIndex = state.index ?? 0;
  //   currentIndex = currentIndex + 1;
  //
  //   if ((state.gameData.length) > currentIndex) {
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  // updateIndexOfCurrentGame() {
  //   int currentIndex = state.index ?? 0;
  //   currentIndex = currentIndex + 1;
  //   emit(state.copyWith(index: currentIndex));
  // }

  updateTheCurrentGame({required int index}) {
    print('updateTheCurrentGame:${state.gameData.id}, $index');
    emit(state.copyWith(gameData: state.allGameData[index], index: index));
    print('updateTheCurrentGame:${state.gameData.id}');
  }

  sayLetter() async {
    await TalkTts.startTalk(text: state.gameData.inst ?? '');

    await AudioPlayerLetters.startPlaySound(
        soundPath: AssetsSoundLetters.getSoundOfLetter(
            mainGameLetter: state.gameData.mainLetter ?? ''));
  }
}