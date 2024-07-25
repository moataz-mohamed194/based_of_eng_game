import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Slick extends StatelessWidget {
  final int count;
  final MainAxisAlignment? mainAxisAlignment;
  final Color? isDisable;

  const Slick(
      {super.key, required this.count, this.mainAxisAlignment, this.isDisable});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.center,
      children: List.generate(
          count,
          (index) => Container(
                height: 60.h,
                width: 3.w,
                margin: EdgeInsets.only(right: 3),
                decoration: BoxDecoration(
                    color: isDisable ?? AppColorPhonetics.lightYellowColor2,
                    borderRadius: BorderRadius.circular(6)),
              )),
    );
  }
}
