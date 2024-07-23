part of 'drag_out_cubit.dart';

class DragOutInitial extends Equatable {
  final GameFinalModel gameData;
  final List<GameFinalModel> allGameData;
  final int? correctAnswer;
  final List<GameImagesGameFinalModel>? gameImages;
  final int index;
  final bool isArabic;

  const DragOutInitial({
    required this.gameData,
    this.correctAnswer,
    this.gameImages,
    this.index = 0,
    required this.allGameData,
    this.isArabic = false,
  });
  DragOutInitial copyWith({
    GameFinalModel? gameData,
    List<GameFinalModel>? allGameData,
    List<GameImagesGameFinalModel>? gameImages,
    int? correctAnswer,
    int? index,
    bool? isArabic,
  }) {
    return DragOutInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        gameImages: gameImages ?? this.gameImages,
        isArabic: isArabic ?? this.isArabic,
        allGameData: allGameData ?? this.allGameData,
        correctAnswer: correctAnswer ?? this.correctAnswer);
  }

  @override
  List<Object?> get props =>
      [gameData, gameImages, correctAnswer, index, allGameData, isArabic];
}
