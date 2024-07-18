part of 'match_cubit.dart';

@immutable
class MatchInitial extends Equatable {
  // final List<GameFinalModel> listGameData;
  final GameFinalModel gameData;
  final int countCorrectAnswers;
  final int countQuestions;
  final List<GameLettersGameFinalModel> answers;
  // final Offset? start;
  // final Offset? end;
  final List<GameImagesGameFinalModel> imageAnswers;
  // final int index;
  final List<GlobalKey> widgetKey;
  final List<List<Offset?>> positions;

  MatchInitial(
      {required this.gameData,
      this.countCorrectAnswers = 0,
      required this.countQuestions,
      required this.answers,
      required this.widgetKey,
      required this.positions,
      // this.start,
      // this.end,
      required this.imageAnswers});

  MatchInitial copyWith(
      {GameFinalModel? gameData,
      List<String>? correctAnswers,
      List<List<Offset?>>? positions,
      int? countCorrectAnswers,
      int? countQuestions,
      List<GlobalKey>? widgetKey,
      List<GameLettersGameFinalModel>? answers,
      List<GameImagesGameFinalModel>? imageAnswers}) {
    return MatchInitial(
        gameData: gameData ?? this.gameData,
        positions: positions ?? this.positions,
        countQuestions: countQuestions ?? this.countQuestions,
        countCorrectAnswers: countCorrectAnswers ?? this.countCorrectAnswers,
        answers: answers ?? this.answers,
        widgetKey: widgetKey ?? this.widgetKey,
        imageAnswers: imageAnswers ?? this.imageAnswers);
  }

  @override
  List<Object?> get props => [
        gameData,
        imageAnswers,
        widgetKey,
        answers,
        positions,
        countCorrectAnswers
      ];
}
