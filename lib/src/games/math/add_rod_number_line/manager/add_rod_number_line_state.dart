part of 'add_rod_number_line_cubit.dart';

@immutable
final class AddRodNumberLineInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final int index;
  final int correctAnswers;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;
  final bool? isCorrect;
  GameChoicesGameFinalModel? correctAnswer;
  final ToolsOfMath tools;
  final List<GameLettersGameFinalModel>? finalGameLetters;

  AddRodNumberLineInitial(
      {this.gameChoices,
      required this.index,
      required this.gameData,
      required this.tools,
      required this.allGameData,
      this.isCorrect,
      this.correctAnswer,
      this.correctAnswers = 0,
      this.finalGameLetters});

  AddRodNumberLineInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    List<GameLettersGameFinalModel>? finalGameLetters,
    int? index,
    int? correctAnswers,
    bool? isCorrect,
    GameChoicesGameFinalModel? correctAnswer,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return AddRodNumberLineInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        tools: tools,
        finalGameLetters: finalGameLetters ?? this.finalGameLetters,
        gameChoices: gameChoices ?? this.gameChoices,
        allGameData: allGameData ?? this.allGameData,
        isCorrect: isCorrect ?? this.isCorrect);
  }

  @override
  List<Object?> get props => [
        gameChoices,
        finalGameLetters,
        correctAnswers,
        tools,
        index,
        correctAnswer,
        gameData,
        isCorrect,
        allGameData
      ];
}
