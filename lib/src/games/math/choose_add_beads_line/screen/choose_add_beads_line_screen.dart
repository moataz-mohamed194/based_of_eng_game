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
import '../../choose_from_obj/widget/card_of_number.dart';
import '../../choose_from_obj/widget/card_of_selected.dart';
import '../manager/choose_add_beads_line_cubit.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/math_weidgt/stick.dart';

class ChooseAddBeadsLineScreen extends StatelessWidget {
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
        child: BlocConsumer<ChooseAddBeadsLineCubit, ChooseAddBeadsLineInitial>(
            listener: (context, state) {},
            builder: (context, gameState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  10.pw,
                  Expanded(
                      child: FittedBox(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _question(
                                  question: gameState.mainQuestion,
                                  tools: gameState.tools),
                              // 10.pw,
                              _question(
                                  question: gameState.subQuestion,
                                  tools: gameState.tools),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CardOfNumber(
                                size: 70.h,
                                number: gameState.mainQuestion?.letter ?? '0',
                              ),
                              // 10.pw,
                              Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                    color: AppColorPhonetics.darkBlueColor,
                                    fontSize: 20.sp,
                                    fontFamily: AppTheme.getFontFamily5(),
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                  ),
                                ),
                              ),
                              CardOfNumber(
                                size: 70.h,
                                number: gameState.subQuestion?.letter ?? '0',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
                  10.pw,
                  Expanded(
                      child: FittedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                            gameState.gameChoices?.length ?? 0,
                            (index) => Column(
                                  children: [
                                    _answer(
                                        gameState: gameState,
                                        question: gameState.gameChoices![index],
                                        mainBloc: context
                                            .read<CurrentGamePhoneticsCubit>(),
                                        bloc: context
                                            .read<ChooseAddBeadsLineCubit>(),
                                        tools: gameState.tools),
                                    5.ph,
                                  ],
                                ))),
                  )),
                  10.pw,
                ],
              );
            }));
  }

  _question({
    required GameLettersGameFinalModel? question,
    required ToolsOfMath tools,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (tools == ToolsOfMath.blocks) ...{
          GetTheBlocks(
            countOfBoxes: int.parse("${question?.letter ?? 0}"),
          )
        } else if (tools == ToolsOfMath.beads) ...{
          GetTheBeads(
            countOfBalls: int.parse("${question?.letter ?? 0}"),
          )
        },
        5.ph,
      ],
    );
  }

  _answer({
    required GameChoicesGameFinalModel? question,
    required ChooseAddBeadsLineInitial gameState,
    required CurrentGamePhoneticsCubit mainBloc,
    required ChooseAddBeadsLineCubit bloc,
    required ToolsOfMath tools,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CardOfSelected(
          onTap: () async {
            if (mainBloc.ableButton()) {
              bool stateOfAnswer = bloc.addAnswer(userChoose: question);
              if (stateOfAnswer == true) {
                await mainBloc
                    .addSuccessAnswer(
                        questions: gameState.allGameData.length,
                        correctAnswers: gameState.correctAnswers + 1)
                    .whenComplete(() {
                  bool isLastQuestion = mainBloc.checkIfIsTheLastQuestionOfGame(
                      queations: gameState.allGameData.length);

                  if (isLastQuestion) {
                    // Future.delayed(const Duration(seconds: 2),
                    //     () async {
                    //   Navigator.of(context).pop();
                    // });
                  } else {
                    Future.delayed(const Duration(seconds: 2), () async {
                      await mainBloc.updateIndexOfCurrentGame();
                      bloc.updateTheCurrentGame(index: mainBloc.state.index);
                    });
                  }
                });
              } else {
                await mainBloc.addWrongAnswer(actionOfWrongAnswer: () async {});
              }
            }
          },
          itsId: question?.id ?? 0,
          isCorrect: (gameState.isCorrect == true) &&
              (question?.isCorrect).toString() == '1',
        ),
        5.pw,
        CardOfNumber(
          size: 60.h,
          number: "${question?.choice ?? '0'}",
        ),
        10.pw,
        if (tools == ToolsOfMath.blocks) ...{
          GetTheBlocks(
            countOfBoxes: int.parse("${question?.choice ?? 0}"),
          ),
        } else if (tools == ToolsOfMath.beads) ...{
          GetTheBeads(
            countOfBalls: int.parse("${question?.choice ?? 0}"),
          )
        },
      ],
    );
  }
}
