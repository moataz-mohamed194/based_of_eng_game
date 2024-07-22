import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';

class CardOfNumber extends StatelessWidget {
  final String number;

  const CardOfNumber({super.key, required this.number});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 99.h,
      height: 99.h,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
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
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 2.03, color: Color(0xFFA1CBEA)),
            borderRadius: BorderRadius.circular(16.28),
          ),
        ),
        child: Text(
          number,
          style: TextStyle(
            color: AppColorPhonetics.darkBlueColor,
            fontSize: 30.sp,
            fontFamily: AppTheme.getFontFamily5(),
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ),
    );
  }
}
