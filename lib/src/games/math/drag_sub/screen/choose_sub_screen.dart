import 'package:based_of_eng_game/src/core/math_weidgt/card_of_blocks.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src_model/export_models.dart';
import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/math_weidgt/card_of_Beads.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/math_weidgt/get_the_blocks.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../choose_from_obj/widget/card_of_number.dart';
import '../../choose_from_obj/widget/card_of_selected.dart';
import '../manager/choose_sub_cubit.dart';

class DragSubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return BlocConsumer<DragSubCubit, DragSubInitial>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Container(
            height: MediaQuery.of(context).size.height -
                (90.h + 50.h + 5 + 20.h), // < 760
            margin: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 20.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: AppColorPhonetics.boarderColor, width: 5)),
            child: FittedBox(
              child: Column(
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _question(
                              showX: true,
                              tools: gameState.tools,
                              question: gameState.mainQuestion),
                          _question(
                              tools: gameState.tools,
                              question: gameState.subQuestion),
                        ],
                      ),
                      DragTarget<GameChoicesGameFinalModel>(builder: (
                        BuildContext context,
                        List<dynamic> accepted,
                        List<dynamic> rejected,
                      ) {
                        return CardOfBlocks(
                          newWidth: MediaQuery.of(context).size.width / 2,
                          number: gameState.isCorrect == true
                              ? (int.parse(
                                      gameState.subQuestion?.letter ?? '0') -
                                  int.parse(
                                      gameState.mainQuestion?.letter ?? '0'))
                              : 0,
                          tools: ToolsOfMath.blocks,
                        );
                      }, onAcceptWithDetails: (item) async {
                        if (context
                            .read<CurrentGamePhoneticsCubit>()
                            .ableButton()) {
                          bool stateOfAnswer = context
                              .read<DragSubCubit>()
                              .addAnswer(userChoose: item.data);
                          if (stateOfAnswer == true) {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addSuccessAnswer(
                                    questions: gameState.allGameData.length,
                                    correctAnswers:
                                        gameState.correctAnswers + 1)
                                .whenComplete(() {
                              bool isLastQuestion = context
                                  .read<CurrentGamePhoneticsCubit>()
                                  .checkIfIsTheLastQuestionOfGame(
                                      queations: gameState.allGameData.length);

                              if (isLastQuestion) {
                                // Future.delayed(const Duration(seconds: 2),
                                //     () async {
                                //   Navigator.of(context).pop();
                                // });
                              } else {
                                Future.delayed(const Duration(seconds: 2),
                                    () async {
                                  await context
                                      .read<CurrentGamePhoneticsCubit>()
                                      .updateIndexOfCurrentGame();
                                  context
                                      .read<DragSubCubit>()
                                      .updateTheCurrentGame(
                                          index: context
                                              .read<CurrentGamePhoneticsCubit>()
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
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: List.generate(
                          gameState.gameChoices?.length ?? 0,
                          (index) => _answer(
                                answer: gameState.gameChoices![index],
                                tools: gameState.tools,
                                gameState: gameState,
                                mainBloc:
                                    context.read<CurrentGamePhoneticsCubit>(),
                                bloc: context.read<DragSubCubit>(),
                              )),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _question(
      {required GameLettersGameFinalModel? question,
      required ToolsOfMath tools,
      bool? showX}) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 20.w,
              height: 20.w,
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
            if (tools == ToolsOfMath.blocks) ...{
              // Stack(
              //   children: [
              GetTheBlocks(
                countOfBoxes: int.parse("${question?.letter ?? 0}"),
              ),

              //   ],
              // )
            } else if (tools == ToolsOfMath.beads) ...{
              GetTheBeads(
                countOfBalls: int.parse("${question?.letter ?? 0}"),
              )
            }
          ],
        ),
        if (showX == true) ...{
          Image.asset(
            AppImagesMath.sub,
            height: 50.h,
          )
        }
      ],
    );
  }

  _answer({
    required GameChoicesGameFinalModel? answer,
    required ToolsOfMath tools,
    required DragSubInitial gameState,
    required CurrentGamePhoneticsCubit mainBloc,
    required DragSubCubit bloc,
  }) {
    return Draggable<GameChoicesGameFinalModel>(
        data: answer,
        feedback: (tools == ToolsOfMath.blocks)
            ? GetTheBlocks(
                countOfBoxes: int.parse("${answer?.choice ?? 0}"),
              )
            : SizedBox(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            if (tools == ToolsOfMath.blocks) ...{
              GetTheBlocks(
                countOfBoxes: int.parse("${answer?.choice ?? 0}"),
              )
            } else if (tools == ToolsOfMath.beads) ...{
              GetTheBeads(
                countOfBalls: int.parse("${answer?.choice ?? 0}"),
              )
            },
            5.ph,
            Container(
              width: 20.w,
              height: 20.w,
              padding: const EdgeInsets.all(5),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImagesMath.woodBgNumber))),
              child: FittedBox(
                child: Text(
                  "${answer?.choice ?? 0}",
                  style: TextStyle(
                    color: int.parse("${answer?.choice ?? 0}") % 2 != 0
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
        ));
  }
}
