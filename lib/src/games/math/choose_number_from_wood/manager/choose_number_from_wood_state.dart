part of 'choose_number_from_wood_cubit.dart';

@immutable
final class ChooseNumberFromWoodInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final int index;
  final int correctAnswers;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;
  final bool? isCorrect;
  final ToolsOfMath tools;
  final List<GameLettersGameFinalModel>? gameLetters;

  ChooseNumberFromWoodInitial(
      {this.gameChoices,
      required this.index,
      required this.gameData,
      required this.tools,
      required this.allGameData,
      this.isCorrect,
      this.correctAnswers = 0,
      this.gameLetters});

  ChooseNumberFromWoodInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    List<GameLettersGameFinalModel>? gameLetters,
    int? index,
    int? correctAnswers,
    bool? isCorrect,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return ChooseNumberFromWoodInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        tools: tools,
        gameLetters: gameLetters ?? this.gameLetters,
        gameChoices: gameChoices ?? this.gameChoices,
        allGameData: allGameData ?? this.allGameData,
        isCorrect: isCorrect ?? this.isCorrect);
  }

  @override
  List<Object?> get props => [
        gameChoices,
        gameLetters,
        correctAnswers,
        tools,
        index,
        gameData,
        isCorrect,
        allGameData
      ];
}
