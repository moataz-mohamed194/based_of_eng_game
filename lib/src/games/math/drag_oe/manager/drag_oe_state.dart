part of 'drag_oe_cubit.dart';

@immutable
class DragOeInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final List<GameChoicesGameFinalModel> correctAnswers;
  final int index;
  final int countOfCorrect;
  final int countOfQuestions;
  final ToolsOfMath tools;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;

  DragOeInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      required this.countOfCorrect,
      required this.tools,
      required this.countOfQuestions,
      required this.index,
      this.gameChoices});
  DragOeInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    List<GameChoicesGameFinalModel>? correctAnswers,
    num? currentAnswer,
    int? index,
    int? countOfCorrect,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return DragOeInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        tools: tools,
        countOfCorrect: countOfCorrect ?? this.countOfCorrect,
        countOfQuestions: countOfQuestions,
        gameChoices: gameChoices ?? this.gameChoices,
        allGameData: allGameData ?? this.allGameData,
        correctAnswers: correctAnswers ?? this.correctAnswers);
  }

  @override
  List<Object?> get props => [
        gameChoices,
        countOfCorrect,
        index,
        tools,
        countOfQuestions,
        gameData,
        allGameData,
        correctAnswers
      ];
}
