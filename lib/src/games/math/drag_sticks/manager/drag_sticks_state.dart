part of 'drag_sticks_cubit.dart';

@immutable
class DragSticksInitial extends Equatable {
  final List<GameLettersGameFinalModel>? gameLetters;
  final List<GameLettersGameFinalModel>? gameAnswers;
  final List<GameImagesGameFinalModel>? gameImages;

  final GameFinalModel gameData;
  final List<GameFinalModel> allGamesData;
  final int countOfQuestions;
  final int countOfAnswers;
  final int index;

  DragSticksInitial(
      {required this.index,
      required this.countOfQuestions,
      required this.gameData,
      required this.countOfAnswers,
      this.gameLetters,
      this.gameAnswers,
      this.gameImages,
      required this.allGamesData});
  DragSticksInitial copyWith(
      {List<GameLettersGameFinalModel>? gameLetters,
      List<GameLettersGameFinalModel>? gameAnswers,
      List<GameImagesGameFinalModel>? gameImages,
      GameFinalModel? gameData,
      List<GameFinalModel>? allGamesData,
      int? countOfQuestions,
      int? countOfAnswers,
      int? index}) {
    return DragSticksInitial(
        gameLetters: gameLetters ?? this.gameLetters,
        gameAnswers: gameAnswers ?? this.gameAnswers,
        gameImages: gameImages ?? this.gameImages,
        gameData: gameData ?? this.gameData,
        allGamesData: allGamesData ?? this.allGamesData,
        countOfQuestions: countOfQuestions ?? this.countOfQuestions,
        countOfAnswers: countOfAnswers ?? this.countOfAnswers,
        index: index ?? this.index);
  }

  @override
  List<Object?> get props => [
        gameImages,
        gameAnswers,
        gameLetters,
        index,
        countOfAnswers,
        countOfQuestions,
        allGamesData,
        gameData
      ];
}
