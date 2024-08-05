part of 'current_game_phonetics_cubit.dart';

enum StateOfSubWord { isWord, isLetter, stopTalk }

class CurrentGamePhoneticsState extends Equatable {
  Artboard? avatarArtboardIdle;
  Artboard? avatarArtboardSuccess;
  Artboard? avatarArtboardSad;
  Artboard? avatarCurrentArtboard;
  bool? touchPositions = false;
  String? stateOfAvatar;
  bool? showAlert;
  BuildContext context;
  String? stateOfStringWillSay;
  StateOfSubWord? stateOfStringIsWord;
  bool beeTalking;
  int countOfWrongAnswers;
  int countOfCorrectAnswers;
  String? currentStringOfDice;
  void Function(int x) actionWhenTriesBeZero;
  void Function() backButton;
  // String? currentAvatar;
  int index;
  int? countOfTries;
  List<GameFinalModel>? gameData;
  List<int>? statesOfAddStars;
  int? countOfStar = 0;
  MainDataOfChapters? basicData;
  CurrentGamePhoneticsState(
      {this.basicData,
      this.gameData,
      this.avatarCurrentArtboard,
      this.stateOfStringIsWord,
      this.stateOfStringWillSay,
      required this.actionWhenTriesBeZero,
      required this.backButton,
      this.stateOfAvatar,
      this.avatarArtboardIdle,
      this.avatarArtboardSad,
      required this.context,
      this.beeTalking = false,
      this.touchPositions,
      this.currentStringOfDice,
      this.avatarArtboardSuccess,
      this.countOfWrongAnswers = 0,
      this.countOfCorrectAnswers = 0,
      this.statesOfAddStars,
      this.showAlert,
      this.countOfTries,
      // this.currentAvatar,
      required this.index,
      this.countOfStar});

  CurrentGamePhoneticsState copyWith(
      {MainDataOfChapters? basicData,
      Artboard? avatarArtboardSuccess,
      Artboard? avatarArtboardIdle,
      Artboard? avatarArtboardSad,
      bool? touchPositions,
      StateOfSubWord? stateOfStringIsWord,
      BuildContext? context,
      bool? beeTalking,
      bool? showAlert,
      Artboard? avatarCurrentArtboard,
      String? stateOfStringWillSay,
      String? currentStringOfDice,
      void Function(int x)? actionWhenTriesBeZero,
      void Function()? backButton,
      // String? currentAvatar,
      String? stateOfAvatar,
      List<GameFinalModel>? gameData,
      List<int>? statesOfAddStars,
      int? index,
      int? countOfTries,
      int? countOfWrongAnswers,
      int? countOfCorrectAnswers,
      int? countOfCorrectAnswer,
      int? countOfStar}) {
    return CurrentGamePhoneticsState(
        basicData: basicData ?? this.basicData,
        index: index ?? this.index,
        currentStringOfDice: currentStringOfDice ?? this.currentStringOfDice,
        touchPositions: touchPositions ?? this.touchPositions,
        context: context ?? this.context,
        backButton: backButton ?? this.backButton,
        showAlert: showAlert ?? this.showAlert,
        actionWhenTriesBeZero:
            actionWhenTriesBeZero ?? this.actionWhenTriesBeZero,
        stateOfStringWillSay: stateOfStringWillSay ?? this.stateOfStringWillSay,
        avatarCurrentArtboard:
            avatarCurrentArtboard ?? this.avatarCurrentArtboard,
        gameData: gameData ?? this.gameData,
        countOfWrongAnswers: countOfWrongAnswers ?? this.countOfWrongAnswers,
        beeTalking: beeTalking ?? this.beeTalking,
        countOfCorrectAnswers:
            countOfCorrectAnswers ?? this.countOfCorrectAnswers,
        stateOfStringIsWord: stateOfStringIsWord ?? this.stateOfStringIsWord,
        statesOfAddStars: statesOfAddStars ?? this.statesOfAddStars,
        stateOfAvatar: stateOfAvatar ?? this.stateOfAvatar,
        // currentAvatar: currentAvatar ?? this.currentAvatar,
        avatarArtboardSad: avatarArtboardSad ?? this.avatarArtboardSad,
        countOfTries: countOfTries ?? this.countOfTries,
        avatarArtboardSuccess:
            avatarArtboardSuccess ?? this.avatarArtboardSuccess,
        avatarArtboardIdle: avatarArtboardIdle ?? this.avatarArtboardIdle,
        countOfStar: countOfStar ?? this.countOfStar);
  }

  clearCurrentStringOfDice() {
    return CurrentGamePhoneticsState(
        basicData: basicData ?? basicData,
        index: index,
        currentStringOfDice: null,
        touchPositions: touchPositions ?? touchPositions,
        actionWhenTriesBeZero: actionWhenTriesBeZero,
        backButton: backButton,
        stateOfStringWillSay: stateOfStringWillSay ?? stateOfStringWillSay,
        context: context ?? context,
        showAlert: showAlert ?? showAlert,
        avatarCurrentArtboard: avatarCurrentArtboard ?? avatarCurrentArtboard,
        gameData: gameData ?? gameData,
        countOfWrongAnswers: countOfWrongAnswers,
        beeTalking: beeTalking,
        countOfCorrectAnswers: countOfCorrectAnswers,
        stateOfStringIsWord: stateOfStringIsWord ?? stateOfStringIsWord,
        statesOfAddStars: statesOfAddStars ?? statesOfAddStars,
        stateOfAvatar: stateOfAvatar ?? stateOfAvatar,
        // currentAvatar: currentAvatar ?? currentAvatar,
        avatarArtboardSad: avatarArtboardSad ?? avatarArtboardSad,
        countOfTries: countOfTries ?? countOfTries,
        avatarArtboardSuccess: avatarArtboardSuccess ?? avatarArtboardSuccess,
        avatarArtboardIdle: avatarArtboardIdle ?? avatarArtboardIdle,
        countOfStar: countOfStar ?? countOfStar);
  }

  CurrentGamePhoneticsState clearAllData() {
    return CurrentGamePhoneticsState(
      index: 0,
      context: context,
      backButton: backButton,
      showAlert: false,
      actionWhenTriesBeZero: actionWhenTriesBeZero,
    );
  }

  @override
  List<Object?> get props => [
        basicData,
        // currentAvatar,
        avatarArtboardIdle,
        context,
        backButton,showAlert,
        stateOfStringIsWord,
        stateOfStringWillSay,
        avatarArtboardSad,
        currentStringOfDice,
        countOfWrongAnswers,
        beeTalking,
        countOfCorrectAnswers,
        avatarArtboardSuccess,
        actionWhenTriesBeZero,
        gameData,
        avatarCurrentArtboard,
        touchPositions,
        countOfTries,
        stateOfAvatar,
        statesOfAddStars,
        index,
        countOfStar
      ];
}
