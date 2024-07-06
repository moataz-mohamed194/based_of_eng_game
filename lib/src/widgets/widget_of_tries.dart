import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../core/assets_images_phonetics.dart';
import '../core/assets_svg_images.dart';
import '../core/phonetics_color.dart';
import '../core/theme_text.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import 'button_start_game.dart';

widgetOfTries(
    {required BuildContext context,
    required CurrentGamePhoneticsState stateOfGame,
    required Function() actionOfDone,
    required Function() backButton}) {
  return Dialog(
    backgroundColor: Colors.transparent,
    child: SizedBox(
      height: 335.h,
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
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(AppImagesPhonetics.popUpBackground))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '"Try again?"',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: AppColorPhonetics.darkBlueColor,
                    fontFamily: AppTheme.getFontFamily5(),
                  ),
                ),
                ReTryButtton(
                    dataFunction: () => actionOfDone(),
                    title: 'Retry',
                    width: 150)
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
          PositionedDirectional(
              top: 10.h,
              // end: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    3,
                    (index) => Image.asset(
                          AppImagesPhonetics.iconEmptyStar2,
                          height: 40.h,
                        )),
              )),
          PositionedDirectional(
            top: 20.h,
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
