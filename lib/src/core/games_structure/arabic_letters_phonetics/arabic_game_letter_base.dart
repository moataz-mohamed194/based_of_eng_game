import 'dart:ui';

import 'package:based_of_eng_game/based_of_eng_game.dart';
import 'package:based_of_eng_game/src/core/assets_images_phonetics.dart';
import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/games/tracing/manager/tracing_cubit.dart';
import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';
import 'package:based_of_eng_game/src/games/tracing/svg_strings/arabic_svg.dart';
import 'package:based_of_eng_game/src/games/tracing/svg_strings/svg_strings.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/letter_a_paint.dart';
import 'package:flutter/material.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class GemPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

  @override
  BasicOfGameData? gameData;
  late Path dottedPath;
  GemPhonetics({
    required this.mineGameData, required super.letterPath, required super.strokeColor, required super.pointColor, required super.letterAssets, required super.tracingAssets,  required super.pointsJsonFile,
  }) {
    gameData = mineGameData;

    dottedPath = parseSvgPath(SvgStrings.dottedS);
    pathsModels = [
      PathProviderModel(
          startPointOfShape: Offset(8.1, 28.6),
          // indexPathModel: IndexPathModel(indexPathPath: SvgStrings.sIndex1),
          endOffset:Offset(148.3, 33.8),
          fillDirection: Direction.xNegative,
          index: 0,
          path: ArabicSvgs.gem1,
          startPoint: Offset(0, 0),
          strokeWidth: 150,
          // dottedPathModel: DottedPathModel(dottedPath: SvgStrings.dotteds1),
          exteraFillPoint: null),
      PathProviderModel(
          startPointOfShape:Offset(148.3, 33.8),
          endOffset:Offset(10.3, 123.0),
          exteraFillPoint: null,
          fillDirection: Direction.arc,
          // dottedPathModel: DottedPathModel(dottedPath: SvgStrings.dotteds2),
          index: 1,
          path: ArabicSvgs.gem2,
          startPoint: Offset(0, 0),
          strokeWidth: 150),
      PathProviderModel(
          startPointOfShape:Offset(7.3, 130.5),
          // indexPathModel: IndexPathModel(indexPathPath: SvgStrings.sIndex2),
          endOffset:Offset(15.6, 183.7),
          exteraFillPoint: null,
          fillDirection: Direction.arc,
          // dottedPathModel: DottedPathModel(dottedPath: SvgStrings.dotteds3),
          index: 2,
          path: ArabicSvgs.gem3,
          startPoint: Offset(0, 0),
          strokeWidth: 150),
      PathProviderModel(
          startPointOfShape:Offset(15.6, 183.7),
          // indexPathModel: IndexPathModel(indexPathPath: SvgStrings.sIndex2),
          endOffset: Offset(115.3, 229.5),
          exteraFillPoint: Offset(17.8, 198.0),
          
          fillDirection: Direction.arc,
          // dottedPathModel: DottedPathModel(dottedPath: SvgStrings.dotteds3),
          index: 3,
          path: ArabicSvgs.gem4,
          startPoint: Offset(0, 0),
          strokeWidth: 150),

            PathProviderModel(
          startPointOfShape:Offset(15.6, 183.7),
          // indexPathModel: IndexPathModel(indexPathPath: SvgStrings.sIndex2),
          endOffset: Offset(115.3, 229.5),
          exteraFillPoint: Offset(17.8, 198.0),
          
          fillDirection: Direction.arc,
          // dottedPathModel: DottedPathModel(dottedPath: SvgStrings.dotteds3),
          index: 3,
          isDotFill: true,
          path: ArabicSvgs.gem5,
          startPoint: Offset(0, 0),
          strokeWidth: 150),
    ];
  }

  int drawingShapecurrentIndex = 0;

  @override
  late List<PathProviderModel> pathsModels;

  @override
  int get getDrawingShapeCurrentIndex => drawingShapecurrentIndex;

  @override
  bool? isArabic;


  @override
  set setDrawingShapeCurrentIndex(int index) {
    drawingShapecurrentIndex = index;
  }
}
