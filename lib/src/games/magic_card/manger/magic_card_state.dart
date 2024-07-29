part of 'magic_card_cubit.dart';

@immutable
class MagicCardInitial extends Equatable {
  final GameFinalModel gameData;
  final GameLettersGameFinalModel? chooseSecondWord;
  final GameLettersGameFinalModel? chooseFirstWord;
  final List<GameLettersGameFinalModel>? gameLetters;
  final List<int>? answers;

  MagicCardInitial(
      {required this.gameData,
      this.chooseSecondWord,
      this.chooseFirstWord,
      this.gameLetters,
      this.answers});

  MagicCardInitial copyWith(
      {GameFinalModel? gameData,
      GameLettersGameFinalModel? chooseSecondWord,
      GameLettersGameFinalModel? chooseFirstWord,
      List<GameLettersGameFinalModel>? gameLetters,
      List<int>? answers}) {
    return MagicCardInitial(
        gameData: gameData ?? this.gameData,
        chooseSecondWord: chooseSecondWord ?? this.chooseSecondWord,
        chooseFirstWord: chooseFirstWord ?? this.chooseFirstWord,
        gameLetters: gameLetters ?? this.gameLetters,
        answers: answers ?? this.answers);
  }

  MagicCardInitial restart(
      {GameFinalModel? gameData,
      GameLettersGameFinalModel? chooseSecondWord,
      GameLettersGameFinalModel? chooseFirstWord,
      List<GameLettersGameFinalModel>? gameLetters,
      List<int>? answers}) {
    return MagicCardInitial(
        gameData: gameData ?? this.gameData,
        chooseSecondWord: chooseSecondWord ?? this.chooseSecondWord,
        chooseFirstWord: chooseFirstWord ?? this.chooseFirstWord,
        gameLetters: gameLetters ?? this.gameLetters,
        answers: answers ?? this.answers);
  }

  @override
  List<Object?> get props =>
      [gameData, chooseFirstWord, chooseSecondWord, gameLetters, answers];
}
