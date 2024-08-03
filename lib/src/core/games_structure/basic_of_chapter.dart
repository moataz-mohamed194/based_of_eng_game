import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';
import 'package:based_of_eng_game/src/games/tracing/svg_strings/svg_strings.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/letter_s4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

import '../../games/tracing/widget/letter_m.dart';
import '../../games/tracing/widget/letter_s3.dart';
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
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)?
      get tracingOfLetter;
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath;

  // to get current swipe index

  late int? countOfPartsOfLettersForTracing = 0;

  bool? isArabic = false;

  // Provide a default implementation that returns null
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  late List<PathProviderModel> pathsModels;

  int get getdrawingShapeCurrentIndex;
  set setdrawingShapeCurrentIndex(int index);
}

class SPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  final BuildContext parentContext;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

  @override
  BasicOfGameData? gameData;
  late BuildContext context;
  late Size size;
  late Path dottedPath;
  SPhonetics({required this.mineGameData, required this.parentContext}) {
    context = parentContext;
    gameData = mineGameData;
    size = size = Size(MediaQuery.of(context).size.width / 3,
        MediaQuery.of(context).size.height - (70.h));
    dottedPath = parseSvgPath(SvgStrings.dottedS);

    pathsModels = [
      PathProviderModel(
          fillDirection: Direction.xNegative,
          startPaintingOffset: Offset(281.3, 66.5),
          finishRatio: .33,
          pointsLimitToRatio: 10,
          index: 0,
          path: SvgStrings.s1,
          startPoint: Offset(size.width / 4, 0),
          strokeWidth: 150,
          dottedPath: SvgStrings.dotteds1),
      PathProviderModel(
          fillDirection: Direction.xPositive,
          dottedPath: SvgStrings.dotteds2,
          startPaintingOffset: Offset(90.3, 116.5),
          finishRatio: .33,
          pointsLimitToRatio: 10,
          index: 1,
          path: SvgStrings.s2,
          startPoint: Offset(size.width / 4, 0),
          strokeWidth: 150),
      PathProviderModel(
          fillDirection: Direction.xNegative,
          dottedPath: SvgStrings.dotteds3,
          startPaintingOffset: Offset(232.8, 200.5),
          finishRatio: .28,
          pointsLimitToRatio: 10,
          index: 2,
          path: SvgStrings.s3,
          startPoint: Offset(size.width / 4, 0),
          strokeWidth: 150),
    ];
  }

  @override
  int? countOfPartsOfLettersForTracing = 14;

  int drawingShapecurrentIndex = 0;

  @override
  late List<PathProviderModel> pathsModels;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter => throw UnimplementedError();

  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath => throw UnimplementedError();

  @override
  int get getdrawingShapeCurrentIndex => drawingShapecurrentIndex;

  @override
  bool? isArabic;

  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter =>
      (List<Offset> points) {
        size = Size(MediaQuery.of(context).size.width / 3,
            MediaQuery.of(context).size.height - (70.h));
        return FlipBookPainterLetterS4Test(
            scalingFactor: 1,
            customPaths: pathsModels,
            currentPathIndex: drawingShapecurrentIndex);
      };

  @override
  set setdrawingShapeCurrentIndex(int index) {
    drawingShapecurrentIndex = index;
  }
}

class APhonetics implements MainDataOfChapters {
  @override
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;

  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfA;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return null;
          };

  @override
  BasicOfGameData? gameData;

  String winAvatar = AppImagesPhonetics.beeSuccess;

  APhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 0;

  @override
  bool? isArabic;
}

class FPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class MPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfM;

  @override
  BasicOfGameData? gameData;
  @override
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  MPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 16;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return FlipBookPainterLetterM(colorsOfPaths: colorsOfPaths);
          };

  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

  @override
  bool? isArabic;
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
            return FlipBookPainterLetterM(colorsOfPaths: colorsOfPaths);
          };

  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
            return FlipBookPainterLetterM(colorsOfPaths: colorsOfPaths);
          };

  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
            return FlipBookPainterLetterM(colorsOfPaths: colorsOfPaths);
          };

  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

  @override
  bool? isArabic;
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
            return FlipBookPainterLetterM(colorsOfPaths: colorsOfPaths);
          };

  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
            return FlipBookPainterLetterM(colorsOfPaths: colorsOfPaths);
          };

  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
            return FlipBookPainterLetterM(colorsOfPaths: colorsOfPaths);
          };

  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

  @override
  bool? isArabic;
}

class TPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  String background = AppImagesPhonetics.backGroundOfT;

  @override
  BasicOfGameData? gameData;
  @override
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  TPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class CPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class RPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class IPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class PPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class HPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class JPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class UPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class LPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class BPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class OPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class GPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class DPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
    // TODO: implement setdrawingShapeCurrentIndex
  }
  @override
  CustomPainter? Function(List<Offset> points)? get newTracingLetter => null;
  @override
  late List<PathProviderModel> pathsModels;
  DPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;
}

class WPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class EPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class NPhonetics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class ShortVowels implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class UpVowels implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class ConnectionWithoutSortingCups implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfGameData? gameData;
  @override
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class ConnectionSortingCups implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfGameData? gameData;
  @override
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class RedPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfRedUnit;

  @override
  BasicOfGameData? gameData;
  @override
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

  @override
  bool? isArabic;
}

class MathProgram implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesMath.mathBg;

  @override
  BasicOfGameData? gameData;
  @override
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };

  @override
  bool? isArabic;
}

class FirstUnitArabic implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfFirstUnit;

  @override
  BasicOfGameData? gameData;
  @override
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class RUnitArabic implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfGameData? gameData;
  @override
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class RUnitPhonics implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfShortVowels;

  @override
  BasicOfGameData? gameData;
  @override
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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

class ConsonantVowels implements MainDataOfChapters {
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return null;
          };
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
  int get getdrawingShapeCurrentIndex => 0;
  @override
  set setdrawingShapeCurrentIndex(int index) {
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
