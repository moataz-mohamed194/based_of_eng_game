import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../based_of_eng_game.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../widgets/final_matching_path.dart';
import '../manager/match_cubit.dart';
import '../widgets/matching_path.dart';

class MatchScreen extends StatefulWidget {
  const MatchScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MatchScreen();
  }
}

class _MatchScreen extends State<MatchScreen> {
  @override
  void initState() {
    final GameFinalModel gameData = context.read<MatchCubit>().state.gameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.gameImages?.length ?? 0);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.isLetter,
        stateOfStringWillSay: gameData.mainLetter ?? '');
    super.initState();
  }

  Offset? start;
  Offset? end;

  @override
  Widget build(BuildContext context) {
    final stateOfCurrentGamePhoneticsCubit =
        context.watch<CurrentGamePhoneticsCubit>().state;
    GestureDetector gestureDetector = GestureDetector(
      onPanStart: (details) {
        setState(() {
          start = details.localPosition;
          end = null;
        });
      },
      onPanUpdate: (details) {
        setState(() {
          end = details.localPosition;
        });
      },
      child: CustomPaint(
        size: Size.infinite,
        painter: LinePainter(start, end),
      ),
    );
    final isInteracting =
        context.watch<CurrentGamePhoneticsCubit>().state.stateOfAvatar;

    return BlocConsumer<MatchCubit, MatchInitial>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Container(
            margin: const EdgeInsets.only(bottom: (15 + 50), top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: MediaQuery.of(context).size.width - (300),
            height: MediaQuery.of(context).size.height - (50.h + 5 + 120.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: AppColorPhonetics.boarderColor, width: 5)),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - (300),
              height: MediaQuery.of(context).size.height - (50.h + 5 + 120.h),
              child: Stack(
                children: [
                  IgnorePointer(
                    child: gestureDetector,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - (300),
                      height: MediaQuery.of(context).size.height -
                          (50.h + 5 + 120.h),
                      child: CustomPaint(
                        size: Size.infinite,
                        painter: FinalMatchingPainter(gameState.positions),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  gameState.answers.length,
                                  (index) => Listener(
                                      onPointerMove: (event) {
                                        var tempHeight =
                                            MediaQuery.of(context).size.height;
                                        if (tempHeight > 500) {
                                          gestureDetector.onPanUpdate!(
                                              DragUpdateDetails(
                                                  delta: Offset.zero,
                                                  globalPosition:
                                                      event.localPosition,
                                                  localPosition: Offset(
                                                      event.localPosition.dx,
                                                      index == 0
                                                          ? (event.localPosition
                                                                  .dy +
                                                              ((120.h)))
                                                          : (event.localPosition
                                                                  .dy +
                                                              ((100.h *
                                                                  (index +
                                                                      1)))))));
                                        } else {
                                          gestureDetector.onPanUpdate!(
                                              DragUpdateDetails(
                                                  delta: Offset.zero,
                                                  globalPosition:
                                                      event.position,
                                                  localPosition: Offset(
                                                      event.localPosition.dx,
                                                      index == 0
                                                          ? event
                                                              .localPosition.dy
                                                          : (event.localPosition
                                                                  .dy +
                                                              ((120.h) / 2)))));
                                        }
                                      },
                                      child: Container(
                                          height: 60.h,
                                          width: ((MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      (300)) /
                                                  6) *
                                              2,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Draggable<
                                              GameLettersGameFinalModel>(
                                            data: gameState.answers[index],
                                            feedback: const SizedBox(),
                                            key: gameState.widgetKey[index],
                                            childWhenDragging: Row(
                                              children: [
                                                SizedBox(
                                                  width: (((MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  (300)) /
                                                              6) *
                                                          2) -
                                                      (20 + 17),
                                                  child: Text(
                                                    gameState.answers[index]
                                                            .letter ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: AppTheme
                                                            .getFontFamily5(),
                                                        color: AppColorPhonetics
                                                            .darkBorderColor),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                20.pw,
                                                Container(
                                                  height: 17,
                                                  width: 17,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              17),
                                                      color: AppColorPhonetics
                                                          .lightYellowColor),
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: (((MediaQuery.of(context)
                                                                      .size
                                                                      .width -
                                                                  (300)) /
                                                              6) *
                                                          2) -
                                                      (20 + 17),
                                                  child: Text(
                                                    gameState.answers[index]
                                                            .letter ??
                                                        '',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontFamily: AppTheme
                                                            .getFontFamily5(),
                                                        color: AppColorPhonetics
                                                            .darkBorderColor),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                20.pw,
                                                Container(
                                                  height: 17,
                                                  width: 17,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              17),
                                                      color: AppColorPhonetics
                                                          .lightYellowColor),
                                                )
                                              ],
                                            ),
                                            onDragEnd: (e) {
                                              setState(() {
                                                start = Offset.zero;
                                                end = Offset.zero;
                                              });
                                            },
                                            onDragStarted: () {
                                              RenderBox renderBox = gameState
                                                      .widgetKey[index]
                                                      .currentContext!
                                                      .findRenderObject()
                                                  as RenderBox;
                                              Offset offset = renderBox
                                                  .localToGlobal(Offset.zero);
                                              gestureDetector.onPanStart!(
                                                DragStartDetails(
                                                  localPosition: Offset(
                                                      (offset.dx),
                                                      ((offset.dy) -
                                                          ((50.h + 5 + 120.h) /
                                                              2))),
                                                ),
                                              );
                                            },
                                          )))),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: List.generate(
                                gameState.imageAnswers.length,
                                (index) => DragTarget<
                                        GameLettersGameFinalModel>(
                                    onAcceptWithDetails: isInteracting !=
                                                null &&
                                            isInteracting !=
                                                BasicOfGameData.stateOIdle
                                        ? null
                                        : (item) async {
                                            print('####:${item.data.letter}');
                                            print(
                                                '####:${gameState.imageAnswers[index].word}');
                                            if (gameState
                                                    .imageAnswers[index].word
                                                    ?.toLowerCase() ==
                                                item.data.letter
                                                    ?.toLowerCase()) {
                                              int countCorrectAnswers =
                                                  await context
                                                      .read<MatchCubit>()
                                                      .addCorrectAnswer(
                                                          endPosition: end!,
                                                          startPosition: start!,
                                                          answerId:
                                                              item.data.id ?? 0,
                                                          imageAnswerId: gameState
                                                                  .imageAnswers[
                                                                      index]
                                                                  .id ??
                                                              0);
                                              print(
                                                  'gameState.countQuestions:${gameState.countQuestions}, ${gameState.countCorrectAnswers}');
                                              await context
                                                  .read<
                                                      CurrentGamePhoneticsCubit>()
                                                  .addSuccessAnswer(
                                                      questions: gameState
                                                          .countQuestions,
                                                      correctAnswers:
                                                          countCorrectAnswers)
                                                  .whenComplete(() {
                                                // print('listGameData:${gameState.listGameData.length}, countCorrectAnswers:${gameState.countCorrectAnswers}');

                                                if (gameState.countQuestions ==
                                                    countCorrectAnswers) {
                                                  Future.delayed(
                                                      const Duration(
                                                          seconds: 2),
                                                      () async {
                                                    Navigator.of(context).pop();
                                                  });
                                                }
                                                // else {
                                                //   Future.delayed(
                                                //       const Duration(seconds: 2),
                                                //           () async {
                                                //         await context
                                                //             .read<CurrentGamePhoneticsCubit>()
                                                //             .updateIndexOfCurrentGame();
                                                //         context
                                                //             .read<ListenChooseCubit>()
                                                //             .updateTheCurrentGame(
                                                //             index: context
                                                //                 .read<
                                                //                 CurrentGamePhoneticsCubit>()
                                                //                 .state
                                                //                 .index);
                                                //       });
                                                // }
                                              });
                                            } else {
                                              await context
                                                  .read<
                                                      CurrentGamePhoneticsCubit>()
                                                  .addWrongAnswer(
                                                      actionOfWrongAnswer:
                                                          () async {});
                                            }
                                          },
                                    builder: (context, onAccepted, onRejected) {
                                      return Row(
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        // mainAxisAlignment: MainAxisAlignment.,
                                        children: [
                                          Container(
                                            height: 17,
                                            width: 17,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(17),
                                                color: AppColorPhonetics
                                                    .lightYellowColor),
                                          ),
                                          20.pw,
                                          CachedNetworkImage(
                                            imageUrl: gameState
                                                    .imageAnswers[index]
                                                    .image ??
                                                '',
                                            height: (MediaQuery.of(context)
                                                    .size
                                                    .height) /
                                                5,

                                            // height: 0.33.sh,
                                            placeholder: (context, url) =>
                                                const Center(
                                              child:
                                                  CupertinoActivityIndicator(),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(
                                              Icons.error,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
