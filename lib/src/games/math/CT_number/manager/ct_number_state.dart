part of 'ct_number_cubit.dart';

@immutable
class CtNumberInitial extends Equatable {
  final GameLettersGameFinalModel? mainLetter;
  final GameLettersGameFinalModel? subLetter;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;
  final int index;
  final SymbolsMath tools;
  final bool showLineOfNumbers;
  final String? correctAnswer;
  final String? currentAnswer;
  final int? countOfCorrectAnswers;
  final bool? isCorrect;

  CtNumberInitial(
      {this.mainLetter,
      required this.gameData,
      required this.allGameData,
      required this.index,
      required this.showLineOfNumbers,
      required this.tools,
      this.correctAnswer,
      this.subLetter,
      this.currentAnswer,
      this.countOfCorrectAnswers,
      this.isCorrect});

  CtNumberInitial copyWith(
      {GameLettersGameFinalModel? mainLetter,
      GameLettersGameFinalModel? subLetter,
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
        showLineOfNumbers: showLineOfNumbers,
        mainLetter: mainLetter ?? this.mainLetter,
        subLetter: subLetter ?? this.subLetter,
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
        subLetter: subLetter,
        mainLetter: mainLetter,
        showLineOfNumbers: showLineOfNumbers,
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
        mainLetter,
        subLetter,
        tools,
        allGameData,
        isCorrect,
        showLineOfNumbers,
        correctAnswer,
        countOfCorrectAnswers
      ];
}
