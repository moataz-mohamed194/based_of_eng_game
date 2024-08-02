import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'paint_of_blocks.dart';

class GetTheBlocks extends StatelessWidget {
  final int countOfBoxes;
  final bool? isSolid;
  final bool? isHide;
  final List<ColorModel> colors = [
    ColorModel(colorMain: '#EE1D23', colorBoarder: '#930B0F'),
    ColorModel(colorMain: '#406AB4', colorBoarder: '#173372'),
  ];

  GetTheBlocks(
      {super.key, this.isHide, required this.countOfBoxes, this.isSolid});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final sizeOfOne = Size(width / 15, (width / 22).toDouble());
    return SizedBox(
      height: sizeOfOne.height,
      width: (sizeOfOne.width * countOfBoxes),
      // countOfBoxes == 1
      //   ? (sizeOfOne.width * countOfBoxes)
      //   : countOfBoxes == 2
      //       ? (sizeOfOne.width * countOfBoxes) - (2 * countOfBoxes)
      //       : countOfBoxes == 5
      //           ? (sizeOfOne.width * countOfBoxes) - (6 * countOfBoxes)
      //           : (sizeOfOne.width * countOfBoxes) - (5 * countOfBoxes),
      child: isHide == true
          ? SizedBox()
          : Stack(
              // fit: StackFit.expand,
              // clipBehavior: Clip.antiAliasWithSaveLayer,
              // clipBehavior: Clip.none,
              children: [
                ...List.generate(countOfBoxes, (index) {
                  if (index == 0 || index % 2 == 0) {
                    return Positioned(
                      left: (sizeOfOne.width * index) - (10 * index),
                      child: SvgPicture.string(
                        PaintOfBlocks.body(
                            color: colors.first.colorMain,
                            boarderColor: colors.first.colorBoarder),
                        width: sizeOfOne.width + 0.w,
                      ),
                    );
                  } else {
                    return Positioned(
                      left: (sizeOfOne.width * index) - (10 * index),
                      child: SvgPicture.string(
                        PaintOfBlocks.body(
                            color: colors.last.colorMain,
                            boarderColor: colors.last.colorBoarder),
                        width: sizeOfOne.width + 0.w,
                      ),
                    );
                  }
                })
              ],
            ),
    );
  }
}

class ColorModel {
  final String colorMain;
  final String colorBoarder;

  ColorModel({required this.colorMain, required this.colorBoarder});
}
