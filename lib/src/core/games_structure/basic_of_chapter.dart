import 'package:based_of_eng_game/src/core/assets_images_culture.dart';
import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/games/tracing/model/path_provider_model.dart';

import 'package:based_of_eng_game/src/games/tracing/svg_strings/svg_strings.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/letter_a_paint.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/letter_t_paint.dart';
import 'package:based_of_eng_game/src/games/tracing/widget/english_alphabets_paints/m_letter_paint.dart';
import 'package:flutter/material.dart';

import '../../../src_model/model/trace_model.dart';
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
  culture
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
      case MainDataOfChaptersTypes.culture:
        return "culture".toLowerCase();
    }
  }
}

abstract class MainDataOfChapters {
  late String background;
  BasicOfGameData? gameData;
  late Color backGroundOfStarBar;

  // To get the current swipe index
  bool? isArabic = false;
  late List<TraceModel>? lettersModel;
  // Added for points JSON file
}

class Culture implements MainDataOfChapters {
  final BasicOfGameData mineGameData;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesCulture.background;

  @override
  BasicOfGameData? gameData;
  Culture({
    required this.mineGameData,
  }) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
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
  List<TraceModel>? lettersModel = [
    TraceModel(
        indexPathPaintStyle: PaintingStyle.fill,
        dottedPathPaintStyle: PaintingStyle.fill,
        dottedPath: ShapePaths.sDotted,
        dottedColor: AppColorPhonetics.white,
        indexColor: AppColorPhonetics.phonticGrey,
        indexPath: ShapePaths.sIndex,
        strokeWidth: 75,
        scaleIndexPath: .7,
        poitionIndexPath: Size(-10, 0),
        scaledottedPath: .8,
        letterPath: ShapePaths.s3,
        pointsJsonFile: ShapePointsManger.sShape,
        innerPaintColor: AppColorPhonetics.lightBlueColor4,
        outerPaintColor: AppColorPhonetics.lightBlueColor2),
  ];
}

class APhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

  @override
  BasicOfGameData? gameData;
  APhonetics({
    required this.mineGameData,
  }) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel = [
    TraceModel(
        dottedPath: ShapePaths.aDotted,
        dottedColor: AppColorPhonetics.white,
        indexColor: AppColorPhonetics.phonticGrey,
        indexPath: ShapePaths.aIndex,
        dottedPathPaintStyle: PaintingStyle.fill,
        indexPathPaintStyle: PaintingStyle.fill,
        scaleIndexPath: .3,
        poitionIndexPath: Size(50, -60),
        scaledottedPath: .9,
        letterPath: ShapePaths.aShape,
        strokeWidth: 65,
        pointsJsonFile: ShapePointsManger.aShape,
        innerPaintColor: AppColorPhonetics.lightBlueColor4,
        outerPaintColor: AppColorPhonetics.lightBlueColor2),
  ];
}

class FPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfA;

  @override
  BasicOfGameData? gameData;

  FPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class MPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfM;

  @override
  BasicOfGameData? gameData;

  MPhonetics({
    required this.mineGameData,
  }) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel = [
    TraceModel(
        dottedPath: ShapePaths.mDotted,
        strokeWidth: 70,
        dottedColor: AppColorPhonetics.white,
        indexColor: AppColorPhonetics.white,
        indexPath: ShapePaths.mIndex,
        scaleIndexPath: .9,
        scaledottedPath: .8,
        letterPath: ShapePaths.mshape,
        pointsJsonFile: ShapePointsManger.mShape,
        innerPaintColor: AppColorPhonetics.lightBlueColor4,
        outerPaintColor: AppColorPhonetics.lightBlueColor2),
  ];
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
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
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
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
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
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
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
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
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
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
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
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class TPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;

  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

  @override
  BasicOfGameData? gameData;
  TPhonetics({
    required this.mineGameData,
  }) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel = [
    TraceModel(
        dottedPath: ShapePaths.tshapeDotted,
        dottedColor: AppColorPhonetics.white,
        indexColor: AppColorPhonetics.phonticGrey,
        indexPath: ShapePaths.tshapeIndex,
        letterPath: ShapePaths.tShape,
        strokeWidth: 46,
        scaledottedPath: .8,
        scaleIndexPath: 1,
        poitionDottedPath: Size(0, 5),
        poitionIndexPath: Size(0, 10),
        dottedPathPaintStyle: PaintingStyle.fill,
        pointsJsonFile: ShapePointsManger.tShape,
        innerPaintColor: AppColorPhonetics.lightBlueColor4,
        outerPaintColor: AppColorPhonetics.lightBlueColor2),
  ];
}

class CPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfC;

  @override
  BasicOfGameData? gameData;
  CPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class RPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfR;

  @override
  BasicOfGameData? gameData;

  RPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class IPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfI;

  @override
  BasicOfGameData? gameData;

  IPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class PPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfP;

  @override
  BasicOfGameData? gameData;

  PPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class HPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfH;

  @override
  BasicOfGameData? gameData;

  HPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class JPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfJ;

  @override
  BasicOfGameData? gameData;

  JPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class UPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfU;

  @override
  BasicOfGameData? gameData;

  UPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class LPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfL;

  @override
  BasicOfGameData? gameData;

  LPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class BPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfB;

  @override
  BasicOfGameData? gameData;

  BPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class OPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = Colors.white.withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfO;

  @override
  BasicOfGameData? gameData;

  OPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class GPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfG;

  @override
  BasicOfGameData? gameData;

  GPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class DPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfD;

  @override
  BasicOfGameData? gameData;

  DPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  int? countOfPartsOfLettersForTracing;

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class WPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfW;

  @override
  BasicOfGameData? gameData;

  WPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class EPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfE;

  @override
  BasicOfGameData? gameData;

  EPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class NPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfN;

  @override
  BasicOfGameData? gameData;

  NPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class ShortVowels implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfShortVowels;

  @override
  BasicOfGameData? gameData;

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

  @override
  List<TraceModel>? lettersModel;
}

class UpVowels implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfShortVowels;

  @override
  BasicOfGameData? gameData;

  UpVowels({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class ConnectionWithoutSortingCups implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfGameData? gameData;

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

  @override
  List<TraceModel>? lettersModel;
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
  List<TraceModel>? lettersModel;
}

class RedPhonetics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfRedUnit;

  @override
  BasicOfGameData? gameData;

  RedPhonetics({required this.mineGameData, List<TraceModel>? lettersModel}) {
    gameData = mineGameData;
    print('lettersModel:${lettersModel?.length}');
    this.lettersModel = lettersModel;
  }

  @override
  bool? isArabic = true;

  @override
  List<TraceModel>? lettersModel;
}

class BlueUnit implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfBlueUnit;

  @override
  BasicOfGameData? gameData;

  BlueUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class GreenUnit implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfGreenUnit;

  @override
  BasicOfGameData? gameData;

  GreenUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class YellowUnit implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfYellowUnit;

  @override
  BasicOfGameData? gameData;

  YellowUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class VioletUnit implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfVioletUnit;

  @override
  BasicOfGameData? gameData;

  VioletUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}

class OrangeUnit implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfOrangeUnit;

  @override
  BasicOfGameData? gameData;

  OrangeUnit({required this.mineGameData}) {
    gameData = mineGameData;
  }
  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
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
  List<TraceModel>? lettersModel;
}

class FirstUnitArabic implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesArabic.bgOfFirstUnit;

  @override
  BasicOfGameData? gameData;

  FirstUnitArabic({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic = true;

  @override
  List<TraceModel>? lettersModel;
}

class RUnitArabic implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfGameData? gameData;

  RUnitArabic({required this.mineGameData, required String? subBackGround}) {
    gameData = mineGameData;
    background = subBackGround ?? background;
  }

  @override
  bool? isArabic = true;

  @override
  List<TraceModel>? lettersModel;
}

class RUnitPhonics implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfShortVowels;

  @override
  BasicOfGameData? gameData;

  RUnitPhonics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic = true;

  @override
  List<TraceModel>? lettersModel;
}

class ConsonantVowels implements MainDataOfChapters {
  final BasicOfGameData mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.ec3Bg;

  @override
  BasicOfGameData? gameData;

  ConsonantVowels({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  bool? isArabic;

  @override
  List<TraceModel>? lettersModel;
}
