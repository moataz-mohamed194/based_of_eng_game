import 'package:based_of_eng_game/src/core/math_weidgt/stick.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../game_types/game_phonatics_types.dart';
import '../games_structure/basic_of_game_data.dart';
import 'get_the_beads.dart';
import 'get_the_blocks.dart';

class CardOfBlocks extends StatelessWidget {
  final int number;
  final ToolsOfMath tools;
  final double? size;
  final double? newWidth;
  final double? scale;
  final AlignmentGeometry? alignment;

  const CardOfBlocks(
      {super.key,
      required this.number,
      this.size,
      this.scale,
      this.alignment,
      required this.tools,
      this.newWidth});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final sizeOfOne = Size(width / 15, (width / 22).toDouble());
    return Container(
      width: newWidth ?? (width / 3),
      height: 65.h,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.28),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 28.48,
            offset: Offset(0, 8.14),
            spreadRadius: 0,
          )
        ],
      ),
      child: Container(
          alignment: alignment ?? Alignment.centerLeft,
          margin: EdgeInsets.all(5),
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              side: BorderSide(width: 2.03, color: Color(0xFFA1CBEA)),
              borderRadius: BorderRadius.circular(16.28),
            ),
          ),
          child: number == 0
              ? SizedBox()
              : Transform.scale(
    scale: scale??1,
    child:Container(
      padding: EdgeInsets.only(right:scale==null?0:15.w ),
      child: FittedBox(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 7.w),
                      child: GetTheBlocks(
                        countOfBoxes: number,
                      ),
                    ),
                  ),
    ))),
    );
  }
}
