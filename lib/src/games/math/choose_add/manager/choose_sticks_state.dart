part of 'choose_sticks_cubit.dart';

@immutable
class ChooseAddInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final GameLettersGameFinalModel? subQuestion;
  final GameLettersGameFinalModel? mainQuestion;
  final num? mainNumber;
  final int correctAnswers;
  final bool? isCorrect;
  final int index;
  final BasicOfGameData basicData;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;

  ChooseAddInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      required this.basicData,
      this.isCorrect,
      this.subQuestion,
      this.mainQuestion,
      required this.index,
      this.gameChoices,
      this.mainNumber});
  ChooseAddInitial copyWith({
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
    return ChooseAddInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        subQuestion: subQuestion ?? this.subQuestion,
        mainQuestion: mainQuestion ?? this.mainQuestion,
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
