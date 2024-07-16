import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../widgets/stroke_text.dart';

class ItemCardWordWidget extends StatelessWidget {
  final void Function()? onTap;
  final GameImagesGameFinalModel body;
  final int index;
  final GameImagesGameFinalModel data;

  const ItemCardWordWidget(
      {super.key,
      required this.body,
      this.onTap,
      required this.index,
      required this.data});
  @override
  Widget build(BuildContext context) {
    return Draggable<GameImagesGameFinalModel>(
      // Data is the value this Draggable stores.
      data: data,
      maxSimultaneousDrags: 1,
      feedback: Transform.translate(
          offset:
              const Offset(30, 0), // Adjust the offset to center the feedback
          child: Material(
            color: Colors.transparent,
            child: DottedBorder(
              // color: Colors.black,
              strokeWidth: 1,
              dashPattern: [8, 4],
              color: AppColorPhonetics.darkBorderColor,

              borderType: BorderType.RRect,
              radius: const Radius.circular(7),
              // padding: const EdgeInsets.all(6),
              child: Center(
                child: Text(
                  body.word ?? '',
                  style: TextStyle(
                      fontSize: 45,
                      fontFamily: AppTheme.getFontFamily5(),
                      color: AppColorPhonetics.darkBorderColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )),
      childWhenDragging: const SizedBox(),
      child: DottedBorder(
        // color: Colors.black,
        strokeWidth: 1,
        dashPattern: [8, 4],
        color: AppColorPhonetics.darkBorderColor,

        borderType: BorderType.RRect,
        radius: const Radius.circular(7),

        // padding: const EdgeInsets.all(6),
        child: Container(
          alignment: Alignment.center,
          child: Text(
            body.word ?? '',
            style: TextStyle(
                fontSize: 45,
                fontFamily: AppTheme.getFontFamily5(),
                color: AppColorPhonetics.darkBorderColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
