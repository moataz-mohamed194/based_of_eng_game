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

// widgetOfTries(
//     {required BuildContext context,
//     required CurrentGamePhoneticsState stateOfGame,
//     required int countOfStar,
//     required Function() actionOfRetry,
//     Function()? actionOfDone,
//     required Function() backButton}) {
//   return Dialog(
//     backgroundColor: Colors.transparent,
//     child: SizedBox(
//       height: 300.h,
//       width: 230.w,
//       child: Stack(
//         clipBehavior: Clip.none,
//         alignment: Alignment.center,
//         children: [
//           _buildBackground(),
//           _buildExitButton(backButton),
//           Positioned(
//               top: 70.h,
//               right: 0,
//               left: 0,
//               child: Center(
//                 child: FittedBox(
//                   child: SizedBox(
//                     width: MediaQuery.of(context).size.width / 1.3, //300.w,
//                     height: MediaQuery.of(context).size.height / 2.5, //300.w,
//                     // height: 300.h,
//                     // decoration: const BoxDecoration(
//                     //     image: DecorationImage(
//                     //         image: AssetImage(AppImagesPhonetics.popUpBackground))),
//                     child: Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.max,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: List.generate(
//                                 3,
//                                 (index) => countOfStar > (index)
//                                     ? Image.asset(
//                                         AppImagesPhonetics.completeStar,
//                                         height: 40.h,
//                                       )
//                                     : Image.asset(
//                                         AppImagesPhonetics.iconEmptyStar2,
//                                         height: 40.h,
//                                       )),
//                           ),
//                           // if(countOfStar==0){
//                           Text(
//                             countOfStar == 0
//                                 ? '"Try again?"'
//                                 : countOfStar == 3
//                                     ? '"Excellent! Keep going?"'
//                                     : countOfStar == 2
//                                         ? '"Very Good! Keep going?"'
//                                         : countOfStar == 1
//                                             ? '"Good! Keep going?"'
//                                             : '',
//                             style: TextStyle(
//                               fontSize: 18.0,
//                               color: AppColorPhonetics.darkBlueColor,
//                               fontFamily: AppTheme.getFontFamily5(),
//                             ),
//                           ),
//                           Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               ReTryButtton(
//                                   dataFunction: () => actionOfRetry(),
//                                   title: 'Retry',
//                                   width: 100),
//                               actionOfDone != null
//                                   ? Row(
//                                       children: [
//                                         5.pw,
//                                         ReTryButtton(
//                                             dataFunction: () => actionOfDone(),
//                                             title: 'Done',
//                                             width: 100),
//                                       ],
//                                     )
//                                   : const SizedBox(),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               )),
//         ],
//       ),
//     ),
//   );
// }

// PositionedDirectional _buildExitButton(void Function() action) {
//   return PositionedDirectional(
//     top: 60.h,
//     start: 55.w,
//     child: GestureDetector(
//       onTap: () => action.call(),
//       child: SvgPicture.asset(
//         AppSvgImages.exitButton,
//         width: 50.w,
//         height: 50.h,
//         fit: BoxFit.contain,
//       ),
//     ),
//   );
// }

// Positioned _buildBackground() {
//   return Positioned.fill(
//     child: SvgPicture.asset(
//       AppSvgImages.popUpBackgroundLandscape,
//       width: 180.w,
//       height: 200.h,
//       fit: BoxFit.contain,
//     ),
//   );
// }

widgetOfTries(
    {required BuildContext context,
    required CurrentGamePhoneticsState stateOfGame,
    required int countOfStar,
    required Function() actionOfRetry,
    Function()? actionOfDone,
    required Function() backButton}) {
  return _CustomDialogLandscape(
    countOfStars: countOfStar,
    onRetryPressed: actionOfRetry,
    onDonePressed: actionOfDone,
  );
}

enum StarsEnum { zero, one, two, three }

