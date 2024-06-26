import 'package:based_of_eng_game/src/core/theme_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/phonetics_color.dart';

class ItemCardWidget extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final void Function()? onTap;
  final String body;
  final int index;
  final int id;

  const ItemCardWidget(
      {super.key,
      required this.maxWidth,
      required this.maxHeight,
      required this.body,
      this.onTap,
      required this.index,
      required this.id});
  @override
  Widget build(BuildContext context) {
    return Draggable<String>(
      // Data is the value this Draggable stores.
      data: body,

      feedback: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: maxHeight+20,
          width: maxWidth+20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColorPhonetics.darkBlueColor,
          ),
          alignment: Alignment.center,
          child: Center(
            child: Text(
              body,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 0.05.sw,
                  fontFamily: AppTheme.getFontFamily5(),
                  decoration: TextDecoration.none),
              textAlign: TextAlign.center,
            ),
          ),

        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: maxHeight,
          width: maxWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: AppColorPhonetics.darkBlueColor,
          ),
          alignment: Alignment.center,
          child: Center(
            child: Text(
              body,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 0.025.sw,
                  fontFamily: AppTheme.getFontFamily5(),
                  fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,

            ),
          ),
        ),
      ),
    );
  }
}
