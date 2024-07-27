part of 'bingo_arabic_cubit.dart';

@immutable
class BingoArabicState extends Equatable {
  final List<GameLettersGameFinalModel>? cardsLetters;
  final GameFinalModel gameData;
  final List<int> correctAnswersIds;
  final List<int> correctAnswersIndices;
  final GameLettersGameFinalModel? chooseWord;
  final List<Set<int>> countedOfRowsOrColumnsCompleted;
  final int countOfBingoLetters;

  const BingoArabicState({
    required this.gameData,
    required this.correctAnswersIds,
    this.cardsLetters,
    this.chooseWord,
    this.correctAnswersIndices = const [],
    this.countOfBingoLetters = 0,
    this.countedOfRowsOrColumnsCompleted = const [],
  });

  BingoArabicState copyWith({
    GameFinalModel? gameData,
    List<GameLettersGameFinalModel>? cardsLetters,
    GameLettersGameFinalModel? chooseWord,
    List<String>? indexOfCorrectAnswers,
    List<int>? correctAnswersIds,
    List<int>? correctAnswersIndices,
    List<Set<int>>? countedOfRowsOrColumnsCompleted,
    int? countOfBingoLetters,
  }) {
    return BingoArabicState(
      gameData: gameData ?? this.gameData,
      cardsLetters: cardsLetters ?? this.cardsLetters,
      chooseWord: chooseWord ?? this.chooseWord,
      correctAnswersIds: correctAnswersIds ?? this.correctAnswersIds,
      correctAnswersIndices:
          correctAnswersIndices ?? this.correctAnswersIndices,
      countOfBingoLetters: countOfBingoLetters ?? this.countOfBingoLetters,
      countedOfRowsOrColumnsCompleted: countedOfRowsOrColumnsCompleted ??
          this.countedOfRowsOrColumnsCompleted,
    );
  }

  BingoArabicState clearAllData() {
    return BingoArabicState(gameData: gameData, correctAnswersIds: []);
  }

  @override
  List<Object?> get props => [
        gameData,
        correctAnswersIds,
        cardsLetters,
        chooseWord,
        correctAnswersIndices,
        countOfBingoLetters,
        countedOfRowsOrColumnsCompleted
      ];
}
