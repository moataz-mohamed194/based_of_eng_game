part of 'drag_pic_to_word_cubit.dart';

@immutable
class DragPicToWordInitial extends Equatable {
  final GameFinalModel gameData;
  final List<GameImagesGameFinalModel>? gameImages;
  final List<GameImagesGameFinalModel>? gamesLetters;
  final List<int> correctedAnswers;
  final bool isArabic;

  const DragPicToWordInitial({
    required this.gameData,
    required this.correctedAnswers,
    this.gamesLetters,
    this.gameImages,
    this.isArabic = false,
  });

  DragPicToWordInitial copyWith({
    GameFinalModel? gameData,
    List<GameImagesGameFinalModel>? gamesLetters,
    List<int>? correctedAnswers,
    List<GameImagesGameFinalModel>? gameImages,
    bool? isArabic,
  }) {
    return DragPicToWordInitial(
      gameData: gameData ?? this.gameData,
      gameImages: gameImages ?? this.gameImages,
      gamesLetters: gamesLetters ?? this.gamesLetters,
      correctedAnswers: correctedAnswers ?? this.correctedAnswers,
      isArabic: isArabic ?? this.isArabic,
    );
  }

  @override
  List<Object?> get props =>
      [gameData, correctedAnswers, gamesLetters, gameImages, isArabic];
}
