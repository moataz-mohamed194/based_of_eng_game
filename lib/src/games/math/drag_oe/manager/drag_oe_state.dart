part of 'drag_oe_cubit.dart';

@immutable
class DragOeInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final List<GameChoicesGameFinalModel> correctAnswers;
  final int index;
  final BasicOfGameData basicData;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;

  DragOeInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      required this.basicData,
      required this.index,
      this.gameChoices});
  DragOeInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    List<GameChoicesGameFinalModel>? correctAnswers,
    num? currentAnswer,
    int? index,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return DragOeInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        basicData: basicData,
        gameChoices: gameChoices ?? this.gameChoices,
        allGameData: allGameData ?? this.allGameData,
        correctAnswers: correctAnswers ?? this.correctAnswers);
  }

  @override
  List<Object?> get props =>
      [gameChoices, index, basicData, gameData, allGameData, correctAnswers];
}
