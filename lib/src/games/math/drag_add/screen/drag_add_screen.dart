import 'package:based_of_eng_game/src/core/theme_text.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../../src_model/model/game_letters_model.dart';
import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/games_structure/basic_of_game_data.dart';
import '../../../../core/math_weidgt/domino.dart';
import '../../../../core/math_weidgt/get_the_blocks.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../choose_from_obj/widget/card_of_selected.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/math_weidgt/stick.dart';
import '../manager/drag_add_cubit.dart';

class DragAddScreen extends StatelessWidget {
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
        child: BlocConsumer<DragAddCubit, DragAddInitial>(
            listener: (context, state) {},
            builder: (context, gameState) {
              return FittedBox(
                child: Column(
                  children: [
                    5.ph,
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 100.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _question(
                              question: gameState.mainQuestion,
                              tools: gameState.tools,
                              isUp: true),
                          10.ph,
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              _question(
                                  question: gameState.subQuestion,
                                  tools: gameState.tools,
                                  isUp: false),
                              DragTarget<GameChoicesGameFinalModel>(builder: (
                                BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected,
                              ) {
                                return _question(
                                    question: gameState.correctAnswer,
                                    tools: gameState.tools,
                                    isUp: false,
                                    isHide: gameState.isCorrect != true);
                              }, onAcceptWithDetails: (item) async {
                                if (context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .ableButton()) {
                                  bool stateOfAnswer = context
                                      .read<DragAddCubit>()
                                      .addAnswer(userChoose: item.data);
                                  if (stateOfAnswer == true) {
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addSuccessAnswer(
                                            questions:
                                                gameState.allGameData.length,
                                            correctAnswers:
                                                gameState.correctAnswers + 1)
                                        .whenComplete(() {
                                      bool isLastQuestion = context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .checkIfIsTheLastQuestionOfGame(
                                              queations:
                                                  gameState.allGameData.length);

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
                                              .read<CurrentGamePhoneticsCubit>()
                                              .updateIndexOfCurrentGame();
                                          context
                                              .read<DragAddCubit>()
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
                                            actionOfWrongAnswer: () async {});
                                  }
                                }
                              })
                            ],
                          )
                        ],
                      ),
                    ),
                    5.ph,
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              gameState.gameChoices?.length ?? 0,
                              (index) => _answer(
                                  gameState: gameState,
                                  question: gameState.gameChoices![index],
                                  mainBloc:
                                      context.read<CurrentGamePhoneticsCubit>(),
                                  bloc: context.read<DragAddCubit>(),
                                  tools: gameState.tools))),
                    ),
                    5.ph,
                  ],
                ),
              );
            }));
  }

  _question(
      {required GameLettersGameFinalModel? question,
      required ToolsOfMath tools,
      required bool isUp,
      bool? isHide}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isUp == true) ...{
          Container(
            width: 15.w,
            height: 15.w,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImagesMath.woodBgNumber))),
            child: FittedBox(
              child: Text(
                "${question?.letter ?? 0}",
                style: TextStyle(
                  color: int.parse("${question?.letter ?? 0}") % 2 != 0
                      ? AppColorPhonetics.redColor
                      : AppColorPhonetics.darkBlueColor,
                  fontSize: 20.sp,
                  fontFamily: AppTheme.getFontFamily5(),
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
          5.ph,
        },
        if (tools == ToolsOfMath.blocks) ...{
          GetTheBlocks(
              countOfBoxes: int.parse("${question?.letter ?? 0}"),
              isHide: isHide)
        } else if (tools == ToolsOfMath.beads) ...{
          GetTheBeads(
            countOfBalls: int.parse("${question?.letter ?? 0}"),
          )
        },
        if (isUp == false) ...{
          5.ph,
          Container(
            width: 15.w,
            height: 15.w,
            padding: const EdgeInsets.all(5),
            decoration: isHide == true
                ? null
                : const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImagesMath.woodBgNumber))),
            child: FittedBox(
              child: isHide == true
                  ? SizedBox()
                  : Text(
                      "${question?.letter ?? 0}",
                      style: TextStyle(
                        color: int.parse("${question?.letter ?? 0}") % 2 != 0
                            ? AppColorPhonetics.redColor
                            : AppColorPhonetics.darkBlueColor,
                        fontSize: 20.sp,
                        fontFamily: AppTheme.getFontFamily5(),
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
            ),
          ),
        },
      ],
    );
  }

  _answer({
    required GameChoicesGameFinalModel? question,
    required DragAddInitial gameState,
    required CurrentGamePhoneticsCubit mainBloc,
    required DragAddCubit bloc,
    required ToolsOfMath tools,
  }) {
    return Draggable<GameChoicesGameFinalModel>(
      data: question,
      feedback: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (tools == ToolsOfMath.blocks) ...{
            GetTheBlocks(
              countOfBoxes: int.parse("${question?.choice ?? 0}"),
            ),
          } else if (tools == ToolsOfMath.beads) ...{
            GetTheBeads(
              countOfBalls: int.parse("${question?.choice ?? 0}"),
            )
          },
          5.ph,
          Container(
            width: 15.w,
            height: 15.w,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImagesMath.woodBgNumber))),
            child: FittedBox(
              child: Text(
                "${question?.choice ?? 0}",
                style: TextStyle(
                  color: int.parse("${question?.choice ?? 0}") % 2 != 0
                      ? AppColorPhonetics.redColor
                      : AppColorPhonetics.darkBlueColor,
                  fontSize: 20.sp,
                  fontFamily: AppTheme.getFontFamily5(),
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (tools == ToolsOfMath.blocks) ...{
            GetTheBlocks(
              countOfBoxes: int.parse("${question?.choice ?? 0}"),
            ),
          } else if (tools == ToolsOfMath.beads) ...{
            GetTheBeads(
              countOfBalls: int.parse("${question?.choice ?? 0}"),
            )
          },
          5.ph,
          Container(
            width: 15.w,
            height: 15.w,
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImagesMath.woodBgNumber))),
            child: FittedBox(
              child: Text(
                "${question?.choice ?? 0}",
                style: TextStyle(
                  color: int.parse("${question?.choice ?? 0}") % 2 != 0
                      ? AppColorPhonetics.redColor
                      : AppColorPhonetics.darkBlueColor,
                  fontSize: 20.sp,
                  fontFamily: AppTheme.getFontFamily5(),
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
