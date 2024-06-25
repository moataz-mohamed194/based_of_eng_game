part of 'spelling_cubit.dart';

@immutable
class SpellingInitial extends Equatable {
  final List<GameLettersGameFinalModel>? cardsLetters;
  final List<GameFinalModel> allGames;
  final GameFinalModel? gameData;
  final List<String> correctAnswers;
  // final int? correctAnswer;
  final String? woodenBackground;
  final int index;

  const SpellingInitial(
      {required this.allGames,
      required this.correctAnswers,
      this.cardsLetters,
      this.index = 0,
      this.gameData,
      this.woodenBackground});

  SpellingInitial copyWith(
      {List<GameFinalModel>? allGames,
      GameFinalModel? gameData,
      List<GameLettersGameFinalModel>? cardsLetters,
      GameLettersGameFinalModel? chooseWord,
      int? correctAnswer,
      int? countOfWrong,
      int? index,
      List<String>? indexOfCorrectAnswers,
      List<String>? correctAnswers,
      String? woodenBackground}) {
    return SpellingInitial(
      allGames: allGames ?? this.allGames,
      index: index ?? this.index,
      cardsLetters: cardsLetters ?? this.cardsLetters,
      gameData: gameData ?? this.gameData,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      woodenBackground: woodenBackground ?? this.woodenBackground,
      // countOfWrong: countOfWrong ?? this.countOfWrong,
    );
  }

  @override
  List<Object?> get props => [
        allGames,
        index,
        correctAnswers,
        gameData,
        cardsLetters,
        woodenBackground
      ];
}
