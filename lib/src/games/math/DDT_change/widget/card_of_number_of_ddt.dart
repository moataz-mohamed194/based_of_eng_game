import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';

class CardOfNumberDDt extends StatelessWidget {
  final String number;
  final double? width;
  final double? height;
  final bool? isCorrect;

  const CardOfNumberDDt(
      {super.key,
      required this.number,
      this.height,
      this.width,
      this.isCorrect});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 75.h,
      height: height ?? 99.h,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: isCorrect == true ? AppColorPhonetics.greenColor2 : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.28),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 28.48,
            offset: Offset(0, 8.14),
            spreadRadius: 0,
          )
        ],
      ),
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(5),
        decoration: ShapeDecoration(
          color:
              isCorrect == true ? AppColorPhonetics.greenColor2 : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2.03, color: Color(0xFFA1CBEA)),
            borderRadius: BorderRadius.circular(16.28),
          ),
        ),
        child: FittedBox(
          child: Text(
            number,
            style: TextStyle(
              color: isCorrect == true
                  ? Colors.white
                  : AppColorPhonetics.darkBlueColor,
              fontSize: 25.sp,
              fontFamily: AppTheme.getFontFamily5(),
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }
}
