import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';

class DragTargetWidget extends StatelessWidget {
  final String title;
  const DragTargetWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      width: 30.w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: AppColorPhonetics.dragContainerColor,
          border: Border.all(width: 2, color: AppColorPhonetics.strokeColor)),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: AppColorPhonetics.darkBlueColor,
              fontSize: 0.04.sw,
              fontFamily: AppTheme.getFontFamily5(),
              fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
