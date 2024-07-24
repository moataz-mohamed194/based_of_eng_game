part of 'choose_the_correct_letter_or_image_cubit.dart';

class ChooseTheCorrectLetterOrImageState extends Equatable {
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;
  final int? correctAnswer;
  final List<GameImagesGameFinalModel>? gameImages;
  final int index;
  final bool isLetter;

  const ChooseTheCorrectLetterOrImageState({
    required this.gameData,
    this.correctAnswer,
    this.gameImages,
    this.index = 0,
    required this.allGameData,
    this.isLetter = false,
  });
  ChooseTheCorrectLetterOrImageState copyWith({
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
    List<GameImagesGameFinalModel>? gameImages,
    int? correctAnswer,
    int? index,
    bool? isArabic,
  }) {
    return ChooseTheCorrectLetterOrImageState(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        gameImages: gameImages ?? this.gameImages,
        isLetter: isArabic ?? this.isLetter,
        allGameData: allGameData ?? this.allGameData,
        correctAnswer: correctAnswer ?? this.correctAnswer);
  }

  @override
  List<Object?> get props =>
      [gameData, gameImages, correctAnswer, index, allGameData, isLetter];
}
