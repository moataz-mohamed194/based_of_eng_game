part of 'ddt_number_cubit.dart';

@immutable
class DDTChangeInitial extends Equatable {
  final List<GameImagesGameFinalModel>? headOfQuestions;
  final List<GameChoicesGameFinalModel>? chooseOfQuestions;
  final GameFinalModel gameData;
  final GameChoicesGameFinalModel? firstChooseInDrag;
  final GameChoicesGameFinalModel? secondChooseInDrag;
  final List<GameFinalModel> allGameData;
  final int index;
  final List<GameChoicesGameFinalModel>? subHeadOfQuestions;
  final String? numberOfAnswerFirstBox;
  final String? numberWillAddToAnswerFirstBox;
  final bool? showTheAnswerOfFirstTyping;
  final bool? showTheAnswerOfSecondTyping;
  final String? correctAns;
  final int? countOfCorrectAnswers;
  final bool? isCorrect;

  DDTChangeInitial(
      {this.numberOfAnswerFirstBox,
      required this.gameData,
      required this.allGameData,
      required this.index,
      this.headOfQuestions,
      this.subHeadOfQuestions,
      this.firstChooseInDrag,
      this.showTheAnswerOfFirstTyping,
      this.showTheAnswerOfSecondTyping,
      this.secondChooseInDrag,
      this.numberWillAddToAnswerFirstBox,
      this.correctAns,
      this.chooseOfQuestions,
      this.countOfCorrectAnswers,
      this.isCorrect});

  DDTChangeInitial copyWith(
      {List<GameImagesGameFinalModel>? headOfQuestions,
      List<GameChoicesGameFinalModel>? chooseOfQuestions,
      GameFinalModel? gameData,
      GameChoicesGameFinalModel? firstChooseInDrag,
      GameChoicesGameFinalModel? secondChooseInDrag,
      List<GameFinalModel>? allGameData,
      int? index,
      String? numberOfAnswerFirstBox,
      String? numberWillAddToAnswerFirstBox,
      String? correctAns,
      int? countOfCorrectAnswers,
      bool? showTheAnswerOfSecondTyping,
      bool? showTheAnswerOfFirstTyping,
      bool? isCorrect}) {
    print('${showTheAnswerOfFirstTyping}'
        '${this.showTheAnswerOfFirstTyping} , ${showTheAnswerOfFirstTyping ?? this.showTheAnswerOfFirstTyping}');
    return DDTChangeInitial(
        gameData: gameData ?? this.gameData,
        index: index ?? this.index,
        showTheAnswerOfFirstTyping:
            showTheAnswerOfFirstTyping ?? this.showTheAnswerOfFirstTyping,
        showTheAnswerOfSecondTyping:
            showTheAnswerOfSecondTyping ?? this.showTheAnswerOfSecondTyping,
        headOfQuestions: headOfQuestions ?? this.headOfQuestions,
        firstChooseInDrag: firstChooseInDrag ?? this.firstChooseInDrag,
        secondChooseInDrag: secondChooseInDrag ?? this.secondChooseInDrag,
        chooseOfQuestions: chooseOfQuestions ?? this.chooseOfQuestions,
        numberOfAnswerFirstBox:
            numberOfAnswerFirstBox ?? this.numberOfAnswerFirstBox,
        allGameData: allGameData ?? this.allGameData,
        countOfCorrectAnswers:
            countOfCorrectAnswers ?? this.countOfCorrectAnswers,
        isCorrect: isCorrect ?? this.isCorrect,
        correctAns: correctAns ?? this.correctAns,
        numberWillAddToAnswerFirstBox: numberWillAddToAnswerFirstBox ??
            this.numberWillAddToAnswerFirstBox);
  }

  DDTChangeInitial clearTheDataOfChoose() {
    return DDTChangeInitial(
        gameData: gameData,
        index: index,
        headOfQuestions: headOfQuestions ?? headOfQuestions,
        firstChooseInDrag: null,
        showTheAnswerOfSecondTyping: null,
        showTheAnswerOfFirstTyping: null,
        secondChooseInDrag: null,
        chooseOfQuestions: chooseOfQuestions ?? chooseOfQuestions,
        numberOfAnswerFirstBox:
            numberOfAnswerFirstBox ?? numberOfAnswerFirstBox,
        allGameData: allGameData,
        countOfCorrectAnswers: countOfCorrectAnswers ?? countOfCorrectAnswers,
        isCorrect: isCorrect ?? isCorrect,
        correctAns: correctAns ?? correctAns,
        numberWillAddToAnswerFirstBox:
            numberWillAddToAnswerFirstBox ?? numberWillAddToAnswerFirstBox);
  }

  @override
  List<Object?> get props => [
        gameData,
        index,
        secondChooseInDrag,
        firstChooseInDrag,
        headOfQuestions,
        chooseOfQuestions,
        numberOfAnswerFirstBox,
        showTheAnswerOfSecondTyping,
        showTheAnswerOfSecondTyping,
        showTheAnswerOfFirstTyping,
        showTheAnswerOfSecondTyping,
        allGameData,
        isCorrect,
        countOfCorrectAnswers,
        countOfCorrectAnswers
      ];
}
