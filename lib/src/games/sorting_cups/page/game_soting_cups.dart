import 'dart:developer';

import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/games_structure/basic_of_game_data.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/phonetics_color.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/sorting_cups_cubit.dart';
import '../widget/cup_widget.dart';
import '../widget/item_card_widget_sorting_cups.dart';

class GamesSortingCups extends StatefulWidget {
  const GamesSortingCups({super.key, this.isArabic = false});
  final bool isArabic;

  @override
  State<StatefulWidget> createState() {
    return _GamesSortingCups();
  }
}

class _GamesSortingCups extends State<GamesSortingCups> {
  @override
  void initState() {
    final GameFinalModel gameData =
        context.read<SortingCupsCubit>().state.gameData;
    context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
        mainCountOfQuestion: gameData.gameLetters?.length ?? 0);

    // context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
    //     stateOfStringIsWord: StateOfSubWord.isLetter,
    //     stateOfStringWillSay: gameData.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 15.w, bottom: 10.h, top: 35.h),
        width: MediaQuery.of(context).size.width - 40.w,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: AppColorPhonetics.darkBorderColor, width: 5)),
        child: SizedBox(
          child: BlocConsumer<SortingCupsCubit, SortingCupsInitial>(
              listener: (context, state) {
            context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
                stateOfStringIsWord: StateOfSubWord.isLetter,
                stateOfStringWillSay: state.chooseWord?.letter ?? '');
          }, builder: (context, gameState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                5.ph,
                ...List.generate(
                    ((gameState.cardsLetters?.length ?? 0) / 10).ceil(),
                    (rowIndex) {
                  int startIndex = rowIndex * 10;
                  int endIndex = (rowIndex + 1) * 10;
                  endIndex = endIndex > (gameState.cardsLetters?.length ?? 0)
                      ? (gameState.cardsLetters?.length ?? 0)
                      : endIndex;

                  List<GameLettersGameFinalModel> rowItems =
                      (gameState.cardsLetters)?.sublist(startIndex, endIndex) ??
                          [];

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: rowItems.asMap().entries.map(
                      (item) {
                        GlobalKey key = GlobalKey();

                        return Row(
                          key: key,
                          children: [
                            Draggable<GameLettersGameFinalModel>(
                                // onDraggableCanceled:
                                //     (Velocity velocity, Offset offset) {},
                                // onDragStarted: () {},
                                data: item.value,
                                maxSimultaneousDrags: 1,
                                childWhenDragging: SizedBox(
                                  width: (MediaQuery.of(context).size.width -
                                          (5)) /
                                      13,
                                  height: (MediaQuery.of(context).size.height -
                                          (50)) /
                                      5,
                                ),
                                feedback: ItemCardWidgetOFSortingCups(
                                  width: (MediaQuery.of(context).size.width -
                                          (5)) /
                                      13,
                                  height: (MediaQuery.of(context).size.height -
                                          (50)) /
                                      4,
                                  body: item.value.letter ?? '',
                                  hide: gameState.correctIndexes
                                          ?.contains(item.value.id ?? '') ??
                                      false,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: double.parse(
                                          "${(item.key) % 5 == 0.0 ? 0.0 : double.parse("${(item.key) % 4 != 0 ? ((item.key) > 5 ? (item.key - 5) : item.key) * 5 : (((item.key) > 5 ? (item.key - 5) : item.key) - 2) * 5}")}")),
                                  child: gameState.correctIndexes
                                              ?.contains(item.value.id) ==
                                          true
                                      ? SizedBox(
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  (5)) /
                                              13,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  (50)) /
                                              5,
                                        )
                                      : ItemCardWidgetOFSortingCups(
                                          hide: gameState.correctIndexes
                                                  ?.contains(
                                                      item.value.id ?? '') ??
                                              false,
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  (5)) /
                                              13,
                                          height: (MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  (50)) /
                                              5,
                                          body: item.value.letter ?? '',
                                        ),
                                )),
                            if ((item.key) < rowItems.length - 1)
                              const SizedBox(width: 5),
                          ],
                        );
                      },
                    ).toList(),
                  );
                }),
                SizedBox(
                  // height: MediaQuery.of(context).size.height / 4,
                  width:
                      ((gameState.gameData.mainLetter?.split('').length ?? 0) >
                              4)
                          ? (MediaQuery.of(context).size.width - 100.w)
                          : MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        gameState.gameData.mainLetter?.split('').length ?? 0,
                        (index) {
                      return BlocConsumer<CurrentGamePhoneticsCubit,
                              CurrentGamePhoneticsState>(
                          listener: (context, state) {},
                          builder: (context, generalStateOfGame) {
                            return DragTarget<GameLettersGameFinalModel>(
                              builder:
                                  (context, candidateItems, rejectedItems) {
                                // log('candidateItems:${candidateItems}');
                                // log('rejectedItems:${context.}');
                                return CupWidget(
                                    image: gameState.gameData.mainLetter
                                            ?.split('')[index] ??
                                        '');
                              },
                              onAcceptWithDetails: (item) async {
                                if (context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .ableButton()) {
                                  log("##:${gameState.gameData.mainLetter?.split('')[index].toLowerCase()}");

                                  log("##:${gameState.chooseWord?.letter?.toLowerCase()}");
                                  log("##:${(item.data.letter?.toLowerCase() ?? '')}");
                                  if (gameState.chooseWord?.letter
                                              ?.toLowerCase() ==
                                          (item.data.letter?.toLowerCase() ??
                                              '') &&
                                      (item.data.letter?.toLowerCase() ?? '') ==
                                          (gameState.gameData.mainLetter
                                              ?.split('')[index]
                                              .toLowerCase())) {
                                    await context
                                        .read<SortingCupsCubit>()
                                        .addTheCorrectAnswer(
                                            idOfUserAnswer: item.data.id ?? 0);
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addSuccessAnswer(
                                            isArabic: widget.isArabic,
                                            subAction: () async {
                                              await context
                                                  .read<SortingCupsCubit>()
                                                  .getTheRandomWord();
                                            },
                                            questions: gameState
                                                    .cardsLetters?.length ??
                                                0,
                                            correctAnswers: gameState
                                                    .correctIndexes?.length ??
                                                0)
                                        .whenComplete(() async {
                                      bool isLastQuestion = context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .secondWayToCheckIfIsTheLastQuestionOfGame(
                                              queations: gameState
                                                      .cardsLetters?.length ??
                                                  0);
                                      if (isLastQuestion) {
                                        // Future.delayed(
                                        //     const Duration(seconds: 2),
                                        //     () async {
                                        //   Navigator.of(context).pop();
                                        // });
                                      } else {}
                                    });

                                    // await context
                                    //     .read<CurrentGamePhoneticsCubit>()
                                    //     .animationOfCorrectAnswer();
                                    //

                                    // context
                                    //     .read<CurrentGamePhoneticsCubit>()
                                    //     .addStarToStudent(
                                    //       stateOfCountOfCorrectAnswer:
                                    //           gameState.correctIndexes?.length ??
                                    //               0,
                                    //       mainCountOfQuestion: gameState
                                    //               .gameData.gameLetters?.length ??
                                    //           0,
                                    //     );
                                    // bool isLastLesson = context
                                    //     .read<SortingCupsCubit>()
                                    //     .checkIfIsTheLastGameOfLesson();
                                    // if (isLastLesson == true) {
                                    //   await Future.delayed(
                                    //       const Duration(seconds: 2));
                                    //   context
                                    //       .read<CurrentGamePhoneticsCubit>()
                                    //       .clearCurrentStringOfDice();
                                    //   context
                                    //       .read<CurrentGamePhoneticsCubit>()
                                    //       .sendStars(
                                    //           gamesId: [
                                    //         gameState.gameData.id ?? 0
                                    //       ],
                                    //           actionOfStars: (int countOfStars,
                                    //               List<int> listOfIds) {
                                    //             context
                                    //                 .read<JourneyBarCubit>()
                                    //                 .sendStars(
                                    //                     gamesId: listOfIds,
                                    //                     countOfStar:
                                    //                         countOfStars);
                                    //           });
                                    //   Navigator.of(context).pop();
                                    // } else {
                                    //   await context
                                    //       .read<CurrentGamePhoneticsCubit>()
                                    //       .backToMainAvatar();
                                    //   context
                                    //       .read<SortingCupsCubit>()
                                    //       .getTheRandomWord();
                                    //   print('item:${item.data}');
                                    //   await context
                                    //       .read<CurrentGamePhoneticsCubit>()
                                    //       .backToMainAvatar();
                                    //   // await context
                                    //   //     .read<BingoCubit>()
                                    //   //     .getTheRandomWord(awaitTime: false);
                                    // }
                                  } else {
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addWrongAnswer(
                                            isArabic: widget.isArabic,
                                            actionOfWrongAnswer: () async {
                                              context
                                                  .read<SortingCupsCubit>()
                                                  .sayTheLetter();
                                            });
                                  }
                                }
                              },
                            );
                          });
                    }),
                  ),
                ),
              ],
            );
          }),
        ));
  }
}
