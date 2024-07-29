import 'package:flutter/material.dart';
import '../core/phonetics_color.dart';
import '../core/theme_text.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final bool isDisabled;
  final double? fontSize;
  final double? strokeWidth;
  final Color? color;
  final double? height;
  final Color? strokeColor;
  const StrokeText(
      {super.key,
      required this.text,
      required this.isDisabled,
      this.strokeWidth,
      this.fontSize,
      this.height,
      this.color,
      this.strokeColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize ?? 39,
            fontFamily: AppTheme.getFontFamily5(),
            foreground: Paint()
              ..color = color != null
                  ? color!
                  : isDisabled
                      ? Colors.white.withOpacity(0.5)
                      : Colors.white,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: AppTheme.getFontFamily5(),
            fontSize: fontSize ?? 39,
            foreground: Paint()
              ..strokeWidth = strokeWidth ?? 2
              ..color = strokeColor != null
                  ? strokeColor!
                  : isDisabled
                      ? AppColorPhonetics.lightGreyColor4.withOpacity(0.5)
                      : AppColorPhonetics.darkBlueColor
              ..style = PaintingStyle.stroke,
            height: height
          ),
        ),
      ],
    );
  }
}