extension MessageExtension on StarsEnum {
  String get message {
    switch (this) {
      case StarsEnum.one:
        return "Good! Keep going?";
      case StarsEnum.two:
        return "Very Good! Keep going?";
      case StarsEnum.three:
        return "Excellent! Keep going?";
      case StarsEnum.zero:
        return "Try again?";
    }
  }

  int get value {
    switch (this) {
      case StarsEnum.one:
        return 1;
      case StarsEnum.two:
        return 2;
      case StarsEnum.three:
        return 3;
      case StarsEnum.zero:
        return 0;
    }
  }
}

class _CustomDialogLandscape extends StatelessWidget {
  final int countOfStars;
  final void Function() onRetryPressed;
  final void Function()? onDonePressed;

  _CustomDialogLandscape({
    required this.countOfStars,
    required this.onRetryPressed,
    this.onDonePressed,
  });
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        height: 300.h,
        width: 230.w,
        child: Stack(
          children: [
            _buildBackground(),
            _buildExitButton(context),
            _buildContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).size.height > 750 ? 65.h : 40.h,
      right: 0,
      left: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStars(context),
          MediaQuery.of(context).size.height > 750 ? 30.ph : 15.ph,
          _buildText(),
          MediaQuery.of(context).size.height > 750 ? 25.ph : 5.ph,
          if (StarsEnum.values
                  .firstWhere((type) => type.value == countOfStars)
                  .value ==
              0)
            _buildButton()
          else
            _buildRowButtons()
        ],
      ),
    );
  }

  Widget _buildButton() {
    return SizedBox(
      width: 90.w,
      child: ReTryButtton(
        leading: SvgPicture.asset(AppSvgImages.retryIcon),
        dataFunction: onRetryPressed,
        title: 'Retry',
        width: 60.w,
      ),
    );
  }

  Widget _buildRowButtons() {
    return SizedBox(
      width: 80.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReTryButtton(
            leading: SvgPicture.asset(AppSvgImages.retryIcon),
            dataFunction: onRetryPressed,
            title: '',
            width: 20.w,
          ),
          5.pw,
          ReTryButtton(
            dataFunction: onDonePressed ?? () {},
            title: 'Done',
            width: 50.w,
          ),
        ],
      ),
    );
  }

  Widget _buildText() {
    return SizedBox(
      width: 90.w,
      child: FittedBox(
        child: Text(
          StarsEnum.values
              .firstWhere((type) => type.value == countOfStars)
              .message,
          style: TextStyle(
            fontSize: 12.sp,
            color: Color(0xFF004279),
            fontFamily: AppTheme.getFontFamily5(),
          ),
        ),
      ),
    );
  }

  Row _buildStars(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          3,
          (index) => (double.parse(
                      "${StarsEnum.values.firstWhere((type) => type.value == countOfStars).value}") >
                  (index))
              ? Padding(
                  padding: EdgeInsets.only(bottom: index == 1 ? 10 : 0),
                  child: SvgPicture.asset(
                    AppSvgImages.iconCompleteStar,
                    height:
                        MediaQuery.of(context).size.height > 750 ? 50.h : 40.h,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(bottom: index == 1 ? 10 : 0),
                  child: Image.asset(
                    AppImagesMain.iconEmptyStar,
                    height:
                        MediaQuery.of(context).size.height > 750 ? 50.h : 40.h,
                  ),
                )),
    );
  }

  PositionedDirectional _buildExitButton(BuildContext context) {
    return PositionedDirectional(
      top: MediaQuery.of(context).size.height > 750 ? 100.h : 60.h,
      start: 55.w,
      child: GestureDetector(
        onTap: Navigator.of(context).pop,
        child: SvgPicture.asset(
          AppSvgImages.exitButton,
          width: MediaQuery.of(context).size.height > 750 ? 50.w : 40.w,
          height: MediaQuery.of(context).size.height > 750 ? 50.h : 40.h,
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
}
