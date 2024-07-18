import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';

import '../../../core/games_structure/basic_of_game_data.dart';
import '../../../core/phonetics_color.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/dice_cubit.dart';
import '../widget/item_card_of_image_widget.dart';

class DiceGamePage extends StatefulWidget {
  const DiceGamePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DiceGamePage();
  }
}

class _DiceGamePage extends State<DiceGamePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DiceCubit>().playTheDice(
          context: context,
          functionOfSaveWords: (String currentAlphabet) {
            context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
                stateOfStringIsWord: StateOfSubWord.isLetter,
                stateOfStringWillSay: currentAlphabet);
            context
                .read<CurrentGamePhoneticsCubit>()
                .saveCurrentStringOfDice(letter: currentAlphabet);
          });
      final GameFinalModel gameData = context.read<DiceCubit>().state.gameData;
      context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
          mainCountOfQuestion: gameData.gameImages?.length ?? 0);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isInteracting =
        context.watch<CurrentGamePhoneticsCubit>().state.stateOfAvatar;

    return Container(
        margin: EdgeInsets.only(right: 15.w, bottom: 9),
        width: MediaQuery.of(context).size.width - (100.w),
        height: MediaQuery.of(context).size.height - 69.h,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: AppColorPhonetics.darkBorderColor, width: 5)),
        child: BlocConsumer<DiceCubit, DiceInitial>(listener: (context, state) {
          // context.read<DiceCubit>().playTheDice(context: context);
        }, builder: (context, gameState) {
          return SizedBox(
            width: MediaQuery.of(context).size.width - (100.w),
            height: MediaQuery.of(context).size.height - 60.h,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: List.generate(
                  (gameState.gameImages)?.length ?? 0,
                  (index) => BlocConsumer<CurrentGamePhoneticsCubit,
                          CurrentGamePhoneticsState>(
                      listener: (context, state) {},
                      builder: (context0, generalStateOfGame) {
                        return ItemCardOfImageWidget(
                          word: (gameState.gameImages)?[index].word ?? '',
                          onTap: () async {
                            if (context
                                .read<CurrentGamePhoneticsCubit>()
                                .ableButton()) {
                              if (gameState.correctIndexes.contains(
                                      gameState.gameImages?[index].id) ==
                                  false) {
                                if (gameState.gameImages?[index].gameLetterId ==
                                    gameState.chooseWordId) {
                                  await context
                                      .read<DiceCubit>()
                                      .addTheCorrectAnswer(
                                          idOfUserAnswer:
                                              (gameState.gameImages)?[index]
                                                      .id ??
                                                  0);
                                  await context
                                      .read<CurrentGamePhoneticsCubit>()
                                      .addSuccessAnswer(
                                          questions:
                                              gameState.gameImages?.length ?? 0,
                                          correctAnswers:
                                              gameState.correctIndexes.length)
                                      .whenComplete(() async {
                                    bool isLastQuestion = context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .secondWayToCheckIfIsTheLastQuestionOfGame(
                                            queations:
                                                gameState.gameImages?.length ??
                                                    0);
                                    context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .clearCurrentStringOfDice();
                                    if (isLastQuestion) {
                                      // Future.delayed(const Duration(seconds: 2),
                                      //     () async {
                                      //   Navigator.of(context).pop();
                                      // });
                                    } else {
                                      context.read<DiceCubit>().playTheDice(
                                          context: context,
                                          functionOfSaveWords:
                                              (String currentAlphabet) {
                                            context
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .saveTheStringWillSay(
                                                    stateOfStringIsWord:
                                                        StateOfSubWord.isLetter,
                                                    stateOfStringWillSay:
                                                        currentAlphabet);

                                            context
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .saveCurrentStringOfDice(
                                                    letter: currentAlphabet);
                                          });
                                    }
                                  });
                                } else {
                                  await context
                                      .read<CurrentGamePhoneticsCubit>()
                                      .addWrongAnswer(
                                          actionOfWrongAnswer: () async {});
                                }
                              }
                            }
                          },
                          body: (gameState.gameImages)?[index].image ?? '',
                          maxHeight: (((gameState.gameImages)?.length ?? 0) /
                                      4 ==
                                  4
                              ? (MediaQuery.of(context).size.height - (85.h)) /
                                  4
                              : (MediaQuery.of(context).size.height - (85.h)) /
                                  4),
                          maxWidth:
                              (((gameState.gameImages)?.length ?? 0) / 4 == 4
                                  ? (MediaQuery.of(context).size.width -
                                          (115.w)) /
                                      4
                                  : (MediaQuery.of(context).size.width -
                                          (115.w)) /
                                      5),
                          hide: gameState.correctIndexes
                              .contains((gameState.gameImages)?[index].id),
                          index: index,
                          countOfImages: (gameState.gameImages)?.length ?? 0,
                        );
                      })),
            ),
          );
        }));
  }
}
