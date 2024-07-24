part of 'choose_sticks_cubit.dart';

@immutable
class ChooseSticksInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final num? mainNumber;
  final int correctAnswers;
  final bool? isCorrect;
  final int index;
  final BasicOfGameData basicData;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;

  ChooseSticksInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      required this.basicData,
      this.isCorrect,
      required this.index,
      this.gameChoices,
      this.mainNumber});
  ChooseSticksInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    num? mainNumber,
    int? correctAnswers,
    bool? isCorrect,
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
        isCorrect: isCorrect ?? this.isCorrect,
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
        isCorrect,
        correctAnswers
      ];
}
