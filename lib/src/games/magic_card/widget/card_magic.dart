import 'package:flutter/material.dart';

import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';

class CardMagic extends StatelessWidget {
  final String text;

  const CardMagic({super.key, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 66,
      padding: const EdgeInsets.only(left: 9, right: 10),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 4, color: AppColorPhonetics.darkBorderColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: FittedBox(
        child: Text(
          text,
          style: TextStyle(
            color: AppColorPhonetics.darkBorderColor,
            fontSize: 25,
            fontFamily: AppTheme.getFontFamily5(),
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
      ),
    );
  }
}
