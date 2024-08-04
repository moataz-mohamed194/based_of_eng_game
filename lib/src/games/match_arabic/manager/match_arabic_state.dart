part of 'match_arabic_cubit.dart';

@immutable
class MatchArabicInitial extends Equatable {
  // final List<GameFinalModel> listGameData;
  final GameFinalModel gameData;
  final int countCorrectAnswers;
  final int countQuestions;
  final List<GameLettersGameFinalModel> answers;
  final List<int> idsOfCorrectAnswers;
  // final Offset? end;
  final List<GameImagesGameFinalModel> imageAnswers;
  // final int index;
  final List<GlobalKey> widgetKey;
  final List<List<Offset?>> positions;

  MatchArabicInitial(
      {required this.gameData,
      this.countCorrectAnswers = 0,
      required this.countQuestions,
      required this.idsOfCorrectAnswers,
      required this.answers,
      required this.widgetKey,
      required this.positions,
      // this.start,
      // this.end,
      required this.imageAnswers});

  MatchArabicInitial copyWith(
      {GameFinalModel? gameData,
      List<String>? correctAnswers,
      List<List<Offset?>>? positions,
      int? countCorrectAnswers,
      List<int>? idsOfCorrectAnswers,
      int? countQuestions,
      List<GlobalKey>? widgetKey,
      List<GameLettersGameFinalModel>? answers,
      List<GameImagesGameFinalModel>? imageAnswers}) {
    return MatchArabicInitial(
        gameData: gameData ?? this.gameData,
        positions: positions ?? this.positions,
        idsOfCorrectAnswers: idsOfCorrectAnswers ?? this.idsOfCorrectAnswers,
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
        idsOfCorrectAnswers,
        widgetKey,
        answers,
        positions,
        countCorrectAnswers
      ];
}
