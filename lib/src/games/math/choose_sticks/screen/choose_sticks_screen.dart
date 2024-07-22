import 'package:based_of_eng_game/src/core/theme_text.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/games_structure/basic_of_game_data.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/choose_sticks_cubit.dart';
import '../widget/card_of_number.dart';
import '../widget/card_of_selected.dart';
import '../widget/get_the_beads.dart';
import '../widget/get_the_blocks.dart';
import '../widget/stick.dart';

class ChooseSticksScreen extends StatelessWidget {
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
                Border.all(color: AppColorPhonetics.boarderColor, width: 5)),
        child: BlocConsumer<ChooseSticksCubit, ChooseSticksInitial>(
            listener: (context, state) {},
            builder: (context, gameState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(),
                  CardOfNumber(
                    number: "${gameState.mainNumber ?? ''}",
                  ),
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: List.generate(
                          gameState.gameChoices?.length ?? 0,
                          (index) => Row(
                                children: [
                                  CardOfSelected(
                                    onTap: () async {
                                      if (context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .ableButton()) {
                                        bool stateOfAnswer = context
                                            .read<ChooseSticksCubit>()
                                            .addAnswer(
                                                userChoose: int.parse(gameState
                                                        .gameChoices?[index]
                                                        .choice ??
                                                    '0'));
                                        if (stateOfAnswer == true) {
                                          await context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .addSuccessAnswer(
                                                  questions: gameState
                                                      .allGameData.length,
                                                  correctAnswers:
                                                      gameState.correctAnswers +
                                                          1)
                                              .whenComplete(() {
                                            bool isLastQuestion = context
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .checkIfIsTheLastQuestionOfGame(
                                                    queations: gameState
                                                        .allGameData.length);
                                            if (isLastQuestion) {
                                              // Future.delayed(const Duration(seconds: 2),
                                              //     () async {
                                              //   Navigator.of(context).pop();
                                              // });
                                            } else {
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () async {
                                                await context
                                                    .read<
                                                        CurrentGamePhoneticsCubit>()
                                                    .updateIndexOfCurrentGame();
                                                context
                                                    .read<ChooseSticksCubit>()
                                                    .updateTheCurrentGame(
                                                        index: context
                                                            .read<
                                                                CurrentGamePhoneticsCubit>()
                                                            .state
                                                            .index);
                                              });
                                            }
                                          });
                                        } else {
                                          await context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .addWrongAnswer(
                                                  actionOfWrongAnswer:
                                                      () async {});
                                        }
                                      }
                                    },
                                    itsId:
                                        gameState.gameChoices?[index].id ?? 0,
                                    selectedNumber: gameState.currentAnswer,
                                  ),
                                  10.pw,
                                  if ((gameState.basicData
                                              as MathChooseNumberSticksOrBeadsOrBlocks)
                                          .tools ==
                                      ToolsOfMath.sticks) ...{
                                    Slick(
                                      count: int.parse(gameState
                                              .gameChoices?[index].choice ??
                                          '0'),
                                    )
                                  } else if ((gameState.basicData
                                              as MathChooseNumberSticksOrBeadsOrBlocks)
                                          .tools ==
                                      ToolsOfMath.beads) ...{
                                    GetTheBeads(
                                      countOfBalls: int.parse(gameState
                                              .gameChoices?[index].choice ??
                                          '0'),
                                    )
                                  } else if ((gameState.basicData
                                              as MathChooseNumberSticksOrBeadsOrBlocks)
                                          .tools ==
                                      ToolsOfMath.blocks) ...{
                                    GetTheBlocks(
                                      countOfBoxes: int.parse(gameState
                                              .gameChoices?[index].choice ??
                                          '0'),
                                    )
                                  }
                                ],
                              ))),
                  SizedBox(),
                ],
              );
            }));
  }
}
