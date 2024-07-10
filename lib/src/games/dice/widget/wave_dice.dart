import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/phonetics_color.dart';

class WaveDice extends StatelessWidget {
  final String? currentAlphabet;
  final Widget? body;
  final double? width;
  final double? height;
  double widthAndHeight = 120.h;

  WaveDice(
      {super.key, this.currentAlphabet, this.body, this.width, this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.green,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(11),
          color: AppColorPhonetics.darkBorderColor,
          // gradient: const LinearGradient(
          //   begin: Alignment(1.00, 0.00),
          //   end: Alignment(-1, 0),
          //   colors: [AppColor.orangeColor, AppColor.lightOrangeColor2],
          // ),
          border: Border.all(width: 3, color: const Color(0xFFFFFBF8))),
      alignment: Alignment.center,
      width: width ?? 120.h,
      height: height ?? 120.h,
      child: body ??
          Text(
            (currentAlphabet?.toLowerCase() ?? ''),
            style: TextStyle(fontSize: 20.sp, color: Colors.white),
          ),
    );
  }
}
