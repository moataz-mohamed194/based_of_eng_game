import '../game_types/game_phonatics_types.dart';
import 'basic_of_chapter.dart';
import 'basic_of_game_data.dart';

abstract class BaseOfGames {
  static List<int> getTheStarsAddState(int number) {
    if (number % 3 == 0) {
      return List.generate(3, (index) => (number / 3).round()).toList();
    } else {
      int lower = (number ~/ 3) * 3;
      int upper = lower + 3;
      int result = (number - lower < upper - number) ? lower : upper;
      if (result < number) {
        return [
          (result / 3).round(),
          (result / 3 + 1).round(),
          (result / 3).round()
        ];
      } else {
        return [
          (result / 3 - 1).round(),
          (result / 3).round(),
          (result / 3).round()
        ];
      }
    }
  }

  static String math = 'math';

  static List<Type> listOfChapterOfPhonetics = [
    SPhonetics,
    APhonetics,
    FPhonetics,
    MPhonetics,
    TPhonetics,
    CPhonetics,
    RPhonetics,
    IPhonetics,
    PPhonetics,
    HPhonetics,
    JPhonetics,
    UPhonetics,
    LPhonetics,
    BPhonetics,
    OPhonetics,
    GPhonetics,
    DPhonetics,
    WPhonetics,
    EPhonetics,
    NPhonetics,
    KPhonetics,
    QPhonetics,
    VPhonetics,
    XPhonetics,
    YPhonetics,
    ZPhonetics,
    // SpellTheWord,
    ConnectionSortingCups,
    ConnectionWithoutSortingCups
  ];

  static bool isPhonetics({required Type chapter}) {
    return listOfChapterOfPhonetics.contains(chapter);
  }

  static List<Type> listOfChapterOfArabic = [RedPhonetics];
  static bool isArabic({required Type chapter}) {
    return listOfChapterOfArabic.contains(chapter);
  }

  static getGameDataType(
      {required String subLetter,
      required String subGame,
      required String unitName,
      required String programName,
      required int audioFlag}) {
    print(
        'subLetter:$subLetter , subGame:$subGame , unitName:$unitName , programName:$programName , audioFlag:$audioFlag , ${(unitName.contains(MainDataOfChaptersTypes.consonant.text()))}');
    if (programName.toLowerCase() ==
        MainDataOfChaptersTypes.math.toString().toLowerCase()) {
      return MathProgram(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(),
              audioFlag: audioFlag,
              programName: programName));
    } else if (unitName
        .toLowerCase()
        .contains(MainDataOfChaptersTypes.shortVowels.text())) {
      return ShortVowels(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (unitName.contains(MainDataOfChaptersTypes.up.text())) {
      return UpVowels(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (unitName
        .toLowerCase()
        .contains(MainDataOfChaptersTypes.consonant.text().toLowerCase())) {
      return ConsonantVowels(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (BasicOfGameData.isConnectGame(game: subGame.toLowerCase()) ==
        true) {
      if (subGame.toLowerCase() == GameTypes.sortingCups.text()) {
        return ConnectionSortingCups(mineGameData: SortingCupsGame());
      } else {
        return ConnectionWithoutSortingCups(
            mineGameData: BasicOfGameData.getTheGameType(
                gameType: subGame.toLowerCase(), audioFlag: audioFlag));
      }
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.s.text()) {
      return SPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.s.text()) {
      return SPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.k.text()) {
      return KPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.q.text()) {
      return QPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.v.text()) {
      return VPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.x.text()) {
      return XPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.y.text()) {
      return YPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.z.text()) {
      return ZPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.a.text()) {
      return APhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.f.text()) {
      return FPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.m.text()) {
      return MPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.t.text()) {
      return TPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.c.text()) {
      return CPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.r.text()) {
      return RPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.i.text()) {
      return IPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.p.text()) {
      return PPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.h.text()) {
      return HPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.j.text()) {
      return JPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.u.text()) {
      return UPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.l.text()) {
      return LPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.b.text()) {
      return BPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.o.text()) {
      return OPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.g.text()) {
      return GPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.d.text()) {
      return DPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.n.text()) {
      return NPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.w.text()) {
      return WPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (subLetter.toLowerCase() == MainDataOfChaptersTypes.e.text()) {
      return EPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (unitName.toLowerCase() ==
        MainDataOfChaptersTypes.redUnit.text()) {
      return RedPhonetics(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(),
              audioFlag: audioFlag,
              programName: programName));
    } else if (programName.toLowerCase() == math) {
      return MathProgram(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(),
              audioFlag: audioFlag,
              programName: programName));
    }
    return null;
  }
}
