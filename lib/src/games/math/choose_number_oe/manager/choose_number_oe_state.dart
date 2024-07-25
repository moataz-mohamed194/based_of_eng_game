part of 'choose_number_oe_cubit.dart';

@immutable
class ChooseNumberOEInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final num? mainNumber;
  final int correctAnswers;
  final num? currentAnswer;
  final int index;
  final BasicOfGameData basicData;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;
  final bool? isCorrect;

  ChooseNumberOEInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      required this.basicData,
      this.currentAnswer,
      this.isCorrect,
      required this.index,
      this.gameChoices,
      this.mainNumber});
  ChooseNumberOEInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    num? mainNumber,
    int? correctAnswers,
    num? currentAnswer,
    int? index,
    bool? isCorrect,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return ChooseNumberOEInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        mainNumber: mainNumber ?? this.mainNumber,
        basicData: basicData,
        gameChoices: gameChoices ?? this.gameChoices,
        allGameData: allGameData ?? this.allGameData,
        isCorrect: isCorrect ?? this.isCorrect,
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
        isCorrect,
        allGameData,
        currentAnswer,
        correctAnswers
      ];
}
