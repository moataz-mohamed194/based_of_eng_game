part of 'sorting_blocks_cubit.dart';

@immutable
class SortingBeadsInitial extends Equatable {
  final List<GameLettersGameFinalModel>? gameLetters;
  final List<GameImagesGameFinalModel>? gameImages;
  final num? mainNumber;
  final List<GameImagesGameFinalModel> correctAnswers;
  // final int index;
  final ToolsOfMath tools;
  final GameFinalModel gameData;
  // final List<GameFinalModel> allGameData;

  SortingBeadsInitial(
      {required this.gameData,
      required this.correctAnswers,
      required this.tools,
      required this.gameImages,
      // this.secondGameChoices,
      // required this.index,
      this.gameLetters,
      this.mainNumber});
  SortingBeadsInitial copyWith({
    List<GameLettersGameFinalModel>? gameLetters,
    List<GameImagesGameFinalModel>? gameImages,
    num? mainNumber,
    List<GameImagesGameFinalModel>? correctAnswers,
    // int? index,
    GameFinalModel? gameData,
    // List<GameFinalModel>? allGameData,
  }) {
    return SortingBeadsInitial(
        gameData: gameData ?? this.gameData,
        gameImages: gameImages ?? this.gameImages,
        // index: index ?? this.index,
        mainNumber: mainNumber ?? this.mainNumber,
        tools: tools,
        gameLetters: gameLetters ?? this.gameLetters,
        // allGameData: allGameData ?? this.allGameData,
        correctAnswers: correctAnswers ?? this.correctAnswers);
  }

  @override
  List<Object?> get props => [
        gameLetters,
        mainNumber,
        gameImages,
        // index,
        tools,
        gameData,
        // allGameData,
        correctAnswers
      ];
}
