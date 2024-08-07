import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';

import 'package:based_of_eng_game/src/games/tracing/svg_strings/svg_strings.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/letter_a_paint.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/letter_t_paint.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/m_letter_paint.dart';
import 'package:flutter/material.dart';

import '../assets_images_phonetics.dart';
import '../game_types/assets_images_arabic.dart';
import '../game_types/assets_images_math.dart';
import '../phontics_constants/shape_paths.dart';
import '../phontics_constants/shape_points_manger.dart';
import 'basic_of_game_data.dart';

enum MainDataOfChaptersTypes {
  s,
  a,
  f,
  m,
  t,
  c,
  i,
  r,
  p,
  h,
  j,
  u,
  l,
  b,
  video,
  o,
  g,
  d,
  w,
  e,
  n,
  k,
  q,
  v,
  x,
  y,
  z,
  redUnit,
  orangeUnit,
  yellowUnit,
  blueUnit,
  greenUnit,
  violetUnit,
  shortVowels,
  up,
  math,
  consonant,
  rUnitArabic,
  rUnitPhonics,
  firstUnitArabic,
  mathEc1,
  mathEc3,
  mathEc2,
}

extension TypeExtension on MainDataOfChaptersTypes {
  String text() {
    switch (this) {
      case MainDataOfChaptersTypes.a:
        return "a".toLowerCase();
      case MainDataOfChaptersTypes.b:
        return 'b'.toLowerCase();
      case MainDataOfChaptersTypes.f:
        return 'f'.toLowerCase();
      case MainDataOfChaptersTypes.m:
        return 'm'.toLowerCase();
      case MainDataOfChaptersTypes.t:
        return 't'.toLowerCase();
      case MainDataOfChaptersTypes.c:
        return 'c'.toLowerCase();
      case MainDataOfChaptersTypes.i:
        return 'i'.toLowerCase();
      case MainDataOfChaptersTypes.g:
        return 'g'.toLowerCase();
      case MainDataOfChaptersTypes.o:
        return 'o'.toLowerCase();
      case MainDataOfChaptersTypes.j:
        return 'j'.toLowerCase();
      case MainDataOfChaptersTypes.l:
        return 'l'.toLowerCase();
      case MainDataOfChaptersTypes.u:
        return 'u'.toLowerCase();
      case MainDataOfChaptersTypes.h:
        return 'h'.toLowerCase();
      case MainDataOfChaptersTypes.p:
        return 'p'.toLowerCase();
      case MainDataOfChaptersTypes.r:
        return 'r'.toLowerCase();
      case MainDataOfChaptersTypes.s:
        return 's'.toLowerCase();
      case MainDataOfChaptersTypes.d:
        return 'd'.toLowerCase();
      case MainDataOfChaptersTypes.w:
        return 'w'.toLowerCase();
      case MainDataOfChaptersTypes.e:
        return 'e'.toLowerCase();
      case MainDataOfChaptersTypes.n:
        return 'n'.toLowerCase();
      case MainDataOfChaptersTypes.k:
        return 'k'.toLowerCase();
      case MainDataOfChaptersTypes.q:
        return 'q'.toLowerCase();
      case MainDataOfChaptersTypes.v:
        return 'v'.toLowerCase();
      case MainDataOfChaptersTypes.x:
        return 'x'.toLowerCase();
      case MainDataOfChaptersTypes.y:
        return 'y'.toLowerCase();
      case MainDataOfChaptersTypes.z:
        return 'z'.toLowerCase();
      case MainDataOfChaptersTypes.shortVowels:
        return 'Short Vowels'.toLowerCase();
      case MainDataOfChaptersTypes.up:
        return 'UP';
      case MainDataOfChaptersTypes.video:
        return 'video'.toLowerCase();
      case MainDataOfChaptersTypes.redUnit:
        return "المجموعة الحمراء".toLowerCase();
      case MainDataOfChaptersTypes.math:
        return "math".toLowerCase();
      case MainDataOfChaptersTypes.consonant:
        return "Consonant".toLowerCase();
      case MainDataOfChaptersTypes.rUnitArabic:
        return "مراجعة".toLowerCase();
      case MainDataOfChaptersTypes.rUnitPhonics:
        return "R Unit".toLowerCase();
      case MainDataOfChaptersTypes.firstUnitArabic:
        return "الوحدة الأولى (المدود)".toLowerCase();
      case MainDataOfChaptersTypes.blueUnit:
        return "المجموعة الزرقاء".toLowerCase();
      case MainDataOfChaptersTypes.greenUnit:
        return "المجموعة الخضراء".toLowerCase();
      case MainDataOfChaptersTypes.orangeUnit:
        return "المجموعة البرتقالية".toLowerCase();
      case MainDataOfChaptersTypes.violetUnit:
        return "المجموعة البنفسجية".toLowerCase();
      case MainDataOfChaptersTypes.yellowUnit:
        return "المجموعة الصفراء".toLowerCase();
      case MainDataOfChaptersTypes.mathEc1:
        return "EC1".toLowerCase();
      case MainDataOfChaptersTypes.mathEc2:
        return "EC2".toLowerCase();
      case MainDataOfChaptersTypes.mathEc3:
        return "EC3".toLowerCase();
    }
  }
}

