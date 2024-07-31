part of 'ct_number_cubit.dart';

@immutable
class CtNumberInitial extends Equatable {
  final List<GameLettersGameFinalModel>? gameLetters;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;
  final int index;
  final SymbolsMath tools;
  final String? correctAnswer;
  final String? currentAnswer;
  final int? countOfCorrectAnswers;
  final bool? isCorrect;

  CtNumberInitial(
      {this.gameLetters,
      required this.gameData,
      required this.allGameData,
      required this.index,
      required this.tools,
      this.correctAnswer,
      this.currentAnswer,
      this.countOfCorrectAnswers,
      this.isCorrect});

  CtNumberInitial copyWith(
      {List<GameLettersGameFinalModel>? gameLetters,
      GameFinalModel? gameData,
      List<GameFinalModel>? allGameData,
      int? index,
      int? countOfCorrectAnswers,
      SymbolsMath? tools,
      String? correctAnswer,
      String? currentAnswer,
      bool? isCorrect}) {
    return CtNumberInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        gameLetters: gameLetters ?? this.gameLetters,
        currentAnswer: currentAnswer ?? this.currentAnswer,
        tools: tools ?? this.tools,
        allGameData: allGameData ?? this.allGameData,
        countOfCorrectAnswers:
            countOfCorrectAnswers ?? this.countOfCorrectAnswers,
        isCorrect: isCorrect ?? this.isCorrect,
        correctAnswer: correctAnswer ?? this.correctAnswer);
  }

  CtNumberInitial clearCurrentAnswer() {
    return CtNumberInitial(
        gameData: gameData,
        index: index,
        gameLetters: gameLetters,
        currentAnswer: null,
        tools: tools,
        allGameData: allGameData,
        countOfCorrectAnswers: countOfCorrectAnswers,
        isCorrect: isCorrect,
        correctAnswer: correctAnswer);
  }

  @override
  List<Object?> get props => [
        gameData,
        index,
        currentAnswer,
        gameLetters,
        tools,
        allGameData,
        isCorrect,
        correctAnswer,
        countOfCorrectAnswers
      ];
}
