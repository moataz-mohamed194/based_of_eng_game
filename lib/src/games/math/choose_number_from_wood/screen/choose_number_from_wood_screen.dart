import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../manager/choose_number_from_wood_cubit.dart';
import '../widget/wood_row.dart';

class ChooseNumberFromWoodScreen extends StatelessWidget {
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
        child: BlocConsumer<ChooseNumberFromWoodCubit,
                ChooseNumberFromWoodInitial>(
            listener: (context, state) {},
            builder: (context, gameState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          gameState.gameLetters?.length ?? 0,
                          (index) => Column(
                                children: [
                                  GetTheBeads(
                                    countOfBalls: int.parse(
                                        gameState.gameLetters?[index].letter ??
                                            '0'),
                                    hideTheCircle: gameState.gameLetters?[index]
                                                .mainQuestion ==
                                            1
                                        ? true
                                        : false,
                                  ),
                                  10.ph,
                                ],
                              ))),
                  WoodRow(
                    gameState: gameState,
                  )
                ],
              );
            }));
  }
}
