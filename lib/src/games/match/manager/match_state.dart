part of 'match_cubit.dart';

@immutable
class MatchInitial extends Equatable {
  // final List<GameFinalModel> listGameData;
  final GameFinalModel gameData;
  final int countCorrectAnswers;
  final int countQuestions;
  final List<GameLettersGameFinalModel> answers;
  final List<int> idsOfCorrectAnswers;
  final List<int> idsOfImagesCorrectAnswers;
  final List<GameImagesGameFinalModel> imageAnswers;
  // final int index;
  final List<GlobalKey> widgetKey;
  final List<List<Offset?>> positions;

  MatchInitial(
      {required this.gameData,
      this.countCorrectAnswers = 0,
      required this.countQuestions,
      required this.idsOfCorrectAnswers,
      required this.answers,
      required this.idsOfImagesCorrectAnswers,
      required this.widgetKey,
      required this.positions,
      // this.start,
      // this.end,
      required this.imageAnswers});

  MatchInitial copyWith(
      {List<String>? correctAnswers,
      List<List<Offset?>>? positions,
      int? countCorrectAnswers,
      int? countQuestions,
      List<GlobalKey>? widgetKey,
      List<int>? idsOfCorrectAnswers,
      List<int>? idsOfImagesCorrectAnswers,
      List<GameLettersGameFinalModel>? answers,
      List<GameImagesGameFinalModel>? imageAnswers}) {
    return MatchInitial(
        gameData: gameData,
        positions: positions ?? this.positions,
        idsOfCorrectAnswers: idsOfCorrectAnswers ?? this.idsOfCorrectAnswers,
        countQuestions: countQuestions ?? this.countQuestions,
        countCorrectAnswers: countCorrectAnswers ?? this.countCorrectAnswers,
        idsOfImagesCorrectAnswers: idsOfImagesCorrectAnswers ?? this.idsOfImagesCorrectAnswers,
        answers: answers ?? this.answers,
        widgetKey: widgetKey ?? this.widgetKey,
        imageAnswers: imageAnswers ?? this.imageAnswers);
  }

  @override
  List<Object?> get props => [
        gameData,
        imageAnswers,
        widgetKey,
        idsOfCorrectAnswers,
        answers,
        positions,idsOfImagesCorrectAnswers,
        countCorrectAnswers
      ];
}
