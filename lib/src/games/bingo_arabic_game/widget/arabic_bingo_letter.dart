import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/phonetics_color.dart';
import '../../../widgets/stroke_text.dart';

class ArabicBingoLetter extends StatelessWidget {
  final double maxWidth;
  final double maxHeight;
  final void Function()? onTap;
  final String body;
  final bool? isCorrect;
  final int index;

  const ArabicBingoLetter(
      {super.key,
      required this.maxWidth,
      this.isCorrect,
      required this.maxHeight,
      required this.body,
      this.onTap,
      required this.index});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: maxWidth / 3,
      height: maxHeight / 3,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // width: maxWidth / 3,
          // height: maxHeight / 3,
          // padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 36),
          decoration: BoxDecoration(
            color: isCorrect == false
                ? Colors.white
                : AppColorPhonetics.darkBlueColor,
            // shape: RoundedRectangleBorder(
            //   side: BorderSide(width: 2, Color(0xFF91D4F0)),
            // ),
            border: Border(
              right: (index == 0 || index == 3 || index == 6)
                  ? const BorderSide(width: 2, color: Color(0xFF91D4F0))
                  : const BorderSide(color: Colors.white),
              left: (index == 2 || index == 5 || index == 8)
                  ? const BorderSide(width: 2, color: Color(0xFF91D4F0))
                  : const BorderSide(color: Colors.white),
              top: (index == 6 || index == 7 || index == 8)
                  ? const BorderSide(width: 2, color: Color(0xFF91D4F0))
                  : const BorderSide(color: Colors.white),
              bottom: (index == 0 || index == 1 || index == 2)
                  ? const BorderSide(width: 2, color: Color(0xFF91D4F0))
                  : const BorderSide(color: Colors.white),
            ),
          ),
          alignment: Alignment.center,
          child: StrokeText(
            text: body,
            isDisabled: false,
            color: isCorrect == true
                ? Colors.white
                : AppColorPhonetics.darkBlueColor,
            strokeColor: isCorrect == true
                ? Colors.white
                : AppColorPhonetics.darkBlueColor,
            fontSize: MediaQuery.of(context).size.height < 760 ? 20.sp : 40.sp,
          ),
        ),
      ),
    );
  }
}
