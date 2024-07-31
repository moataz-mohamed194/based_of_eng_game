part of 'click_the_sound_cubit.dart';

class ClickTheSoundInitial extends Equatable {
  final GameFinalModel gameData;
  List<GameLettersGameFinalModel>? letters;
  List<int>? correctIndexes = [];
  List<String> ? correctStrings =  [] ;
  bool isArabic;
  bool isFish ;

  ClickTheSoundInitial({
    required this.gameData,
    this.letters,
    this.correctIndexes,
    this.isArabic = false,
    this.isFish = false, 
    this.correctStrings ,
  });

  ClickTheSoundInitial copyWith({
    GameFinalModel? gameData,
    List<GameLettersGameFinalModel>? letters,
    int? correctAnswers,
    List<int>? correctIndexes,
    List<String> ? correctStrings,
    bool? isArabic,
    bool? isFish ,
    // bool? isInteracting,
  }) {
    return ClickTheSoundInitial(
      gameData: gameData ?? this.gameData,
      letters: letters ?? this.letters,
      // correctAnswers: correctAnswers ?? this.correctAnswers,
      correctIndexes: correctIndexes ?? this.correctIndexes,
      isArabic: isArabic ?? this.isArabic,
      isFish:  isFish ?? this.isFish ,
      correctStrings : correctStrings ?? this.correctStrings ,
      // isInteracting: isInteracting ?? this.isInteracting,
    );
  }

  @override
  List<Object?> get props => [
        gameData,
        letters,
        correctIndexes,
        isArabic,
        isFish ,
        correctStrings
        // isInteracting,
      ];
}
