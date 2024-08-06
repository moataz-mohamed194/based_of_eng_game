import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/games/tracing/manager/tracing_cubit.dart';
import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/path_helper/a_shape_path_helper/a_shape_path_helper.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/path_helper/path_helper.dart';
import 'package:based_of_eng_game/src/games/tracing/svg_strings/svg_strings.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/letter_a_paint.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/letter_t_paint.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/m_letter_paint.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/letter_s4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_path_parser/svg_path_parser.dart';


import '../assets_images_phonetics.dart';
import '../game_types/assets_images_arabic.dart';
import '../game_types/assets_images_math.dart';
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
  firstUnitArabic
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
    }
  }
}

abstract class MainDataOfChapters {
  late String background;
  BasicOfGameData? gameData;
  late Color backGroundOfStarBar;

  // To get the current swipe index
  bool? isArabic = false;

  // Provide a default implementation that returns null
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;

  late List<PathProviderModel> pathsModels;

  // Define the addPoint function as abstract so it can be overridden
  void addPointMainAddPoint(DragUpdateDetails details, TracingCubit cubit,
      TracingInitial stateOfGame, BuildContext context) {
    PathHelper.mainAddPoint(details, cubit, stateOfGame, context);
  }

  int get getDrawingShapeCurrentIndex;
  set setDrawingShapeCurrentIndex(int index);
}

class SPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;





  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

  @override
  BasicOfGameData? gameData;
  late Path dottedPath;
  SPhonetics({
    required this.mineGameData,
  }) {
    gameData = mineGameData;

    dottedPath = parseSvgPath(SvgStrings.dottedS);

    pathsModels = [
      PathProviderModel(
          startPointOfShape: Offset(221.2, 65.3),
          indexPathModel: IndexPathModel(indexPathPath: SvgStrings.sIndex1),
          endOffset: Offset(37.7, 85.0),
          fillDirection: Direction.xPositive,
          index: 0,
          path: SvgStrings.s1,
          startPoint: Offset(0, 0),
          strokeWidth: 150,
          dottedPathModel: DottedPathModel(dottedPath: SvgStrings.dotteds1),
          exteraFillPoint: null),
      PathProviderModel(
          startPointOfShape: Offset(54.8, 127.5),
          endOffset: Offset(195.0, 182.7),
          exteraFillPoint: Offset(15.8, 110.5),
          fillDirection: Direction.xNegative,
          dottedPathModel: DottedPathModel(dottedPath: SvgStrings.dotteds2),
          index: 1,
          path: SvgStrings.s2,
          startPoint: Offset(0, 0),
          strokeWidth: 150),
      PathProviderModel(
          startPointOfShape: Offset(222.8, 199.5),
          indexPathModel: IndexPathModel(indexPathPath: SvgStrings.sIndex2),
          endOffset: Offset(51.0, 255.0),
          exteraFillPoint: Offset(232.8, 200.5),
          fillDirection: Direction.xPositive,
          dottedPathModel: DottedPathModel(dottedPath: SvgStrings.dotteds3),
          index: 2,
          path: SvgStrings.s3,
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
        return FlipBookPainterLetterS4Test(
            customPaths: pathsModels,
            currentPathIndex: drawingShapecurrentIndex);
      };

  @override
  set setDrawingShapeCurrentIndex(int index) {
    drawingShapecurrentIndex = index;
  }
}

class APhonetics extends MainDataOfChapters {
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
          startPointOfShape:           Offset(102.5, 46.6)
,
          endOffset: Offset(127.5, 179.2),
          exteraFillPoint: Offset(15.8, 110.5),
       indexPathModel: IndexPathModel(
              indexPathPath: SvgStrings.a1Index, indexPathColor: Colors.white),          fillDirection: Direction.xNegative,

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
          indexPathModel: IndexPathModel(indexPathPath: SvgStrings.a2Index,indexPathColor:  Colors.white),
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
  set setDrawingShapeCurrentIndex(int index) {
    drawingShapecurrentIndex = index;
  }
}

class FPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };
  @override
  String background = AppImagesPhonetics.backGroundOfA;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  FPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class MPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

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
}

class KPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfK;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  KPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 16;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
         throw UnimplementedError();
          };

  @override
  bool? isArabic;
}

class QPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfQ;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  QPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 16;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
           throw UnimplementedError();
          };

  @override
  bool? isArabic;
}

class VPhonetics extends MainDataOfChapters {
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
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  VPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 16;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
           throw UnimplementedError();
          };

  @override
  bool? isArabic;
}

class XPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfX;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  XPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 16;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
           throw UnimplementedError();
          };

  @override
  bool? isArabic;
}

class YPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfY;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  YPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 16;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
           throw UnimplementedError();
          };

  @override
  bool? isArabic;
}

class ZPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfZ;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  ZPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 16;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
           throw UnimplementedError();
          };

  @override
  bool? isArabic;
}

class TPhonetics extends MainDataOfChapters {
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

class CPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfC;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  CPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class RPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfR;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  RPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class IPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfI;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  IPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class PPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfP;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  PPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class HPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfH;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  HPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class JPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfJ;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  JPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class UPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfU;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  UPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class LPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfL;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  LPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class BPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfB;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  BPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class OPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = Colors.white.withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfO;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  OPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class GPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfG;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  GPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class DPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfD;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  DPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class WPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfW;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  WPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class EPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  String background = AppImagesPhonetics.backGroundOfE;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  EPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class NPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfN;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  NPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class ShortVowels extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfShortVowels;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  ShortVowels(
      {required this.mineGameData,
      required bool isArabicSub,
      required String? subBackGround}) {
    gameData = mineGameData;
    isArabic = isArabicSub;
    background = subBackGround ?? AppImagesPhonetics.backGroundOfShortVowels;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class UpVowels extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfShortVowels;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  UpVowels({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class ConnectionWithoutSortingCups extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  ConnectionWithoutSortingCups(
      {required this.mineGameData,
      required bool isArabicSub,
      required String? subBackGround}) {
    gameData = mineGameData;
    background = subBackGround ?? background;
    isArabic = isArabicSub;
  }

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class ConnectionSortingCups extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
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

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  int? countOfPartsOfLettersForTracing;
}

class RedPhonetics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfRedUnit;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  RedPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 14;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  bool? isArabic;
}

class BlueUnit extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfBlueUnit;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  BlueUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 14;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  bool? isArabic;
}

class GreenUnit extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfGreenUnit;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  GreenUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 14;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  bool? isArabic;
}

class YellowUnit extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfYellowUnit;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  YellowUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 14;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  bool? isArabic;
}

class VioletUnit extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfVioletUnit;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  VioletUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 14;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  bool? isArabic;
}

class OrangeUnit extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfOrangeUnit;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  OrangeUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 14;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  bool? isArabic;
}

class MathProgram extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesMath.mathBg;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  MathProgram({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 14;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  bool? isArabic;
}

class FirstUnitArabic extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfFirstUnit;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  FirstUnitArabic({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic = true;
}

class RUnitArabic extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  RUnitArabic({required this.mineGameData, required String? subBackGround}) {
    gameData = mineGameData;
    background = subBackGround ?? background;
  }

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic = true;
}

class RUnitPhonics extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfShortVowels;

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  RUnitPhonics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic = true;
}

class ConsonantVowels extends MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.ec3Bg;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  BasicOfGameData? gameData;
  @override
  int get getDrawingShapeCurrentIndex => 0;
  @override
  set setDrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  ConsonantVowels({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}
