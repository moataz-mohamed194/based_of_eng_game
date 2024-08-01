import 'dart:developer';

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
import '../../choose_number_from_wood/widget/wood_row.dart';
import '../manager/drag_beads_board_cubit.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/math_weidgt/stick.dart';
import '../widget/wood_row_drag.dart';

class DragBeadsBoardScreen extends StatelessWidget {
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
        child: BlocConsumer<DragBeadsBoardCubit, DragBeadsBoardInitial>(
            listener: (context, state) {
          print('listener2');
        }, builder: (context, gameState) {
          return Row(
            children: [
              Expanded(
                child: FittedBox(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WoodRowDrag(
                          gameState: gameState,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: FittedBox(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                  gameState.gameLetters?.length ?? 0,
                                  (index) =>
                                      DragTarget<GameLettersGameFinalModel>(
                                          builder: (
                                        BuildContext context,
                                        List<dynamic> accepted,
                                        List<dynamic> rejected,
                                      ) {
                                        return CardOfBeads(
                                          newWidget: gameState.correctAnswers
                                                  .where((ele) =>
                                                      ele.id ==
                                                      gameState
                                                          .gameImages?[index]
                                                          .gameLetterId)
                                                  .toList()
                                                  .isEmpty
                                              ? SizedBox()
                                              : FittedBox(
                                                  child: _bodyOfTheDragTarget(
                                                      gameLetters: gameState
                                                          .correctAnswers
                                                          .where((ele) =>
                                                              ele.id ==
                                                              gameState
                                                                  .gameImages?[
                                                                      index]
                                                                  .gameLetterId)
                                                          .toList()
                                                          .first)),
                                          number: 100,
                                          tools: ToolsOfMath.blocks,
                                        );
                                        // return CardOfBlocks(
                                        //   number: gameState.correctAnswers
                                        //           .contains(gameState
                                        //                   .gameImages?[index]
                                        //                   .gameLetterId ??
                                        //               0)
                                        //       ? int.parse(gameState
                                        //               .gameImages?[index]
                                        //               .word ??
                                        //           '0')
                                        //       : 0,
                                        //   tools: ToolsOfMath.blocks,
                                        // );
                                      }, onAcceptWithDetails: (item) async {
                                        print('##:${item.data}');
                                        log('##:${item.data}');
                                        if (context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .ableButton()) {
                                          bool stateOfAnswer = context
                                              .read<DragBeadsBoardCubit>()
                                              .addAnswer(
                                                  userChoose: gameState
                                                          .gameImages?[index]
                                                          .gameLetterId ??
                                                      0,
                                                  secondChoose: item.data);
                                          if (stateOfAnswer == true) {
                                            await context
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .addSuccessAnswer(
                                                    questions: gameState
                                                            .gameData
                                                            .gameImages
                                                            ?.length ??
                                                        0,
                                                    correctAnswers: gameState
                                                        .correctAnswers.length)
                                                .whenComplete(() {
                                              bool isLastQuestion = context
                                                  .read<
                                                      CurrentGamePhoneticsCubit>()
                                                  .checkIfIsTheLastQuestionOfGame(
                                                      queations: gameState
                                                              .gameData
                                                              .gameLetters
                                                              ?.length ??
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
                                                //       .read<DragBeadsBoardCubit>()
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
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .addWrongAnswer(
                                                    actionOfWrongAnswer:
                                                        () async {});
                                          }
                                        }
                                      })),
                            ),
                          ),
                        )
                      ]),
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
                                    (gameState.gameLetters?[index].id ?? 0))
                                .isNotEmpty
                            ? Opacity(
                                opacity: .5,
                                child: _bodyOfTheDragTarget(
                                    gameLetters: gameState.gameLetters?[index]),
                              )
                            : Draggable<GameLettersGameFinalModel>(
                                maxSimultaneousDrags: 1,
                                feedback: _bodyOfTheDragTarget(
                                    gameLetters: gameState.gameLetters?[index]),
                                // childWhenDragging: ,
                                data: gameState.gameLetters?[index],
                                child: _bodyOfTheDragTarget(
                                    gameLetters: gameState.gameLetters?[index]),
                              )),
                  ),
                ),
              )
            ],
          );
        }));
  }

  _bodyOfTheDragTarget({required GameLettersGameFinalModel? gameLetters}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          border: Border.all(color: AppColorPhonetics.lightYellow2),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GetTheBeads(
            hideTheCircle: gameLetters?.mainQuestion == 1 ? true : false,
            countOfBalls: int.parse("${gameLetters?.letter ?? 0}"),
          ),
          GetTheBeads(
            hideTheCircle: gameLetters?.mainQuestion == 1 ? true : false,
            countOfBalls: int.parse("${gameLetters?.secLetter ?? 0}"),
          ),
        ],
      ),
    );
  }
}
