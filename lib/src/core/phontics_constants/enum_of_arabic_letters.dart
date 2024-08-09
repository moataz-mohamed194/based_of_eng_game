import 'dart:ui';

import 'package:based_of_eng_game/src_model/model/trace_model.dart';

import '../phonetics_color.dart';
import 'arabis_shape_paths.dart';
import 'shape_points_manger.dart';

enum ArabicLetters {
  gem,
  sen,
  lam,
  ra2,
  ba2,
}

class TypeExtensionArabic {
  ArabicLetters _detectTheCurrentEnum({required String letter}) {
    if (letter == 'ج') {
      return ArabicLetters.gem;
    } else if (letter == 'س') {
      return ArabicLetters.sen;
    } else if (letter == 'ل') {
      return ArabicLetters.lam;
    } else if (letter == 'ر') {
      return ArabicLetters.ra2;
    } else if (letter == 'ب') {
      return ArabicLetters.ba2;
    } else {
      return ArabicLetters.gem;
    }
  }

  List<TraceModel> getTracingData({required String letter}) {
    ArabicLetters currentLetter = _detectTheCurrentEnum(letter: letter);

    switch (currentLetter) {
      case ArabicLetters.gem:
        return [
          TraceModel(
              poitionIndexPath: Size(-10, -25),
              poitionDottedPath: Size(-5, -5),
              scaledottedPath: .9,
              scaleIndexPath: .8,
              dottedPath: ArabicShapePaths.gemDotted,
              dottedColor: AppColorPhonetics.phonticGrey,
              indexColor: AppColorPhonetics.white,
              indexPath: ArabicShapePaths.gemIndex,
              letterPath: ArabicShapePaths.gemmm,
              pointsJsonFile: ShapePointsManger.gemShape,
              innerPaintColor: AppColorPhonetics.lightBlueColor4,
              outerPaintColor: AppColorPhonetics.lightBlueColor2),
          TraceModel(
              poitionIndexPath: Size(0, -30),
              poitionDottedPath: Size(-5, -15),
              scaledottedPath: .8,
              scaleIndexPath: .8,
              dottedPath: ArabicShapePaths.gemsmallDoottedPath,
              dottedColor: AppColorPhonetics.phonticGrey,
              indexColor: AppColorPhonetics.white,
              indexPath: ArabicShapePaths.gemSmallIndexPath,
              letterPath: ArabicShapePaths.gemSmall2,
              pointsJsonFile: ShapePointsManger.gemSmallShape,
              innerPaintColor: AppColorPhonetics.lightBlueColor4,
              outerPaintColor: AppColorPhonetics.lightBlueColor2),
        ];
      case ArabicLetters.lam:
        return [
          TraceModel(
              dottedPath: ArabicShapePaths.lamBigDottted2,
              dottedColor: AppColorPhonetics.white,
              indexColor: AppColorPhonetics.phonticGrey,
              indexPath: ArabicShapePaths.lamBigIndex2,
              poitionIndexPath: Size(8, 20),
              poitionDottedPath: Size(5, 15),
              scaledottedPath: .8,
              letterPath: ArabicShapePaths.lambig2,
              pointsJsonFile: ShapePointsManger.lamBigShape,
              innerPaintColor: AppColorPhonetics.lightBlueColor4,
              outerPaintColor: AppColorPhonetics.lightBlueColor2),
          TraceModel(
              dottedPath: ArabicShapePaths.lamSmallDotted,
              dottedColor: AppColorPhonetics.white,
              indexColor: AppColorPhonetics.phonticGrey,
              indexPath: ArabicShapePaths.lamSmallIndex,
              letterPath: ArabicShapePaths.lamsmall,
              poitionIndexPath: Size(20, 25),
              poitionDottedPath: Size(0, 15),
              scaledottedPath: .7,
              pointsJsonFile: ShapePointsManger.lamsmallShape,
              innerPaintColor: AppColorPhonetics.lightBlueColor4,
              outerPaintColor: AppColorPhonetics.lightBlueColor2),
        ];
      case ArabicLetters.ra2:
        return [];
      case ArabicLetters.ba2:
        return [];
      case ArabicLetters.sen:
        return [
          TraceModel(
              dottedPath: ArabicShapePaths.senBigDotted,
              dottedColor: AppColorPhonetics.white,
              indexColor: AppColorPhonetics.phonticGrey,
              indexPath: ArabicShapePaths.senBigIndex,
              letterPath: ArabicShapePaths.senBig,
              poitionIndexPath: Size(5, 5),
              scaleIndexPath: 1.1,
              pointsJsonFile: ShapePointsManger.senBigShape,
              innerPaintColor: AppColorPhonetics.lightBlueColor4,
              outerPaintColor: AppColorPhonetics.lightBlueColor2),
          TraceModel(
              dottedPath: ArabicShapePaths.senDotted3,
              dottedColor: AppColorPhonetics.white,
              indexColor: AppColorPhonetics.phonticGrey,
              indexPath: ArabicShapePaths.senIndex2,
              letterPath: ArabicShapePaths.sen2Small,
              poitionIndexPath: Size(5, 0),
              poitionDottedPath: Size(0, 5),
              scaleIndexPath: 1.1,
              scaledottedPath: .95,
              pointsJsonFile: ShapePointsManger.sensmallShape,
              innerPaintColor: AppColorPhonetics.lightBlueColor4,
              outerPaintColor: AppColorPhonetics.lightBlueColor2),
        ];
    }
  }
}
