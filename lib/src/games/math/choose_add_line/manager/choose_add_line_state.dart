part of 'choose_add_line_cubit.dart';

@immutable
class ChooseAddLineInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final GameLettersGameFinalModel? subQuestion;
  final GameLettersGameFinalModel? mainQuestion;
  final num? mainNumber;
  final int correctAnswers;
  final bool? isCorrect;
  final int index;
  final ToolsOfMath tools;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;

  ChooseAddLineInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      required this.tools,
      this.isCorrect,
      this.subQuestion,
      this.mainQuestion,
      required this.index,
      this.gameChoices,
      this.mainNumber});
  ChooseAddLineInitial copyWith({
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
    return ChooseAddLineInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
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
        allGameData,
        isCorrect,
        correctAnswers
      ];
}
