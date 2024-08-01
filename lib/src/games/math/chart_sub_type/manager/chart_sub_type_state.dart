part of 'chart_sub_type_cubit.dart';

@immutable
final class ChartSubTypeInitial extends Equatable {
  final List<GameChoicesGameFinalModel>? gameChoices;
  final int index;
  final int correctAnswers;
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;
  final bool? isCorrect;
  final String? correctAnswer;
  final List<GameLettersGameFinalModel>? finalGameLetters;

  ChartSubTypeInitial(
      {this.gameChoices,
      required this.index,
      required this.gameData,
      required this.allGameData,
      this.isCorrect,
      this.correctAnswer,
      this.correctAnswers = 0,
      this.finalGameLetters});

  ChartSubTypeInitial copyWith({
    List<GameChoicesGameFinalModel>? gameChoices,
    List<GameLettersGameFinalModel>? finalGameLetters,
    int? index,
    int? correctAnswers,
    bool? isCorrect,
    String? correctAnswer,
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
  }) {
    return ChartSubTypeInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        correctAnswer: correctAnswer ?? this.correctAnswer,
        correctAnswers: correctAnswers ?? this.correctAnswers,
        finalGameLetters: finalGameLetters ?? this.finalGameLetters,
        gameChoices: gameChoices ?? this.gameChoices,
        allGameData: allGameData ?? this.allGameData,
        isCorrect: isCorrect ?? this.isCorrect);
  }

  @override
  List<Object?> get props => [
        gameChoices,
        finalGameLetters,
        correctAnswers,
        index,
        correctAnswer,
        gameData,
        isCorrect,
        allGameData
      ];
}