abstract class MainDataOfChapters {
  late String background;
  BasicOfGameData? gameData;
  late Color backGroundOfStarBar;

  // To get the current swipe index
  bool? isArabic = false;
  final String letterPath;
  final Color strokeColor;
  final Color pointColor;
  final String letterAssets;
  final String tracingAssets;
  final String pointsJsonFile;

  MainDataOfChapters({required this.letterPath, required this.strokeColor, required this.pointColor, required this.letterAssets, required this.tracingAssets,  required this.pointsJsonFile}); // Added for points JSON file


}



class SPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

  @override
  BasicOfGameData? gameData;
  SPhonetics({
    required this.mineGameData,
  }) {
    gameData = mineGameData;
  }
  
  @override
  bool? isArabic;
  
  @override
  // TODO: implement letterAssets
  String get letterAssets => '';
  
  @override
  // TODO: implement letterPath
  String get letterPath => ShapePaths.snew;
  
  @override
  // TODO: implement pointColor
  Color get pointColor => Colors.red;
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => ShapePointsManger.sShape;
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => Colors.blue.withOpacity(.2);
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => '';

 
}

class APhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

  @override
  BasicOfGameData? gameData;
  late Size size;
  late Path dottedPath;
  APhonetics({
    required this.mineGameData,
  }) {
    gameData = mineGameData;

    pathsModels = [
      PathProviderModel(
          startPointOfShape: Offset(127.5, 27.8),
          endOffset: Offset(102.5, 46.6),
          fillDirection: Direction.xPositive,
          index: 0,
          path: SvgStrings.a1,
          startPoint: Offset(0, 0),
          strokeWidth: 150,
          indexPathModel: IndexPathModel(
              indexPathPath: SvgStrings.a1Index, indexPathColor: Colors.white),
          dottedPathModel: DottedPathModel(
              dottedPath: SvgStrings.a1Dotted,
              dottedPathColor: AppColorPhonetics.white),
          exteraFillPoint: null),
      PathProviderModel(
          startPointOfShape: Offset(102.5, 46.6),
          endOffset: Offset(127.5, 179.2),
          exteraFillPoint: Offset(15.8, 110.5),
          indexPathModel: IndexPathModel(
              indexPathPath: SvgStrings.a1Index, indexPathColor: Colors.white),
          fillDirection: Direction.xNegative,
          dottedPathModel: DottedPathModel(
              dottedPath: SvgStrings.a2Doted,
              dottedPathColor: AppColorPhonetics.white),
          index: 1,
          path: SvgStrings.a2,
          startPoint: Offset(0, 0),
          strokeWidth: 150),
      PathProviderModel(
          startPointOfShape: Offset(168.7, 16.6),
          endOffset: Offset(174.0, 201.0),
          exteraFillPoint: null,
          indexPathModel: IndexPathModel(
              indexPathPath: SvgStrings.a2Index, indexPathColor: Colors.white),
          fillDirection: Direction.yNegative,
          dottedPathModel: DottedPathModel(
              dottedPath: SvgStrings.a3Dotted,
              dottedPathColor: AppColorPhonetics.white),
          index: 1,
          path: SvgStrings.a3,
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
  CustomPainter? Function(List<Offset> points)? get newTracingLetter =>
      (List<Offset> points) {
        return ALetterPaint(
            customPaths: pathsModels,
            currentPathIndex: drawingShapecurrentIndex);
      };


  
  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();


}

class FPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfA;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();


  FPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;


}

class MPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfM;

  @override
  BasicOfGameData? gameData;
  late Size size;
  late Path dottedPath;
  MPhonetics({
    required this.mineGameData,
  }) {
    gameData = mineGameData;

    pathsModels = [
      PathProviderModel(
          startPointOfShape: Offset(39.8, 12.8),
          endOffset: Offset(36.6, 252.0),
          fillDirection: Direction.yNegative,
          index: 0,
          path: SvgStrings.m1,
          startPoint: Offset(0, 0),
          strokeWidth: 150,
          indexPathModel: IndexPathModel(
              indexPathPath: SvgStrings.m1Index, indexPathColor: Colors.white),
          dottedPathModel: DottedPathModel(
              dottedPath: SvgStrings.m1Dotted, dottedPathColor: Colors.white),
          exteraFillPoint: null),
      PathProviderModel(
          startPointOfShape: Offset(102.0, 45.1),
          endOffset: Offset(190.3, 251.2),
          exteraFillPoint: Offset(0.8, 0.5),
          indexPathModel: IndexPathModel(
              indexPathPath: SvgStrings.m2Index, indexPathColor: Colors.white),
          fillDirection: Direction.yNegative,
          dottedPathModel: DottedPathModel(
              dottedPath: SvgStrings.m2Dotted, dottedPathColor: Colors.white),
          index: 1,
          path: SvgStrings.m2,
          startPoint: Offset(0, 0),
          strokeWidth: 150),
      PathProviderModel(
          startPointOfShape: Offset(230.7, 47.3),
          endOffset: Offset(337.9, 244.5),
          exteraFillPoint: Offset(15.8, 110.5),
          indexPathModel: IndexPathModel(
              indexPathPath: SvgStrings.m3Index, indexPathColor: Colors.white),
          fillDirection: Direction.yNegative,
          dottedPathModel: DottedPathModel(
              dottedPath: SvgStrings.m3Dotted, dottedPathColor: Colors.white),
          index: 2,
          path: SvgStrings.m3,
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
  CustomPainter? Function(List<Offset> points)? get newTracingLetter =>
      (List<Offset> points) {
        return MLetterPaint(
            customPaths: pathsModels,
            currentPathIndex: drawingShapecurrentIndex);
      };

  @override
  set setDrawingShapeCurrentIndex(int index) {
    drawingShapecurrentIndex = index;
  }

  @override
  // TODO: implement letterAssets
  String get letterAssets => '';

  @override
  // TODO: implement letterPath
  String get letterPath => ShapePaths.mshape;

  @override
  // TODO: implement pointColor
  Color get pointColor => Colors.red;

  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => ShapePointsManger.mShape;

  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();

  @override
  // TODO: implement strokeColor
  Color get strokeColor => Colors.blue.withOpacity(.2);

  @override
  // TODO: implement tracingAssets
  String get tracingAssets => '';

}

class KPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfK;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  KPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;


}

class QPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfQ;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  QPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }



  @override
  bool? isArabic;
}

class VPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfV;



  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  
  @override
  set setDrawingShapeCurrentIndex(int index) {
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  VPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
  
  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();
}

class XPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfX;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  XPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class YPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfY;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  YPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class ZPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfZ;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  ZPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class TPhonetics implements MainDataOfChapters {

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  final BasicOfGameData mineGameData;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

  @override
  BasicOfGameData? gameData;
  late Size size;
  late Path dottedPath;
  TPhonetics({
    required this.mineGameData,
  }) {
    gameData = mineGameData;

    pathsModels = [
      PathProviderModel(
          startPointOfShape: Offset(89.3, 20.3),
          endOffset: Offset(75.0, 284.2),
          fillDirection: Direction.yNegative,
          index: 0,
          path: SvgStrings.t1,
          startPoint: Offset(0, 0),
          strokeWidth: 150,
          indexPathModel: IndexPathModel(
              indexPathPath: SvgStrings.t1Index, indexPathColor: Colors.white),
          dottedPathModel: DottedPathModel(
              dottedPath: SvgStrings.t1Dotted,
              dottedPathColor: AppColorPhonetics.white),
          exteraFillPoint: null),
      PathProviderModel(
          startPointOfShape: Offset(54.8, 127.5),
          endOffset: Offset(102.8, 136.5),
          exteraFillPoint: Offset(15.8, 110.5),
          indexPathModel: IndexPathModel(
              indexPathPath: SvgStrings.t2Index, indexPathColor: Colors.white),
          fillDirection: Direction.xNegative,
          dottedPathModel: DottedPathModel(
              dottedPath: SvgStrings.t2Dotted,
              dottedPathColor: AppColorPhonetics.white),
          index: 1,
          path: SvgStrings.t2,
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
  CustomPainter? Function(List<Offset> points)? get newTracingLetter =>
      (List<Offset> points) {
        return TLetterPaint(
            customPaths: pathsModels,
            currentPathIndex: drawingShapecurrentIndex);
      };

  @override
  set setDrawingShapeCurrentIndex(int index) {
    drawingShapecurrentIndex = index;
  }


}

class CPhonetics implements MainDataOfChapters {

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();


  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfC;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  
  @override
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  CPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  set setDrawingShapeCurrentIndex(int index) {

  }
}

class RPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfR;



  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  RPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class IPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfI;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  IPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class PPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfP;



  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  PPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class HPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfH;



  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  HPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class JPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfJ;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  JPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class UPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfU;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  UPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class LPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfL;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  LPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class BPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfB;



  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  BPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class OPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = Colors.white.withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfO;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  OPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class GPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfG;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  GPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class DPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfD;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  DPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class WPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfW;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  WPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class EPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfE;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  EPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class NPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfN;



  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  NPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class ShortVowels implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfShortVowels;



  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  ShortVowels(
      {required this.mineGameData,
      required bool isArabicSub,
      required String? subBackGround}) {
    gameData = mineGameData;
    isArabic = isArabicSub;
    background = subBackGround ?? AppImagesPhonetics.backGroundOfShortVowels;
  }

  @override
  bool? isArabic;
}

class UpVowels implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfShortVowels;



  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  UpVowels({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class ConnectionWithoutSortingCups implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;



  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  ConnectionWithoutSortingCups(
      {required this.mineGameData,
      required bool isArabicSub,
      required String? subBackGround}) {
    gameData = mineGameData;
    background = subBackGround ?? background;
    isArabic = isArabicSub;
  }

  @override
  bool? isArabic;
}

class ConnectionSortingCups implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);



  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  @override
  bool? isArabic;
  ConnectionSortingCups(
      {required this.mineGameData,
      required bool isArabicSub,
      required String? subBackGround}) {
    gameData = mineGameData;
    background = subBackGround ?? background;
    isArabic = isArabicSub;
  }
}

class RedPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfRedUnit;



  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  RedPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;
}

