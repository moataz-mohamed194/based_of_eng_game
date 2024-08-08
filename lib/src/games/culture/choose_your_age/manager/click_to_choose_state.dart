part of 'click_to_choose_cubit.dart';

enum ClickToChooseType {
  chooseYourAge,
  chooseYourGender,
  chooseSenses,
}

extension ClickToChooseStateX on ClickToChooseState {
  bool get isChooseYourAge => type == ClickToChooseType.chooseYourAge;
  bool get isChooseYourGender => type == ClickToChooseType.chooseYourGender;
  bool get isChooseSenses => type == ClickToChooseType.chooseSenses;
}

@immutable
class ClickToChooseState extends Equatable {
  final ClickToChooseType type;
  final List<GameFinalModel> listGameData;
  final GameFinalModel gameData;
  final int countCorrectAnswers;
  final List<GameLettersGameFinalModel> mainImage;
  final List<GameImagesGameFinalModel> choices;
  final int index;
  final String? correctAnswer;
  final bool isCorrect;

  const ClickToChooseState({
    this.type = ClickToChooseType.chooseYourAge,
    required this.listGameData,
    required this.gameData,
    this.countCorrectAnswers = 0,
    required this.mainImage,
    this.correctAnswer,
    this.isCorrect = false,
    required this.choices,
    required this.index,
  });

  ClickToChooseState copyWith({
    ClickToChooseType? type,
    List<GameFinalModel>? listGameData,
    GameFinalModel? gameData,
    int? countCorrectAnswers,
    String? correctAnswer,
    bool? isCorrect,
    List<GameLettersGameFinalModel>? mainImage,
    List<GameImagesGameFinalModel>? choices,
    int? index,
  }) {
    return ClickToChooseState(
      type: type ?? this.type,
      listGameData: listGameData ?? this.listGameData,
      gameData: gameData ?? this.gameData,
      isCorrect: isCorrect ?? this.isCorrect,
      countCorrectAnswers: countCorrectAnswers ?? this.countCorrectAnswers,
      mainImage: mainImage ?? this.mainImage,
      correctAnswer: correctAnswer ?? this.correctAnswer,
      choices: choices ?? this.choices,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [
        type,
        correctAnswer,
        listGameData,
        gameData,
        countCorrectAnswers,
        mainImage,
        choices,
        index,
      ];
}
