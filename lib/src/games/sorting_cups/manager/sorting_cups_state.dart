part of 'sorting_cups_cubit.dart';

class SortingCupsInitial extends Equatable {
  final GameFinalModel gameData;
  final List<GameLettersGameFinalModel>? cardsLetters;
  final List<int>? correctIndexes;
  final GameLettersGameFinalModel? chooseWord;

  const SortingCupsInitial(
      {required this.gameData,
      this.cardsLetters,
      this.correctIndexes,
      this.chooseWord});
  SortingCupsInitial copyWith(
      {GameFinalModel? gameData,
      List<GameLettersGameFinalModel>? cardsLetters,
      GameLettersGameFinalModel? chooseWord,
      List<String>? indexOfCorrectAnswers,
      List<int>? correctIndexes}) {
    return SortingCupsInitial(
        gameData: gameData ?? this.gameData,
        cardsLetters: cardsLetters ?? this.cardsLetters,
        chooseWord: chooseWord ?? this.chooseWord,
        correctIndexes: correctIndexes ?? this.correctIndexes);
  }

  clearCurrentChoose() {
    return SortingCupsInitial(
        gameData: gameData ?? this.gameData,
        cardsLetters: cardsLetters ?? this.cardsLetters,
        chooseWord: null,
        correctIndexes: correctIndexes ?? this.correctIndexes);
  }

  @override
  List<Object?> get props =>
      [gameData, cardsLetters, chooseWord, correctIndexes];
}
