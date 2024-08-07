import 'package:based_of_eng_game/src/core/theme_text.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src_model/export_models.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/games_structure/basic_of_game_data.dart';
import '../../../../core/math_weidgt/card_of_Beads.dart';
import '../../../../core/math_weidgt/card_of_blocks.dart';
import '../../../../core/math_weidgt/get_the_blocks.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../choose_from_obj/widget/card_of_number.dart';
import '../manager/sorting_blocks_cubit.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/math_weidgt/stick.dart';

class SortingBeadsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height -
            (90.h + 50.h + 5 + 20.h), // < 760
        margin: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 20.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: AppColorPhonetics.darkBlueColor, width: 5)),
        child: BlocConsumer<SortingBeadsCubit, SortingBeadsInitial>(
            listener: (context, state) {
          print('listener2');
        }, builder: (context, gameState) {
          return Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 2,
                child: FittedBox(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        gameState.gameLetters?.length ?? 0,
                        (index) => Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            10.pw,
                            FittedBox(
                              child: Container(
                                width: MediaQuery.of(context).size.width / 2.4,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GetTheBeads(
                                      countOfBalls: int.parse(gameState
                                              .gameLetters?[index].letter ??
                                          '0'), // size: 65.h,
                                    ),
                                    Text(
                                      '+',
                                      style: TextStyle(
                                        color: AppColorPhonetics.darkBlueColor,
                                        fontSize: 20.sp,
                                        fontFamily: AppTheme.getFontFamily5(),
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                    GetTheBeads(
                                      countOfBalls: int.parse(gameState
                                              .gameLetters?[index].letter ??
                                          '0'), // size: 65.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            FittedBox(
                              child: DragTarget<GameImagesGameFinalModel>(
                                  builder: (
                                BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected,
                              ) {
                                return CardOfBeads(
                                  number: gameState.correctAnswers
                                          .where((ele) =>
                                              ele.gameLetterId ==
                                              gameState.gameLetters?[index].id)
                                          .toList()
                                          .isNotEmpty
                                      ? (int.parse(gameState
                                                  .gameLetters?[index].letter ??
                                              '0') +
                                          int.parse(gameState
                                                  .gameLetters?[index]
                                                  .secLetter ??
                                              '0'))
                                      : 0,
                                  tools: ToolsOfMath.beads,
                                );
                              }, onAcceptWithDetails: (item) async {
                                if (context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .ableButton()) {
                                  bool stateOfAnswer = context
                                      .read<SortingBeadsCubit>()
                                      .addAnswer(
                                          userChoose: gameState
                                                  .gameLetters?[index].id ??
                                              0,
                                          secondChoose: item.data);
                                  if (stateOfAnswer == true) {
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addSuccessAnswer(
                                            questions: gameState.gameData
                                                    .gameLetters?.length ??
                                                0,
                                            correctAnswers:
                                                gameState.correctAnswers.length)
                                        .whenComplete(() {
                                      bool isLastQuestion = context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .checkIfIsTheLastQuestionOfGame(
                                              queations: gameState.gameData
                                                      .gameLetters?.length ??
                                                  0);
                                      if (isLastQuestion) {
                                        // Future.delayed(const Duration(seconds: 2),
                                        //     () async {
                                        //   Navigator.of(context).pop();
                                        // });
                                      } else {
                                        // Future.delayed(const Duration(seconds: 2),
                                        //     () async {
                                        //   await context
                                        //       .read<CurrentGamePhoneticsCubit>()
                                        //       .updateIndexOfCurrentGame();
                                        //   context
                                        //       .read<SortingBeadsCubit>()
                                        //       .updateTheCurrentGame(
                                        //           index: context
                                        //               .read<
                                        //                   CurrentGamePhoneticsCubit>()
                                        //               .state
                                        //               .index);
                                        // });
                                      }
                                    });
                                  } else {
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addWrongAnswer(
                                            actionOfWrongAnswer: () async {});
                                  }
                                }
                              }),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: FittedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        gameState.gameImages?.length ?? 0,
                        (index) => gameState.correctAnswers
                                .where((element) =>
                                    element.id ==
                                    (gameState.gameImages?[index].id ?? 0))
                                .isNotEmpty
                            ? Opacity(
                                opacity: .5,
                                child: GetTheBeads(
                                  countOfBalls: int.parse(
                                      gameState.gameImages?[index].word ?? '0'),
                                  // size: 65.h,
                                ),
                              )
                            : Draggable<GameImagesGameFinalModel>(
                                maxSimultaneousDrags: 1,
                                feedback: GetTheBeads(
                                  countOfBalls: int.parse(
                                      "${gameState.gameImages?[index].word ?? 0}"),
                                ),
                                // childWhenDragging: ,
                                data: gameState.gameImages?[index],
                                child: GetTheBeads(
                                  // isSolid: true,
                                  countOfBalls: int.parse(
                                      "${gameState.gameImages?[index].word ?? 0}"),
                                ))),
                  ),
                ),
              )
            ],
          );
        }));
  }
}
