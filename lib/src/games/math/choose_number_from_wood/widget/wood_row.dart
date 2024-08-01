import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../choose_number_oe/manager/choose_number_oe_cubit.dart';
import '../manager/choose_number_from_wood_cubit.dart';

class WoodRow extends StatelessWidget {
  final ChooseNumberFromWoodInitial gameState;

  const WoodRow({super.key, required this.gameState});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Column(
          children: List.generate(
              gameState.gameChoices?.length ?? 0,
              (index) => GestureDetector(
                    onTap: () async {
                      if (context
                          .read<CurrentGamePhoneticsCubit>()
                          .ableButton()) {
                        bool stateOfAnswer = context
                            .read<ChooseNumberFromWoodCubit>()
                            .addAnswer(
                                userChoose: gameState.gameChoices![index]);
                        if (stateOfAnswer == true) {
                          await context
                              .read<CurrentGamePhoneticsCubit>()
                              .addSuccessAnswer(
                                  questions: gameState.allGameData.length,
                                  correctAnswers: gameState.correctAnswers + 1)
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
                                    .read<ChooseNumberFromWoodCubit>()
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
                              .addWrongAnswer(actionOfWrongAnswer: () async {});
                        }
                      }
                    },
                    child: Container(
                      width: 70.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: index == 0
                                  ? const AssetImage(AppImagesMath.woodBox)
                                  : index ==
                                          ((gameState.gameChoices?.length ??
                                                  0) -
                                              1)
                                      ? const AssetImage(
                                          AppImagesMath.woodBoxLast)
                                      : const AssetImage(
                                          AppImagesMath.woodBoxMid),
                              fit: BoxFit.fill)),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                gameState.gameChoices?[index].choice
                                        ?.split('')
                                        .first ??
                                    '',
                                style: TextStyle(
                                  color: AppColorPhonetics.darkBlueColor,
                                  fontSize: 20.sp,
                                  fontFamily: AppTheme.getFontFamily5(),
                                  fontWeight: FontWeight.w400,
                                  // height: 0,
                                ),
                              ),
                              10.pw,
                              Container(
                                width: 20.w,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            AppImagesMath.woodBoxForNumber),
                                        fit: BoxFit.fill)),
                                alignment: Alignment.center,
                                child: Text(
                                  gameState.gameChoices?[index].choice
                                          ?.split('')
                                          .last ??
                                      '',
                                  style: TextStyle(
                                    color: AppColorPhonetics.darkBlueColor,
                                    fontSize: 20.sp,
                                    fontFamily: AppTheme.getFontFamily5(),
                                    fontWeight: FontWeight.w400,
                                    // height: 0,
                                  ),
                                ),
                              )
                            ],
                          ),
                          if (gameState.isCorrect == true &&
                              gameState.gameChoices?[index].isCorrect == 1) ...{
                            Positioned(
                              child: Container(
                                width: 50.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                  // shape: BoxShape,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50)),
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            )
                          }
                        ],
                      ),
                    ),
                  )),
        ),
      ),
    );
  }
}
