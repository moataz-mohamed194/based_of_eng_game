import 'package:flutter/material.dart';

import 'paint_of_blocks.dart';

class GetTheBlocks extends StatelessWidget {
  final int countOfBoxes;
  final List<ColorModel> colors = [
    ColorModel(
        colorMain: const Color(0xffEE1D23),
        colorBoarder: const Color(0xff930B0F)),
    ColorModel(
        colorMain: const Color(0xff406AB4),
        colorBoarder: const Color(0xff173372)),
  ];

  GetTheBlocks({super.key, required this.countOfBoxes});
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    final sizeOfOne = Size(width / 15, (width / 22).toDouble());
    return SizedBox(
      height: sizeOfOne.height,
      width: countOfBoxes == 1
          ? (sizeOfOne.width * countOfBoxes)
          : countOfBoxes == 2
              ? (sizeOfOne.width * countOfBoxes) - (2 * countOfBoxes)
              : countOfBoxes == 5
                  ? (sizeOfOne.width * countOfBoxes) - (6 * countOfBoxes)
                  : (sizeOfOne.width * countOfBoxes) - (5 * countOfBoxes),
      child: Stack(
        // fit: StackFit.expand,
        // clipBehavior: Clip.antiAliasWithSaveLayer,
        // clipBehavior: Clip.none,
        children: [
          ...List.generate(countOfBoxes, (index) {
            if (index == 0 || index % 2 == 0) {
              return Positioned(
                left: index == 0 ? 0 : (sizeOfOne.width * index) - (7 * index),
                child: CustomPaint(
                    size: sizeOfOne,
                    painter: PaintOfBlocks(
                        color: colors.first.colorMain,
                        boarderColor: colors.first.colorBoarder)),
              );
            } else {
              return Positioned(
                left: (sizeOfOne.width * index) - (7 * index),
                child: CustomPaint(
                    size: sizeOfOne,
                    painter: PaintOfBlocks(
                        color: colors.last.colorMain,
                        boarderColor: colors.last.colorBoarder)),
              );
            }
          })
        ],
      ),
    );
  }
}

class ColorModel {
  final Color colorMain;
  final Color colorBoarder;

  ColorModel({required this.colorMain, required this.colorBoarder});
}
