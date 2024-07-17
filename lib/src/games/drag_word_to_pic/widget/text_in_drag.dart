import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';

class TextInDrag extends StatelessWidget {
  final GameImagesGameFinalModel image;
  final bool isHide;

  const TextInDrag({super.key, required this.image, required this.isHide});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      color: isHide?Colors.grey.withOpacity(.2):AppColorPhonetics.lightBlueColor,
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Text(
        image.word ?? '',
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isHide?Colors.grey.withOpacity(.8):AppColorPhonetics.darkBorderColor,
            fontFamily: AppTheme.getFontFamily5()),
        textAlign: TextAlign.center,
      ),
    );
  }
}
