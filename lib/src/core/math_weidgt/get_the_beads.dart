import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../game_types/assets_images_math.dart';

class GetTheBeads extends StatelessWidget {
  final int countOfBalls;
  final bool? showTheCircle;

  const GetTheBeads(
      {super.key, required this.countOfBalls, this.showTheCircle});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: countOfBalls != 0
          ? [
              showTheCircle == true || countOfBalls == 10
                  ? SvgPicture.asset(AppImagesMath.circle)
                  : SizedBox(),
              ...List.generate(
                  countOfBalls,
                  (index) => SvgPicture.asset(
                        selectedBall(
                            countOfBalls: countOfBalls,
                            showTheCircle: showTheCircle),
                        width: 10.w,
                      )),
              showTheCircle == true || countOfBalls == 10
                  ? SvgPicture.asset(AppImagesMath.circle)
                  : SizedBox(),
            ]
          : [],
    );
  }

  static String selectedBall(
      {required int countOfBalls, required bool? showTheCircle}) {
    if (showTheCircle == false) {
      return AppImagesMath.ball10;
    }
    switch (countOfBalls) {
      case 1:
        return AppImagesMath.ball1;
      case 2:
        return AppImagesMath.ball2;
      case 3:
        return AppImagesMath.ball3;
      case 4:
        return AppImagesMath.ball4;
      case 5:
        return AppImagesMath.ball5;
      case 6:
        return AppImagesMath.ball6;
      case 7:
        return AppImagesMath.ball7;
      case 8:
        return AppImagesMath.ball8;
      case 9:
        return AppImagesMath.ball9;
      default:
        return AppImagesMath.ball10;
    }
  }
}
