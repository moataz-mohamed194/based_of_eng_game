part of 'choose_oe_cubit.dart';

@immutable
class ChooseOeInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final int correctAnswers;
  final bool? isCorrect;
  final int index;
  final BasicOfGameData basicData;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;

  ChooseOeInitial(
      {required this.allGameData,
      required this.gameData,
      required this.correctAnswers,
      required this.basicData,
      this.isCorrect,
      required this.index,
      this.gameChoices});
  ChooseOeInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    int? correctAnswers,
    bool? isCorrect,
    int? index,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return ChooseOeInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        basicData: basicData,
        gameChoices: gameChoices ?? this.gameChoices,
        allGameData: allGameData ?? this.allGameData,
        isCorrect: isCorrect ?? this.isCorrect,
        correctAnswers: correctAnswers ?? this.correctAnswers);
  }

  @override
  List<Object?> get props => [
        gameChoices,
        index,
        basicData,
        gameData,
        allGameData,
        isCorrect,
        correctAnswers
      ];
}
