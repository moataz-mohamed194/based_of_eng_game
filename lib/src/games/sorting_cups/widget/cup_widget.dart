import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/assets_images_phonetics.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';

class CupWidget extends StatelessWidget {
  final String image;

  const CupWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 11),
      height: (MediaQuery.of(context).size.height - (50)) / 4,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            AppImagesPhonetics.sortingCup,
            width: MediaQuery.of(context).size.width / 12,
            fit: BoxFit.fill,
          ),
          Text(
            image,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColorPhonetics.darkBorderColor,
                fontFamily: AppTheme.getFontFamily5()),
          ),
        ],
      ),
    );
  }
}
