part of 'choose_sub_cubit.dart';

@immutable
class ChooseSubInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final GameLettersGameFinalModel? subQuestion;
  final GameLettersGameFinalModel? mainQuestion;

  final int correctAnswers;
  final bool? isCorrect;
  final int index;
  final ToolsOfMath tools;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;

  ChooseSubInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      required this.tools,
      this.isCorrect,
      this.subQuestion,
      this.mainQuestion,
      required this.index,
      this.gameChoices});
  ChooseSubInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    num? mainNumber,
    int? correctAnswers,
    bool? isCorrect,
    GameLettersGameFinalModel? subQuestion,
    GameLettersGameFinalModel? mainQuestion,
    int? index,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return ChooseSubInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        subQuestion: subQuestion ?? this.subQuestion,
        mainQuestion: mainQuestion ?? this.mainQuestion,
        tools: tools,
        gameChoices: gameChoices ?? this.gameChoices,
        allGameData: allGameData ?? this.allGameData,
        isCorrect: isCorrect ?? this.isCorrect,
        correctAnswers: correctAnswers ?? this.correctAnswers);
  }

  @override
  List<Object?> get props => [
        gameChoices,
        index,
        tools,
        gameData,
        allGameData,
        isCorrect,
        correctAnswers
      ];
}
