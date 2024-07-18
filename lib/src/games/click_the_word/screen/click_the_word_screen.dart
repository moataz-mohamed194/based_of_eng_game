import 'package:based_of_eng_game/src/games/click_the_word/widgets/correct_word.dart';
import 'package:based_of_eng_game/src/games/click_the_word/widgets/master_word.dart';
import 'package:based_of_eng_game/src/games/click_the_word/widgets/wrong_word.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/games_structure/basic_of_game_data.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/click_the_word_cubit.dart';
import '../widgets/choose_word.dart';

class ClickTheWordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ClickTheWordScreen();
  }
}

class _ClickTheWordScreen extends State<ClickTheWordScreen> {
  @override
  void initState() {
    final List<GameFinalModel> gameData =
        context.read<ClickTheWordCubit>().state.listGameData;
    context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
        mainCountOfQuestion:
            context.read<ClickTheWordCubit>().state.countQuestion ?? 0);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.isWord,
        stateOfStringWillSay: gameData.first.correctAns ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isInteracting =
        context.watch<CurrentGamePhoneticsCubit>().state.stateOfAvatar;

    return BlocConsumer<ClickTheWordCubit, ClickTheWordInitial>(
        listener: (context, state) {
      context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
          stateOfStringIsWord: StateOfSubWord.isWord,
          stateOfStringWillSay: state.gameData.correctAns ?? '');
    }, builder: (context, gameState) {
      return Container(
        margin: const EdgeInsets.only(bottom: (15 + 50), top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: MediaQuery.of(context).size.width - (130 + 50 + 130),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: AppColorPhonetics.boarderColor, width: 5)),
        child: Column(
          children: [
            MasterWord(word: gameState.headOfQuestion ?? ''),
            25.ph,
            Wrap(
                runSpacing: 10,
                // mainAxisSize: MainAxisSize.min,
                alignment: WrapAlignment.center,
                children: List.generate(
                    gameState.choose?.length ?? 0,
                    (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: GestureDetector(
                          onTap: () async {
                            List<int> listCorrectAnswers =
                                gameState.listCorrectAnswers;
                            int countOfQuestion = 0;
                            List<GameFinalModel> listGameData2 = gameState
                                .listGameData
                                .sublist(0, (gameState.index + 1));
                            listGameData2.forEach((element) {
                              int countOfQuestionSubGame = element.gameLetters
                                      ?.where((element2) =>
                                          element2.letter == element.correctAns)
                                      .length ??
                                  0;
                              countOfQuestion =
                                  countOfQuestion + countOfQuestionSubGame;
                            });
                            if (context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .ableButton() &&
                                (!gameState.listCorrectAnswers
                                    .contains(gameState.choose?[index].id)) &&
                                (listCorrectAnswers.length !=
                                    countOfQuestion)) {
                              if ((gameState.choose?[index].letter ==
                                  gameState.headOfQuestion)) {
                                bool stateOfAnswer = context
                                    .read<ClickTheWordCubit>()
                                    .addAnswer(
                                        answerId:
                                            gameState.choose?[index].id ?? 0);
                                await context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .addSuccessAnswer(
                                        questions: gameState.countQuestion ?? 0,
                                        correctAnswers:
                                            gameState.listCorrectAnswers.length)
                                    .whenComplete(() async {
                                  print('stateOfAnswer:$stateOfAnswer');
                                  if (stateOfAnswer == true) {
                                    // bool isLastQuestion = context
                                    //     .read<
                                    //         CurrentGamePhoneticsCubit>()
                                    //     .checkIfIsTheLastQuestionOfGame(
                                    //         queations: gameState
                                    //                 .countQuestion ??
                                    //             0);
                                    print(
                                        'countQuestion:${gameState.countQuestion}, ${gameState.listCorrectAnswers.length}');

                                    // print('isLastQuestion:$isLastQuestion');

                                    Future.delayed(const Duration(seconds: 2),
                                        () async {
                                      if (gameState.countQuestion ==
                                          gameState.listCorrectAnswers.length) {
                                        context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .state
                                            .actionWhenTriesBeZero
                                            .call(context
                                                    .read<
                                                        CurrentGamePhoneticsCubit>()
                                                    .state
                                                    .countOfStar ??
                                                0);
                                        // Navigator.of(context).pop();

                                        return;
                                      }
                                      await context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .updateIndexOfCurrentGame();
                                      context
                                          .read<ClickTheWordCubit>()
                                          .updateTheCurrentGame(
                                              index: context
                                                  .read<
                                                      CurrentGamePhoneticsCubit>()
                                                  .state
                                                  .index);
                                    });
                                  }
                                  //  else {
                                  //   Future.delayed(
                                  //       const Duration(seconds: 2),
                                  //       () async {
                                  //
                                  //   });
                                  // }
                                });
                              } else {
                                context
                                    .read<ClickTheWordCubit>()
                                    .addWrongAnswer(
                                        answerId:
                                            gameState.choose?[index].id ?? 0);
                                await context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .addWrongAnswer(
                                        actionOfWrongAnswer: () async {});
                              }
                            }
                          },
                          child: gameState.choose?[index].id ==
                                  gameState.wrongAnswer
                              ? WrongWord(
                                  word: gameState.choose?[index].letter ?? '')
                              : gameState.listCorrectAnswers
                                      .contains(gameState.choose?[index].id)
                                  ? CorrectWord(
                                      word:
                                          gameState.choose?[index].letter ?? '')
                                  : ChooseWord(
                                      word:
                                          gameState.choose?[index].letter ?? '',
                                    ),
                        ))))
          ],
        ),
      );
    });
  }
}