class BlueUnit implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfBlueUnit;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  BlueUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }



  @override
  bool? isArabic;
}

class GreenUnit implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfGreenUnit;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  GreenUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }



  @override
  bool? isArabic;
}

class YellowUnit implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfYellowUnit;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  YellowUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }



  @override
  bool? isArabic;
}

class VioletUnit implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfVioletUnit;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  VioletUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }



  @override
  bool? isArabic;
}

class OrangeUnit implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfOrangeUnit;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  OrangeUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }
  @override
  bool? isArabic;


}

class MathProgram implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  late bool isEc1;
  @override
  String background = AppImagesMath.mathBg;

  @override
  BasicOfGameData? gameData;

  MathProgram(
      {required this.mineGameData, String? background, required this.isEc1}) {
    gameData = mineGameData;
    this.background = background ?? AppImagesMath.mathBg;
  }



  @override
  bool? isArabic;

  @override
  int get getDrawingShapeCurrentIndex => throw UnimplementedError();

  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter =>
      throw UnimplementedError();

  @override
  set setDrawingShapeCurrentIndex(int index) {

  }

  @override
  late List<PathProviderModel> pathsModels;
  
  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();
}

class FirstUnitArabic implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfFirstUnit;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  FirstUnitArabic({required this.mineGameData}) {
    gameData = mineGameData;
  }



  @override
  bool? isArabic = true;
}

class RUnitArabic implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  RUnitArabic({required this.mineGameData, required String? subBackGround}) {
    gameData = mineGameData;
    background = subBackGround ?? background;
  }



  @override
  bool? isArabic = true;
}

class RUnitPhonics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfShortVowels;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  RUnitPhonics({required this.mineGameData}) {
    gameData = mineGameData;
  }



  @override
  bool? isArabic = true;
}

class ConsonantVowels implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.ec3Bg;

  @override
  BasicOfGameData? gameData;

  @override
  // TODO: implement letterAssets
  String get letterAssets => throw UnimplementedError();
  
  @override
  // TODO: implement letterPath
  String get letterPath => throw UnimplementedError();
  
  @override
  // TODO: implement pointColor
  Color get pointColor => throw UnimplementedError();
  
  @override
  // TODO: implement pointsJsonFile
  String get pointsJsonFile => throw UnimplementedError();
  
  @override
  // TODO: implement strokeAssets
  String get strokeAssets => throw UnimplementedError();
  
  @override
  // TODO: implement strokeColor
  Color get strokeColor => throw UnimplementedError();
  
  @override
  // TODO: implement tracingAssets
  String get tracingAssets => throw UnimplementedError();

  ConsonantVowels({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;


}
