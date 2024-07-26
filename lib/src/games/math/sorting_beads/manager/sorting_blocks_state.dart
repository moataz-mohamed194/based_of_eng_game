part of 'sorting_blocks_cubit.dart';

@immutable
class SortingBlocksInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final List<GameChoicesGameFinalModel>? secondGameChoices;
  final num? mainNumber;
  final List<int> correctAnswers;
  // final int index;
  final ToolsOfMath tools;
  final GameFinalModel gameData;
  // final List<GameFinalModel> allGameData;

  SortingBlocksInitial(
      {required this.gameData,
      required this.correctAnswers,
      required this.tools,
      this.secondGameChoices,
      // required this.index,
      this.gameChoices,
      this.mainNumber});
  SortingBlocksInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    List<GameChoicesGameFinalModel>? secondGameChoices,
    num? mainNumber,
    List<int>? correctAnswers,
    // int? index,
    GameFinalModel? gameData,
    // List<GameFinalModel>? allGameData,
  }) {
    return SortingBlocksInitial(
        gameData: gameData ?? this.gameData,
        secondGameChoices: secondGameChoices ?? this.secondGameChoices,
        // index: index ?? this.index,
        mainNumber: mainNumber ?? this.mainNumber,
        tools: tools,
        gameChoices: gameChoices ?? this.gameChoices,
        // allGameData: allGameData ?? this.allGameData,
        correctAnswers: correctAnswers ?? this.correctAnswers);
  }

  @override
  List<Object?> get props => [
        gameChoices,
        mainNumber,
        secondGameChoices,
        // index,
        tools,
        gameData,
        // allGameData,
        correctAnswers
      ];
}
