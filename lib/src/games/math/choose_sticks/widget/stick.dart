import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Slick extends StatelessWidget {
  final int count;

  const Slick({super.key, required this.count});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(
          count,
          (index) => Container(
                height: 60.h,
                width: 3.w,
                margin: EdgeInsets.only(right: 3),
                decoration: BoxDecoration(
                    color: AppColorPhonetics.lightYellowColor2,
                    borderRadius: BorderRadius.circular(6)),
              )),
    );
  }
}
