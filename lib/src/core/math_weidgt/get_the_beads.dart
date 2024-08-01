import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../game_types/assets_images_math.dart';

class GetTheBeads extends StatelessWidget {
  final int countOfBalls;
  final bool? hideTheCircle;

  const GetTheBeads(
      {super.key, required this.countOfBalls, this.hideTheCircle});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: countOfBalls != 0
          ? [
              hideTheCircle != true
                  ? SvgPicture.asset(AppImagesMath.circle)
                  : SizedBox(),
              ...List.generate(
                  countOfBalls,
                  (index) => Row(
                        children: [
                          SvgPicture.asset(
                            selectedBall(
                                countOfBalls: countOfBalls,
                                showTheCircle: hideTheCircle),
                            width: 10.w,
                          ),
                          (hideTheCircle == true) ? 10.pw : 0.pw
                        ],
                      )),
              hideTheCircle != true
                  ? SvgPicture.asset(AppImagesMath.circle)
                  : SizedBox(),
            ]
          : [],
    );
  }

  static String selectedBall(
      {required int countOfBalls, required bool? showTheCircle}) {
    if (showTheCircle == true) {
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
