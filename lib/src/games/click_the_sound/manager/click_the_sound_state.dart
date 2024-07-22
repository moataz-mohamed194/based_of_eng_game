part of 'click_the_sound_cubit.dart';

class ClickTheSoundInitial extends Equatable {
  final GameFinalModel gameData;
  List<GameLettersGameFinalModel>? letters;
  List<int>? correctIndexes = [];
  bool isArabic;

  ClickTheSoundInitial({
    required this.gameData,
    this.letters,
    this.correctIndexes,
    this.isArabic = false,
  });

  ClickTheSoundInitial copyWith({
    GameFinalModel? gameData,
    List<GameLettersGameFinalModel>? letters,
    int? correctAnswers,
    List<int>? correctIndexes,
    bool? isArabic,
    // bool? isInteracting,
  }) {
    return ClickTheSoundInitial(
      gameData: gameData ?? this.gameData,
      letters: letters ?? this.letters,
      // correctAnswers: correctAnswers ?? this.correctAnswers,
      correctIndexes: correctIndexes ?? this.correctIndexes,
      isArabic: isArabic ?? this.isArabic,
      // isInteracting: isInteracting ?? this.isInteracting,
    );
  }

  @override
  List<Object?> get props => [
        gameData,
        letters,
        correctIndexes,
        isArabic,
        // isInteracting,
      ];
}
