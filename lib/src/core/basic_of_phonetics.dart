import 'package:flutter/material.dart';
import 'assets_images_phonetics.dart';
import 'basic_of_every_game.dart';

enum MainDataOfPhoneticsTypes {
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
  o,
  g,
  d,
  w,
  e,
  n
}

extension TypeExtensionOfMainDataOfPhoneticsTypes on MainDataOfPhoneticsTypes {
  String text() {
    switch (this) {
      case MainDataOfPhoneticsTypes.a:
        return "a".toLowerCase();
      case MainDataOfPhoneticsTypes.b:
        return 'b'.toLowerCase();
      case MainDataOfPhoneticsTypes.f:
        return 'f'.toLowerCase();
      case MainDataOfPhoneticsTypes.m:
        return 'm'.toLowerCase();
      case MainDataOfPhoneticsTypes.t:
        return 't'.toLowerCase();
      case MainDataOfPhoneticsTypes.c:
        return 'c'.toLowerCase();
      case MainDataOfPhoneticsTypes.i:
        return 'i'.toLowerCase();
      case MainDataOfPhoneticsTypes.g:
        return 'g'.toLowerCase();
      case MainDataOfPhoneticsTypes.o:
        return 'o'.toLowerCase();
      case MainDataOfPhoneticsTypes.j:
        return 'j'.toLowerCase();
      case MainDataOfPhoneticsTypes.l:
        return 'l'.toLowerCase();
      case MainDataOfPhoneticsTypes.u:
        return 'u'.toLowerCase();
      case MainDataOfPhoneticsTypes.h:
        return 'h'.toLowerCase();
      case MainDataOfPhoneticsTypes.p:
        return 'p'.toLowerCase();
      case MainDataOfPhoneticsTypes.r:
        return 'r'.toLowerCase();
      case MainDataOfPhoneticsTypes.s:
        return 's'.toLowerCase();
      case MainDataOfPhoneticsTypes.d:
        return 'd'.toLowerCase();
      case MainDataOfPhoneticsTypes.w:
        return 'w'.toLowerCase();
      case MainDataOfPhoneticsTypes.e:
        return 'e'.toLowerCase();
      case MainDataOfPhoneticsTypes.n:
        return 'n'.toLowerCase();
    }
  }
}

abstract class MainDataOfPhonetics {
  late String basicAvatar;
  late String winAvatar;
  late String idelAvatar;
  late String sadAvatar;
  late String background;
  BasicOfEveryGame? gameData;
  late Color backGroundOfStarBar;
  CustomPainter? Function(List<Color?>? colorsOfPaths)? get tracingOfLetter;
  int? Function(Offset point, Size size)? get checkTheIndexOfPath;
  late int? countOfPartsOfLettersForTracing = 0;

  static getGameDataType(
      {required String subLetter,
      required String subGame,
      required int audioFlag}) {
    if (BasicOfEveryGame.isConnectGame(game: subGame.toLowerCase()) == true) {
      if (subGame.toLowerCase() == GameTypes.sortingCups.text()) {
        return ConnectionSortingCups(mineGameData: SortingCupsGame());
      } else if (subGame.toLowerCase() == GameTypes.spelling.text()) {
        return SpellTheWord(mineGameData: SpellingGame());
      } else {
        return ConnectionWithoutSortingCups(
            mineGameData: BasicOfEveryGame.getTheGameType(
                gameType: subGame.toLowerCase(), audioFlag: audioFlag));
      }
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.s.text()) {
      return SPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.a.text()) {
      return APhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.f.text()) {
      return FPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.m.text()) {
      return MPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.t.text()) {
      return TPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.c.text()) {
      return CPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.r.text()) {
      return RPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.i.text()) {
      return IPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.p.text()) {
      return PPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.h.text()) {
      return HPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.j.text()) {
      return JPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.u.text()) {
      return UPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.l.text()) {
      return LPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.b.text()) {
      return BPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.o.text()) {
      return OPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.g.text()) {
      return GPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.d.text()) {
      return DPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.n.text()) {
      return NPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.w.text()) {
      return WPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfPhoneticsTypes.e.text()) {
      return EPhonetics(
          mineGameData: BasicOfEveryGame.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    }
  }
}

class SPhonetics implements MainDataOfPhonetics {
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfS;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  SPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing = 14;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
}

class APhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfA;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };
  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  APhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;
  @override
  int? countOfPartsOfLettersForTracing = 0;
}

class FPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };
  @override
  String background = AppImagesPhonetics.backGroundOfA;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  FPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class MPhonetics implements MainDataOfPhonetics {
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfM;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  MPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing = 16;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
}

class TPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfT;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  TPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class CPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfC;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  CPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class RPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfR;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  RPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class IPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfI;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  IPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class PPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfP;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  PPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class HPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfH;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  HPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class JPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfJ;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  JPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class UPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfJ;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  UPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class LPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfL;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  LPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class BPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfB;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  BPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class OPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = Colors.white.withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfO;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  OPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class GPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfG;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  GPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class DPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfD;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  DPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class WPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfW;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  WPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class EPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String background = AppImagesPhonetics.backGroundOfE;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  EPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class NPhonetics implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfN;

  @override
  String basicAvatar = AppImagesPhonetics.basicAvatarNormal;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  NPhonetics({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  int? countOfPartsOfLettersForTracing;
}

class ConnectionWithoutSortingCups implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;
  @override
  String basicAvatar = AppImagesPhonetics.basicBess;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;
  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  ConnectionWithoutSortingCups({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  int? countOfPartsOfLettersForTracing;
}

class ConnectionSortingCups implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  String basicAvatar = AppImagesPhonetics.basicBess;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  ConnectionSortingCups({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  int? countOfPartsOfLettersForTracing;
}

class SpellTheWord implements MainDataOfPhonetics {
  @override
  int? Function(Offset point, Size size)? get checkTheIndexOfPath =>
      (Offset point, Size size) {
        return null;
      };
  final BasicOfEveryGame mineGameData;
  @override
  Color backGroundOfStarBar = const Color(0xffFFFFFF).withOpacity(.1);

  @override
  String background = AppImagesPhonetics.backGroundOfConnect;

  @override
  BasicOfEveryGame? gameData;

  @override
  String winAvatar = AppImagesPhonetics.beeSuccess;

  SpellTheWord({required this.mineGameData}) {
    gameData = mineGameData;
  }

  @override
  String idelAvatar = AppImagesPhonetics.beeIdleRiv;
  @override
  String basicAvatar = AppImagesPhonetics.basicBess;

  @override
  String sadAvatar = AppImagesPhonetics.beeFailureRiv;

  @override
  CustomPainter? Function(List<Color?>? colorsOfPaths) get tracingOfLetter =>
      (List<Color?>? colorsOfPaths) {
        return null;
      };

  @override
  int? countOfPartsOfLettersForTracing;
}
