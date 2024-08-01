import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/math_weidgt/card_of_blocks.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/math_weidgt/get_the_blocks.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../DDT_change/widget/card_of_number_of_ddt.dart';
import '../../choose_from_obj/widget/card_of_number.dart';
import '../manager/add_rod_number_line_cubit.dart';

class AddRodNumberLineScreen extends StatelessWidget {
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
        child: BlocConsumer<AddRodNumberLineCubit, AddRodNumberLineInitial>(
            listener: (context, state) {},
            builder: (context, gameState) {
              return FittedBox(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 4,
                              child: Column(
                                children: [
                                  FittedBox(
                                    // width: 75.h * (gameState.gameLetters?.length ?? 0),
                                    child: Row(
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: List.generate(
                                            gameState
                                                    .finalGameLetters?.length ??
                                                0,
                                            (index) => (gameState
                                                        .finalGameLetters?[
                                                            index]
                                                        .id ==
                                                    null)
                                                ? SizedBox()
                                                : GetTheBlocks(
                                                    countOfBoxes: int.parse(
                                                        "${gameState.finalGameLetters?[index].letter}"),
                                                  ))),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SizedBox(
                                        width: 75.h *
                                                (gameState.finalGameLetters
                                                        ?.length ??
                                                    0) +
                                            40.w,
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            mainAxisSize: MainAxisSize.max,
                                            children: List.generate(
                                                gameState.finalGameLetters
                                                        ?.length ??
                                                    0,
                                                (index) => Container(
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          // if (index != 0) ...{
                                                          //
                                                          // },
                                                          if (gameState
                                                                  .finalGameLetters?[
                                                                      index]
                                                                  .id !=
                                                              null) ...{
                                                            CardOfNumberDDt(
                                                              number: gameState
                                                                      .finalGameLetters?[
                                                                          index]
                                                                      .letter ??
                                                                  '0',
                                                            ),
                                                          } else ...{
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              height: 99.h,
                                                              child: Text(
                                                                gameState
                                                                        .finalGameLetters?[
                                                                            index]
                                                                        .letter ??
                                                                    '0',
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColorPhonetics
                                                                      .darkBlueColor,
                                                                  fontSize:
                                                                      25.sp,
                                                                  fontFamily:
                                                                      AppTheme
                                                                          .getFontFamily5(),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                ),
                                                              ),
                                                            )
                                                          }
                                                        ],
                                                      ),
                                                    ))),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "=",
                                style: TextStyle(
                                  color: AppColorPhonetics.darkBlueColor,
                                  fontSize: 30.sp,
                                  fontFamily: AppTheme.getFontFamily5(),
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              CardOfNumberDDt(
                                showNumber: false,
                                number:
                                    "${gameState.correctAnswer?.choice ?? 0}",
                              )
                            ],
                          ))
                        ],
                      ),
                      10.ph,
                      FittedBox(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: List.generate(
                                  gameState.gameChoices?.length ?? 0,
                                  (index) => GestureDetector(
                                      onTap: () async {
                                        if (context
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .ableButton() &&
                                            gameState.isCorrect != true) {
                                          bool stateOfAnswer = context
                                              .read<AddRodNumberLineCubit>()
                                              .addAnswer(
                                                  userChoose: gameState
                                                      .gameChoices?[index]);
                                          if (stateOfAnswer == true) {
                                            await context
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .addSuccessAnswer(
                                                    questions: gameState
                                                        .allGameData.length,
                                                    correctAnswers: gameState
                                                            .correctAnswers +
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
                                                      .read<
                                                          AddRodNumberLineCubit>()
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
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .addWrongAnswer(
                                                    actionOfWrongAnswer:
                                                        () async {});
                                          }
                                        }
                                      },
                                      child: CardOfNumberDDt(
                                          width: 99.h,
                                          height: 99.h,
                                          number: gameState
                                                  .gameChoices?[index].choice ??
                                              '0',
                                          isCorrect:
                                              gameState.isCorrect == true &&
                                                  gameState.gameChoices?[index]
                                                          .isCorrect ==
                                                      1)))),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}