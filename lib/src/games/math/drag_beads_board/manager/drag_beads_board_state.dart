part of 'drag_beads_board_cubit.dart';

@immutable
class DragBeadsBoardInitial extends Equatable {
  final List<GameLettersGameFinalModel>? gameLetters;
  final List<GameImagesGameFinalModel>? gameImages;
  final num? mainNumber;
  final List<GameLettersGameFinalModel> correctAnswers;
  // final int index;
  final ToolsOfMath tools;
  final GameFinalModel gameData;
  // final List<GameFinalModel> allGameData;

  DragBeadsBoardInitial(
      {required this.gameData,
      required this.correctAnswers,
      required this.tools,
      required this.gameImages,
      // this.secondGameChoices,
      // required this.index,
      this.gameLetters,
      this.mainNumber});
  DragBeadsBoardInitial copyWith({
    List<GameLettersGameFinalModel>? gameLetters,
    List<GameImagesGameFinalModel>? gameImages,
    num? mainNumber,
    List<GameLettersGameFinalModel>? correctAnswers,
    // int? index,
    GameFinalModel? gameData,
    // List<GameFinalModel>? allGameData,
  }) {
    return DragBeadsBoardInitial(
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
