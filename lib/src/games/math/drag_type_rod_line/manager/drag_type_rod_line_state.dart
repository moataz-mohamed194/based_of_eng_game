part of 'drag_type_rod_line_cubit.dart';

@immutable
final class DragTypeRodLineInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final int index;
  final int correctAnswers;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;
  final bool? isCorrect;
  final bool? isCorrectDrag;
  GameChoicesGameFinalModel? correctAnswer;
  final ToolsOfMath tools;
  final List<GameLettersGameFinalModel>? finalGameLetters;

  DragTypeRodLineInitial(
      {this.gameChoices,
      required this.index,
      required this.gameData,
      required this.tools,
      required this.allGameData,
      this.isCorrect,
      this.isCorrectDrag,
      this.correctAnswer,
      this.correctAnswers = 0,
      this.finalGameLetters});

  DragTypeRodLineInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    List<GameLettersGameFinalModel>? finalGameLetters,
    int? index,
    int? correctAnswers,
    bool? isCorrect,
    bool? isCorrectDrag,
    GameChoicesGameFinalModel? correctAnswer,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return DragTypeRodLineInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        isCorrectDrag: isCorrectDrag ?? this.isCorrectDrag,
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
        isCorrectDrag,
        tools,
        index,
        correctAnswer,
        gameData,
        isCorrect,
        allGameData
      ];
}
