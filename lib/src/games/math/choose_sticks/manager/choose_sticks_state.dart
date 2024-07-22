part of 'choose_sticks_cubit.dart';

@immutable
class ChooseSticksInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final num? mainNumber;
  final int correctAnswers;
  final num? currentAnswer;
  final int index;
  final BasicOfGameData basicData;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;

  ChooseSticksInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      required this.basicData,
      this.currentAnswer,
      required this.index,
      this.gameChoices,
      this.mainNumber});
  ChooseSticksInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    num? mainNumber,
    int? correctAnswers,
    num? currentAnswer,
    int? index,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return ChooseSticksInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        mainNumber: mainNumber ?? this.mainNumber,
        basicData: basicData,
        gameChoices: gameChoices ?? this.gameChoices,
        allGameData: allGameData ?? this.allGameData,
        currentAnswer: currentAnswer ?? this.currentAnswer,
        correctAnswers: correctAnswers ?? this.correctAnswers);
  }

  @override
  List<Object?> get props => [
        gameChoices,
        mainNumber,
        index,
        basicData,
        gameData,
        allGameData,
        currentAnswer,
        correctAnswers
      ];
}
