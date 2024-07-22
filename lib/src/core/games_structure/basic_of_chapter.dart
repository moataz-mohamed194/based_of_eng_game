import 'package:flutter/material.dart';

import '../../games/tracing/widget/letter_m.dart';
import '../../games/tracing/widget/letter_s3.dart';
import '../assets_images_phonetics.dart';
import '../game_types/assets_images_arabic.dart';
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
  shortVowels,
  up
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
  late int? countOfPartsOfLettersForTracing = 0;

  bool? isArabic = false;
}

class SPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

  @override
  BasicOfGameData? gameData;

  SPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  int? countOfPartsOfLettersForTracing = 14;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths, List<Offset> points)
      get tracingOfLetter =>
          (List<Color?>? colorsOfPaths, List<Offset> points) {
            return FlipBookPainterLetterS(
                colorsOfPaths: colorsOfPaths, points: points);
          };
  @override
  (Path, int)? Function(Offset point, Size size, bool isFingerPosition)?
      get checkTheIndexOfPath =>
          (Offset point, Size size, bool isFingerPosition) {
            return FlipBookPainterLetterS.indexOfPointInside(
                point, size, isFingerPosition);
          };

  @override
  bool? isArabic;
}

class APhonetics implements MainDataOfChapters {
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

  ShortVowels({required this.mineGameData}) {
    gameData = mineGameData;
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

  ConnectionWithoutSortingCups({required this.mineGameData}) {
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
  bool? isArabic;
  ConnectionSortingCups({required this.mineGameData, required bool isArabicSub, required String? subBackGround}) {
    gameData = mineGameData;
    background= subBackGround??background;
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

class MathProgram implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfRedUnit;

  @override
  BasicOfGameData? gameData;

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
