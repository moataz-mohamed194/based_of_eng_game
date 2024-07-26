part of 'drag_add_cubit.dart';

@immutable
class DragAddInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final GameLettersGameFinalModel? subQuestion;
  final GameLettersGameFinalModel? mainQuestion;
  final GameLettersGameFinalModel? correctAnswer;
  final num? mainNumber;
  final int correctAnswers;
  final bool? isCorrect;
  final int index;
  final ToolsOfMath tools;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;

  DragAddInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      this.correctAnswer,
      required this.tools,
      this.isCorrect,
      this.subQuestion,
      this.mainQuestion,
      required this.index,
      this.gameChoices,
      this.mainNumber});
  DragAddInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    num? mainNumber,
    int? correctAnswers,
    bool? isCorrect,
    GameLettersGameFinalModel? correctAnswer,
    GameLettersGameFinalModel? subQuestion,
    GameLettersGameFinalModel? mainQuestion,
    int? index,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return DragAddInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        subQuestion: subQuestion ?? this.subQuestion,
        mainQuestion: mainQuestion ?? this.mainQuestion,
        mainNumber: mainNumber ?? this.mainNumber,
        tools: tools,
        gameChoices: gameChoices ?? this.gameChoices,
        allGameData: allGameData ?? this.allGameData,
        isCorrect: isCorrect ?? this.isCorrect,
        correctAnswers: correctAnswers ?? this.correctAnswers);
  }

  @override
  List<Object?> get props => [
        gameChoices,
        mainNumber,
        index,
        tools,
        gameData,
        correctAnswer,
        allGameData,
        isCorrect,
        correctAnswers
      ];
}
