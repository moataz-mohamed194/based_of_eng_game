part of 'click_the_picture_with_word_cubit.dart';

class ClickThePictureWithWordInitial extends Equatable {
  final GameFinalModel gameData;
  // final List<GameImagesGameFinalModel>? gameDataPartOne;
  final List<GameImagesGameFinalModel>? gameImages;
  final List<String> backGround;
  final List<int> correctIndexes;
  final GameImagesGameFinalModel? chooseWord;
  final bool isArabic;
  // final int? correctAnswer;
  const ClickThePictureWithWordInitial(
      {required this.gameData,
      this.gameImages,
      required this.backGround,
      required this.correctIndexes,
      this.chooseWord,
      this.isArabic = false});

  ClickThePictureWithWordInitial copyWith(
      {GameFinalModel? gameData,
      List<String>? backGround,
      List<GameImagesGameFinalModel>? gameImages,
      List<int>? correctIndexes,
      GameImagesGameFinalModel? chooseWord,
      bool? isArabic}) {
    return ClickThePictureWithWordInitial(
      gameData: gameData ?? this.gameData,
      backGround: backGround ?? this.backGround,
      gameImages: gameImages ?? this.gameImages,
      chooseWord: chooseWord ?? this.chooseWord,
      correctIndexes: correctIndexes ?? this.correctIndexes,
      isArabic: isArabic ?? this.isArabic,
    );
  }

  ClickThePictureWithWordInitial clearChooseWord() {
    return ClickThePictureWithWordInitial(
      gameData: gameData,
      gameImages: gameImages,
      backGround: backGround,
      chooseWord: null,
      correctIndexes: correctIndexes,
      isArabic: isArabic,
    );
  }

  @override
  List<Object?> get props => [
        chooseWord,
        correctIndexes,
        gameData,
        backGround,
        gameImages,
        isArabic,
        // gameDataPartTwo,
        // gameDataPartOne
      ];
}
