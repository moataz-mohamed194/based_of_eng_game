import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../manager/ct_number_cubit.dart';

class CardOfTypingNumber extends StatelessWidget {
  final String number;
  final double? size;
  final void Function()? onTap;
  CardOfTypingNumber({super.key, this.size, required this.number, this.onTap});

//   @override
//   State<StatefulWidget> createState() {
//     return _CardOfTypingNumber();
//   }
// }
//
// class _CardOfTypingNumber extends State<CardOfTypingNumber> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 99.h,
      height: size ?? 99.h,
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
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(5),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 2.03, color: Color(0xFFA1CBEA)),
                borderRadius: BorderRadius.circular(16.28),
              ),
            ),
            child: Center(
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
            )),
      ),
    );
  }
}
