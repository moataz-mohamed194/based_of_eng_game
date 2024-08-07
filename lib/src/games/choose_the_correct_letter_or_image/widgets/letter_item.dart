import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/core/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LetterItem extends StatelessWidget {
  const LetterItem({
    super.key,
    required this.letter,
    this.isCorrect = false,
  });

  final String letter;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    final double circleDiameter =
        MediaQuery.of(context).size.width * 0.12; // Adjust this value as needed
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Container(
        height: circleDiameter,
        width: circleDiameter,
        decoration: BoxDecoration(
          color: isCorrect
              ? AppColorPhonetics.greenColor
              : AppColorPhonetics.white,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            letter,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                fontSize: 30.spMax,
                fontWeight: FontWeight.w700,
                color: isCorrect
                    ? AppColorPhonetics.white
                    : AppColorPhonetics.darkBorderColor,
                fontFamily: AppTheme.getFontFamily5()),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
