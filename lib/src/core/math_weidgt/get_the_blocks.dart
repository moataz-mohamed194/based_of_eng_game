import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../game_types/assets_images_math.dart';
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
    return countOfBoxes <= 10
        ? SvgPicture.asset(_svgOfBlock(number: countOfBoxes), color:isHide==true? Colors.transparent:null,)
        : SizedBox(
            height: sizeOfOne.height,
            width: countOfBoxes == 1
                ? (sizeOfOne.width * countOfBoxes)
                : countOfBoxes == 2
                    ? (sizeOfOne.width * countOfBoxes) - (2 * countOfBoxes)
                    : countOfBoxes == 5
                        ? (sizeOfOne.width * countOfBoxes) -
                            (6.w * countOfBoxes)
                        : (sizeOfOne.width * countOfBoxes) -
                            (5.w * countOfBoxes),
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
                            left: (sizeOfOne.width * index) - (15 * index),
                            child: SvgPicture.string(
                              PaintOfBlocks.body(
                                  color: colors.first.colorMain,
                                  boarderColor: colors.first.colorBoarder),
                              width: sizeOfOne.width + 0.w,
                            ),
                          );
                        } else {
                          return Positioned(
                            left: (sizeOfOne.width * index) - (15 * index),
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

  _svgOfBlock({required int number}) {
    switch (number) {
      case 1:
        return AppImagesMath.block1;
      case 2:
        return AppImagesMath.block2;
      case 3:
        return AppImagesMath.block3;
      case 4:
        return AppImagesMath.block4;
      case 5:
        return AppImagesMath.block5;
      case 6:
        return AppImagesMath.block6;
      case 7:
        return AppImagesMath.block7;
      case 8:
        return AppImagesMath.block8;
      case 9:
        return AppImagesMath.block9;
      case 10:
        return AppImagesMath.block10;
    }
  }
}

class ColorModel {
  final String colorMain;
  final String colorBoarder;

  ColorModel({required this.colorMain, required this.colorBoarder});
}
