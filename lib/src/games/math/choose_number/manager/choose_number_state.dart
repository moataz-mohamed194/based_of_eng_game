part of 'choose_number_cubit.dart';

@immutable
class ChooseNumberInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final num? mainNumber;
  final int correctAnswers;
  final num? currentAnswer;
  final int index;
  final bool? isCorrect;
  final BasicOfGameData basicData;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;

  ChooseNumberInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      required this.basicData,
      this.currentAnswer,
      this.isCorrect,
      required this.index,
      this.gameChoices,
      this.mainNumber});
  ChooseNumberInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    num? mainNumber,
    int? correctAnswers,
    num? currentAnswer,
    int? index,
    bool? isCorrect,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return ChooseNumberInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        mainNumber: mainNumber ?? this.mainNumber,
        isCorrect: isCorrect ?? this.isCorrect,
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
