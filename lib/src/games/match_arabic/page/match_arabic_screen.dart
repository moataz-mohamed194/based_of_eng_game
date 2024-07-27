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
import '../manager/match_arabic_cubit.dart';
import '../../match/widgets/matching_path.dart';

class MatchArabicScreen extends StatefulWidget {
  const MatchArabicScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MatchArabicScreen();
  }
}

class _MatchArabicScreen extends State<MatchArabicScreen> {
  @override
  void initState() {
    final GameFinalModel gameData = context.read<MatchArabicCubit>().state.gameData;
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

    return BlocConsumer<MatchArabicCubit, MatchArabicInitial>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Container(
            margin: const EdgeInsets.only(bottom: 20, top: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width - (100.w),
            height: MediaQuery.of(context).size.height - (50.h + 5 + 50.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: AppColorPhonetics.boarderColor, width: 5)),
            child: Stack(
              children: [
                IgnorePointer(
                  child: gestureDetector,
                ),
                CustomPaint(
                  size: Size.infinite,
                  painter: FinalMatchingArabicPainter(gameState.positions),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                            gameState.answers.length,
                            (index) => Listener(
                                onPointerMove: (event) {
                                  if (gameState.answers[index].id != null) {
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
                                  }
                                },
                                child:
                                Draggable<
                                    GameLettersGameFinalModel>(
                                  data: gameState.answers[index],
                                  feedback: const SizedBox(),
                                  key: gameState.widgetKey[index],
                                  childWhenDragging: _buildLetters(gameState, context, index),
                                  child: _buildLetters(gameState, context, index),
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
                                            (offset.dx) ,
                                            ((offset.dy) -
                                                ((50.h + 5 + 150.h) /
                                                    2))),
                                      ),
                                    );
                                  },
                                ))),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,

                        children: List.generate(
                          gameState.imageAnswers.length,
                          (index) => DragTarget<GameLettersGameFinalModel>(
                              onAcceptWithDetails: isInteracting != null &&
                                      isInteracting !=
                                          BasicOfGameData.stateOIdle
                                  ? null
                                  : (item) async {
                                      print('####:${item.data.letter}');
                                      print(
                                          '####:${gameState.imageAnswers[index].word}');
                                      if (gameState.imageAnswers[index].word
                                              ?.toLowerCase() ==
                                          item.data.letter?.toLowerCase()) {
                                        int countCorrectAnswers =
                                            await context
                                                .read<MatchArabicCubit>()
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
                                            // Future.delayed(
                                            //     const Duration(seconds: 2),
                                            //     () async {
                                            //   Navigator.of(context).pop();
                                            // });
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
                                return Column(
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
                                              .imageAnswers[index].image ??
                                          '',
                                      height: (MediaQuery.of(context)
                                              .size
                                              .height) /
                                          5,

                                      // height: 0.33.sh,
                                      placeholder: (context, url) =>
                                          const Center(
                                        child: CupertinoActivityIndicator(),
                                      ),
                                      errorWidget: (context, url, error) =>
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
                ),
              ],
            ),
          );
        });
  }

  Widget _buildLetters(MatchArabicInitial gameState, BuildContext context, int index) {
    return Container(
      height: 120.h,
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      child: Column(
        children: [
          _buildLetter(context, gameState, index),
          10.ph,
          _buildCircle(circleColor: AppColorPhonetics.lightBlue)
        ],
      ),
    );
  }
  Widget _buildLetter(BuildContext context, MatchArabicInitial gameState, int index) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10.w, vertical: 0.h), //EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border:
        Border.all(color: AppColorPhonetics.darkBorderColor, width: 2.w),
      ),
      child: FittedBox(
        child: Text(
          gameState.answers[index].letter ?? '',
          style: TextStyle(
              fontSize: 16.sp,
              fontFamily: AppTheme.getFontFamily5(),
              color: AppColorPhonetics.darkBorderColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
  Widget _buildCircle({required Color circleColor}) {
    return Container(
      height: 17,
      width: 17,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17), color: circleColor),
    );
  }
}
