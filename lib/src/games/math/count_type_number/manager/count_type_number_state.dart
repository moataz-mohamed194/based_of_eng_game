part of 'count_type_number_cubit.dart';

@immutable
final class CountTypeNumberInitial extends Equatable {
  final List<GameLettersGameFinalModel>? gameLetters;
  final int index;
  final int correctAnswers;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;
  final bool? isCorrect;
  final ToolsOfMath tools;
  final String? correctAns;

  CountTypeNumberInitial(
      {this.gameLetters,
      required this.index,
      required this.gameData,
      required this.tools,
      required this.allGameData,
      this.isCorrect,
      this.correctAnswers = 0,
      this.correctAns});

  CountTypeNumberInitial copyWith({
    List<GameLettersGameFinalModel>? gameLetters,
    String? correctAns,
    int? index,
    int? correctAnswers,
    bool? isCorrect,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return CountTypeNumberInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        tools: tools,
        correctAns: correctAns ?? this.correctAns,
        gameLetters: gameLetters ?? this.gameLetters,
        allGameData: allGameData ?? this.allGameData,
        isCorrect: isCorrect ?? this.isCorrect);
  }

  @override
  List<Object?> get props => [
        gameLetters,
        correctAns,
        correctAnswers,
        tools,
        index,
        gameData,
        isCorrect,
        allGameData
      ];
}
