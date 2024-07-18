import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../core/assets_images_main.dart';
import '../core/assets_images_phonetics.dart';
import '../core/assets_svg_images.dart';
import '../core/phonetics_color.dart';
import '../core/theme_text.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import 'button_start_game.dart';

widgetOfTries(
    {required BuildContext context,
    required CurrentGamePhoneticsState stateOfGame,
    required int countOfStar,
    required Function() actionOfRetry,
    Function()? actionOfDone,
    required Function() backButton}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: SizedBox(
      height: 335,
      width: 100.w,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          PositionedDirectional(
            top: -(40.h),
            end: 0,
            child: SvgPicture.asset(
              AppSvgImages.beeAlert,
              width: 80.w,
              height: 80.h,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            width: 300.w,
            height: 300.h,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImagesPhonetics.popUpBackground))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => countOfStar > (index)
                          ? Image.asset(
                              AppImagesPhonetics.completeStar,
                              height: 40.h,
                            )
                          : Image.asset(
                              AppImagesPhonetics.iconEmptyStar2,
                              height: 40.h,
                            )),
                ),
                // if(countOfStar==0){
                Text(
                  countOfStar == 0
                      ? '"Try again?"'
                      : countOfStar == 3
                          ? '"Excellent! Keep going?"'
                          : countOfStar == 2
                              ? '"Very Good! Keep going?"'
                              : countOfStar == 1
                                  ? '"Good! Keep going?"'
                                  : '',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: AppColorPhonetics.darkBlueColor,
                    fontFamily: AppTheme.getFontFamily5(),
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ReTryButtton(
                        dataFunction: () => actionOfRetry(),
                        title: 'Retry',
                        width: 100),
                    actionOfDone != null
                        ? Row(
                            children: [
                              5.pw,
                              ReTryButtton(
                                  dataFunction: () => actionOfDone(),
                                  title: 'Done',
                                  width: 100),
                            ],
                          )
                        : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
          // Positioned.fill(
          //   child: SvgPicture.asset(
          //     AppSvgImages.popUpBackground,
          //     width: 300.w,
          //     height: 300.h,
          //     fit: BoxFit.contain,
          //   ),
          // ),
          // PositionedDirectional(
          //     top: 30.h,
          //     // end: 0,
          //     child: ),
          PositionedDirectional(
            top: 35.h,
            start: 0,
            child: GestureDetector(
              onTap: () => backButton(),
              child: SvgPicture.asset(
                AppSvgImages.exitButton,
                width: 50.w,
                height: 50.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          // Positioned(
          //   top: 80,
          //   right: 0,
          //   left: 0,
          //   child: ,
          // ),
        ],
      ),
    ),
  );
}
