import 'package:based_of_eng_game/src/core/theme_text.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/games_structure/basic_of_game_data.dart';
import '../../../../core/math_weidgt/card_of_blocks.dart';
import '../../../../core/math_weidgt/get_the_blocks.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../choose_from_obj/widget/card_of_number.dart';
import '../manager/sorting_blocks_cubit.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/math_weidgt/stick.dart';

class SortingBlocksScreen extends StatelessWidget {
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
        child: BlocConsumer<SortingBlocksCubit, SortingBlocksInitial>(
            listener: (context, state) {
          print('listener2');
        }, builder: (context, gameState) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  gameState.gameChoices?.length ?? 0,
                  (index) => Row(
                    children: [
                      CardOfNumber(
                        number: gameState.gameChoices?[index].choice ?? '0',
                        size: 65.h,
                      ),
                      10.pw,
                      DragTarget<int>(builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return CardOfBlocks(
                          number: gameState.correctAnswers.contains(
                                  gameState.gameChoices?[index].id ?? 0)
                              ? int.parse(
                                  gameState.gameChoices?[index].choice ?? '0')
                              : 0,
                          tools: ToolsOfMath.blocks,
                        );
                      }, onAcceptWithDetails: (item) async {
                        if (context
                            .read<CurrentGamePhoneticsCubit>()
                            .ableButton()) {
                          bool stateOfAnswer = context
                              .read<SortingBlocksCubit>()
                              .addAnswer(
                                  userChoose:
                                      gameState.gameChoices?[index].id ?? 0,
                                  secondChoose: item.data);
                          if (stateOfAnswer == true) {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addSuccessAnswer(
                                    questions: gameState
                                            .gameData.gameChoices?.length ??
                                        0,
                                    correctAnswers:
                                        gameState.correctAnswers.length)
                                .whenComplete(() {
                              bool isLastQuestion = context
                                  .read<CurrentGamePhoneticsCubit>()
                                  .checkIfIsTheLastQuestionOfGame(
                                      queations: gameState
                                              .gameData.gameChoices?.length ??
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
                                //       .read<SortingBlocksCubit>()
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
                      })
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    gameState.secondGameChoices?.length ?? 0,
                    (index) => gameState.correctAnswers.contains(
                            gameState.secondGameChoices?[index].id ?? 0)
                        ? GetTheBlocks(
                            isSolid: true,
                            countOfBoxes: int.parse(
                                "${gameState.secondGameChoices?[index].choice ?? 0}"),
                          )
                        : Draggable<int>(
                            maxSimultaneousDrags: 1,
                            feedback: GetTheBlocks(
                              countOfBoxes: int.parse(
                                  "${gameState.secondGameChoices?[index].choice ?? 0}"),
                            ),
                            // childWhenDragging: ,
                            data: gameState.secondGameChoices?[index].id ?? 0,
                            child: GetTheBlocks(
                              // isSolid: true,
                              countOfBoxes: int.parse(
                                  "${gameState.secondGameChoices?[index].choice ?? 0}"),
                            ))),
              )
            ],
          );
        }));
  }
}
