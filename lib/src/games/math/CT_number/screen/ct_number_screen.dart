import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/math_weidgt/open_key_board.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../choose_from_obj/widget/card_of_number.dart';
import '../manager/ct_number_cubit.dart';
import '../widget/card_of_typing_number.dart';

class CtNumberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CtNumberCubit, CtNumberInitial>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            // height: MediaQuery.of(context).size.height -,
            //     (90.h + 50.h + 5 + 20.h), // < 760
            margin: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 0.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: AppColorPhonetics.darkBlueColor, width: 5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (gameState.showLineOfNumbers == true) ...{
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Image.asset(AppImagesMath.lineOfNumbers),
                  ),
                  4.ph,
                },
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CardOfNumber(
                      number: gameState.mainLetter?.letter ?? '',
                    ),
                    Text(
                      gameState.tools == SymbolsMath.sum ? "+" : "-",
                      style: TextStyle(
                        color: AppColorPhonetics.darkBlueColor,
                        fontSize: 30.sp,
                        fontFamily: AppTheme.getFontFamily5(),
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    CardOfNumber(
                      number: gameState.subLetter?.letter ?? '',
                    ),
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
                    CardOfTypingNumber(
                      number: gameState.currentAnswer ?? '',
                      // number: '0',
                      onTap: () => (context
                              .read<CurrentGamePhoneticsCubit>()
                              .ableButton())
                          ? openKeyboard(
                              context: context,
                              action: (value) async {
                                if (context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .ableButton()) {
                                  bool stateOfAnswer = context
                                      .read<CtNumberCubit>()
                                      .addAnswer(userChoose: value ?? '');
                                  Navigator.of(context).pop();
                                  if (stateOfAnswer == true) {
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addSuccessAnswer(
                                            questions:
                                                gameState.allGameData.length,
                                            correctAnswers: ((gameState
                                                        .countOfCorrectAnswers ??
                                                    0) +
                                                1))
                                        .whenComplete(() {
                                      bool isLastQuestion = context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .checkIfIsTheLastQuestionOfGame(
                                              queations:
                                                  gameState.allGameData.length);
                                      print('isLastQuestion:$isLastQuestion');
                                      if (isLastQuestion != true) {
                                        Future.delayed(
                                            const Duration(seconds: 2),
                                            () async {
                                          await context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .updateIndexOfCurrentGame();
                                          context
                                              .read<CtNumberCubit>()
                                              .updateTheCurrentGame(
                                                  newIndex: context
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
                              },
                            )
                          : null,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }
}
