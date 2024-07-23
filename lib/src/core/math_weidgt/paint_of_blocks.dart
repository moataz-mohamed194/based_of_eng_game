import 'package:flutter/material.dart';

class PaintOfBlocks extends CustomPainter {
  final Color color;
  final Color boarderColor;

  PaintOfBlocks({required this.color, required this.boarderColor});
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9999985, size.height * 0.1853693);
    path_0.lineTo(size.width * 0.09392831, size.height * 0.1853693);
    path_0.lineTo(size.width * 0.09392831, size.height * 0.9959500);
    path_0.lineTo(size.width * 0.9999985, size.height * 0.9959500);
    path_0.lineTo(size.width * 0.9999985, size.height * 0.1853693);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.green; //.withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);

    Path path_1 = Path();
    path_1.moveTo(size.width * 0.9060708, 0);
    path_1.lineTo(size.width, size.height * 0.1853475);
    path_1.lineTo(size.width, size.height * 0.9959273);
    path_1.lineTo(size.width * 0.9060708, size.height * 0.8105818);
    path_1.lineTo(size.width * 0.9060708, 0);
    path_1.close();

    Paint paint_1_fill = Paint()..style = PaintingStyle.fill;
    paint_1_fill.color = boarderColor;
    canvas.drawPath(path_1, paint_1_fill);

    Path path_2 = Path();
    path_2.moveTo(size.width * 0.09392938, size.height * 0.9959409);
    path_2.lineTo(size.width * 0.9968246, size.height);
    path_2.lineTo(size.width * 0.9028954, size.height * 0.8148455);
    path_2.lineTo(0, size.height * 0.8105932);

    Paint paint_2_fill = Paint()..style = PaintingStyle.fill;
    paint_2_fill.color = boarderColor;
    canvas.drawPath(path_2, paint_2_fill);

    Path path_3 = Path();
    path_3.moveTo(size.width * 0.9060708, 0);
    path_3.lineTo(0, 0);
    path_3.lineTo(0, size.height * 0.8105818);
    path_3.lineTo(size.width * 0.9060708, size.height * 0.8105818);
    path_3.lineTo(size.width * 0.9060708, 0);
    path_3.close();

    Paint paint_3_fill = Paint()..style = PaintingStyle.fill;
    paint_3_fill.color = color;
    canvas.drawPath(path_3, paint_3_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
