import 'package:flutter/material.dart';
import '../core/phonetics_color.dart';
import '../core/theme_text.dart';

class ReTryButtton extends StatelessWidget {
  final void Function() dataFunction;
  final String title;
  final double width;
  final Widget? leading;

  // final bool? disableAnimation;
  // final bool? playButton;
  final double? fontSize;
  // final bool? applyFontFamily5;
  const ReTryButtton(
      {super.key,
      // this.disableAnimation,
      required this.dataFunction,
      required this.title,
      // this.playButton,
      this.fontSize,
      this.leading,
      // this.applyFontFamily5,
      required this.width});

  static const double _shadowHeight = 4;

  @override
  Widget build(BuildContext context) {
    const double height = 50 - _shadowHeight;

    return SizedBox(
        // width: MediaQuery.of(context).size.width - 100,
        child: GestureDetector(
      onTap: dataFunction,
      child: SizedBox(
        height: height + _shadowHeight,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: height,
                width: width,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColorPhonetics.darkBlueColor.withOpacity(.5),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: AppColorPhonetics.darkBlueColor,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (leading != null) ...[
                    const SizedBox(width: 8),
                    leading!,
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: fontSize ?? 24,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontFamily: AppTheme.getFontFamily5(),
                          height: 0,
                          letterSpacing: 0.50,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
