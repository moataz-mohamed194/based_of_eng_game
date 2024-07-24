import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/assets_images_phonetics.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';

class CardOfSelected extends StatelessWidget {
  final bool? isCorrect;
  final num itsId;
  final void Function()? onTap;

  const CardOfSelected(
      {super.key, required this.onTap, required this.itsId, this.isCorrect});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50.h,
        height: 50.h,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.28),
          ),
          shadows: const [
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
          margin: const EdgeInsets.all(5),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2.03, color: Color(0xFFA1CBEA)),
              borderRadius: BorderRadius.circular(10.28),
            ),
          ),
          child: isCorrect == true
              ? Image.asset(
                  AppImagesPhonetics.iconSelectedCheckBox,
                  height: 50.h,
                  width: 50.h,
                )
              : const SizedBox(),
        ),
      ),
    );
  }
}
