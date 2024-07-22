import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/assets_sound_letters.dart';
import '../../../core/audio_player_letters.dart';
import '../../../core/talk_tts.dart';

part 'click_the_sound_state.dart';

class ClickTheSoundCubit extends Cubit<ClickTheSoundInitial> {
  final GameFinalModel _gameData;

  ClickTheSoundCubit({
    required GameFinalModel gameData,
    bool? isArabic,
  })  : _gameData = gameData,
        super(ClickTheSoundInitial(
            gameData: gameData,
            correctIndexes: [],
            isArabic: isArabic ?? false)) {
    generateRandomLetters();
    TalkTts.startTalk(text: _gameData.inst ?? '', isArabic: isArabic ?? false)
        .whenComplete(() {
      sayTheLetter();
    });
  }

  sayTheLetter() async {
    await AudioPlayerLetters.startPlaySound(
        soundPath: AssetsSoundLetters.getSoundOfLetter(
            mainGameLetter: state.gameData.mainLetter ?? ''));
  }

  Future<void> generateRandomLetters() async {
    List<GameLettersGameFinalModel> gameLetters =
        state.gameData.gameLetters ?? [];
    gameLetters.shuffle();
    emit(state.copyWith(letters: gameLetters));
  }

  Future<void> incrementCorrectAnswerCount(int index) async {
    List<int> correctIndexes = state.correctIndexes ?? [];
    correctIndexes.add(index);
    emit(state.copyWith(correctIndexes: correctIndexes));
  }
}
