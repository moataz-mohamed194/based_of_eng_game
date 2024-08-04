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
      height: 300.h,
      width: 230.w,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          _buildBackground(),
          _buildExitButton(backButton),
          Positioned(
              top: 0.h,
              right: 0,
              left: 0,
              child: SizedBox(
                width: MediaQuery.of(context).size.width, //300.w,
                height: MediaQuery.of(context).size.height / 1.3, //300.w,
                // height: 300.h,
                // decoration: const BoxDecoration(
                //     image: DecorationImage(
                //         image: AssetImage(AppImagesPhonetics.popUpBackground))),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
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
              )),
        ],
      ),
    ),
  );
}

PositionedDirectional _buildExitButton(void Function() action) {
  return PositionedDirectional(
    top: 60.h,
    start: 55.w,
    child: GestureDetector(
      onTap: () => action.call(),
      child: SvgPicture.asset(
        AppSvgImages.exitButton,
        width: 50.w,
        height: 50.h,
        fit: BoxFit.contain,
      ),
    ),
  );
}

Positioned _buildBackground() {
  return Positioned.fill(
    child: SvgPicture.asset(
      AppSvgImages.popUpBackgroundLandscape,
      width: 180.w,
      height: 200.h,
      fit: BoxFit.contain,
    ),
  );
}
