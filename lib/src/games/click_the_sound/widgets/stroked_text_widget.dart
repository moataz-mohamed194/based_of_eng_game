import 'package:flutter/material.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';

class StrokedText extends StatelessWidget {
  final String text;
  final bool isDisabled;
  final double? fontSize;
  final double? strokeWidth;
  final bool? hasShadows;
  final Color backgroundColor;
  final Color strokeColor;
  const StrokedText({
    super.key,
    required this.text,
    required this.isDisabled,
    this.fontSize,
    this.strokeWidth,
    this.hasShadows,
    this.backgroundColor = AppColorPhonetics.lightGreyColor4,
    this.strokeColor = AppColorPhonetics.darkBlueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            shadows: hasShadows == true
                ? [
                    Shadow(
                      color: AppColorPhonetics.darkBlueColor6.withOpacity(0.5),
                      blurRadius: 0.0,
                      offset: const Offset(2.0, 2.0),
                    ),
                    Shadow(
                      color: AppColorPhonetics.darkBlueColor6.withOpacity(0.5),
                      blurRadius: 0.0,
                      offset: const Offset(-2.0, -3.0),
                    ),
                  ]
                : null,
            fontSize: fontSize ?? 39,
            fontWeight: FontWeight.w900,
            fontFamily: AppTheme.getFontFamily5(),
            foreground: Paint()..color = backgroundColor,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontFamily: AppTheme.getFontFamily5(),
            fontSize: fontSize ?? 39,
            foreground: Paint()
              ..strokeWidth = strokeWidth ?? 1.7
              ..color = strokeColor
              ..style = PaintingStyle.stroke,
          ),
        ),
      ],
    );
  }
}
