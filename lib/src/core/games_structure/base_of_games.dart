import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import '../game_types/assets_images_math.dart';
import '../game_types/game_phonatics_types.dart';
import 'basic_of_chapter.dart';
import 'basic_of_game_data.dart';
import 'enum_chapters.dart';
import 'enum_levels_for_students.dart';
import 'enum_programs.dart';

abstract class HandlingActionsAndDataOfChapters {
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

  static List<Type> listOfChapterOfArabic = [
    RedPhonetics,
    OrangeUnit,
    GreenUnit,
    BlueUnit,
    VioletUnit,
    YellowUnit,
    FirstUnitArabic
  ];
  static bool isArabic({required Type chapter}) {
    return listOfChapterOfArabic.contains(chapter);
  }

  static String? detectTheArabicChapter(
      {required String programName, required BasicOfGameData gameData}) {
    if (programName.toLowerCase() == MainDataOfChaptersTypes.redUnit.text()) {
      return RedPhonetics(mineGameData: gameData).background;
    } else if (programName.toLowerCase() ==
        MainDataOfChaptersTypes.longVowelsArabic.text()) {
      return FirstUnitArabic(mineGameData: gameData).background;
    } else if (programName.toLowerCase() ==
        MainDataOfChaptersTypes.greenUnit.text()) {
      return GreenUnit(mineGameData: gameData).background;
    } else if (programName.toLowerCase() ==
        MainDataOfChaptersTypes.yellowUnit.text()) {
      return YellowUnit(mineGameData: gameData).background;
    } else if (programName.toLowerCase() ==
        MainDataOfChaptersTypes.violetUnit.text()) {
      return VioletUnit(mineGameData: gameData).background;
    } else if (programName.toLowerCase() ==
        MainDataOfChaptersTypes.orangeUnit.text()) {
      return OrangeUnit(mineGameData: gameData).background;
    } else if (programName.toLowerCase() ==
        MainDataOfChaptersTypes.blueUnit.text()) {
      return BlueUnit(mineGameData: gameData).background;
    }
    return null;
  }

  static chooseTheMathChapter(
      {required String stageName,
      required String subGame,
      required int audioFlag,
      required String programName}) {
    if (stageName == LevelsForStudents.ec1.text().toLowerCase()) {
      return MathProgram(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(),
              audioFlag: audioFlag,
              programName: programName),
          background: AppImagesMath.mathBg);
    } else if (stageName.toLowerCase() ==
        LevelsForStudents.ec2.text().toLowerCase()) {
      return MathProgram(
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(),
              audioFlag: audioFlag,
              programName: programName),
          background: AppImagesMath.mathBgEC2);
    } else if (stageName.toLowerCase() ==
        LevelsForStudents.ec3.text().toLowerCase()) {
      return MathProgram(
          background: AppImagesMath.mathBgEC2,
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(),
              audioFlag: audioFlag,
              programName: programName));
    }
    return null;
  }

  static Map<String, Type> mapOfPhonetics = {
    MainDataOfChaptersTypes.s.text(): SPhonetics,
    MainDataOfChaptersTypes.k.text(): KPhonetics,
    MainDataOfChaptersTypes.q.text(): QPhonetics,
    MainDataOfChaptersTypes.v.text(): VPhonetics,
    MainDataOfChaptersTypes.x.text(): XPhonetics,
    MainDataOfChaptersTypes.y.text(): YPhonetics,
    MainDataOfChaptersTypes.z.text(): ZPhonetics,
    MainDataOfChaptersTypes.a.text(): FPhonetics,
    MainDataOfChaptersTypes.f.text(): ZPhonetics,
    MainDataOfChaptersTypes.m.text(): MPhonetics,
    MainDataOfChaptersTypes.t.text(): TPhonetics,
    MainDataOfChaptersTypes.c.text(): CPhonetics,
    MainDataOfChaptersTypes.r.text(): RPhonetics,
    MainDataOfChaptersTypes.i.text(): IPhonetics,
    MainDataOfChaptersTypes.p.text(): PPhonetics,
    MainDataOfChaptersTypes.h.text(): HPhonetics,
    MainDataOfChaptersTypes.j.text(): JPhonetics,
    MainDataOfChaptersTypes.u.text(): UPhonetics,
    MainDataOfChaptersTypes.l.text(): LPhonetics,
    MainDataOfChaptersTypes.b.text(): BPhonetics,
    MainDataOfChaptersTypes.o.text(): OPhonetics,
    MainDataOfChaptersTypes.g.text(): GPhonetics,
    MainDataOfChaptersTypes.d.text(): DPhonetics,
    MainDataOfChaptersTypes.n.text(): NPhonetics,
    MainDataOfChaptersTypes.w.text(): WPhonetics,
    MainDataOfChaptersTypes.e.text(): EPhonetics,
    MainDataOfChaptersTypes.up.text(): UpVowels,
    MainDataOfChaptersTypes.rUnitPhonics.text(): RUnitPhonics,
    MainDataOfChaptersTypes.consonant.text(): ConsonantVowels
  };
  static chooseThePhoneticsChapter(
      {required String subLetter,
      required String subGame,
      required String unitName,
      required int audioFlag,
      required String programName}) {
    Type? foundValue;
    if ((unitName.contains(
            MainDataOfChaptersTypes.rUnitPhonics.text().toLowerCase())) ||
        (unitName.contains(MainDataOfChaptersTypes.up.text().toLowerCase())) ||
        (unitName.contains(
            MainDataOfChaptersTypes.consonant.text().toLowerCase()))) {
      foundValue = mapOfPhonetics.entries
          .firstWhere((entry) => unitName.contains(entry.key))
          .value;
    } else {
      foundValue = mapOfArabic[subLetter];
    }
    return foundValue;
  }

  static Map<String, Type> mapOfArabic = {
    MainDataOfChaptersTypes.redUnit.text(): RedPhonetics,
    MainDataOfChaptersTypes.greenUnit.text(): GreenUnit,
    MainDataOfChaptersTypes.blueUnit.text(): BlueUnit,
    MainDataOfChaptersTypes.violetUnit.text(): VioletUnit,
    MainDataOfChaptersTypes.orangeUnit.text(): OrangeUnit,
    MainDataOfChaptersTypes.yellowUnit.text(): YellowUnit,
    MainDataOfChaptersTypes.longVowelsArabic.text(): FirstUnitArabic
  };

  ///todo remove the game name
  static chooseTheArabicChapter(
      {required String unitName,
      required int audioFlag,
      required String subGame,
      required String gameName}) {
    Type? foundValue;
    if (unitName.toLowerCase().contains(
            MainDataOfChaptersTypes.rUnitArabic.text().toLowerCase()) ||
        unitName
            .toLowerCase()
            .contains(MainDataOfChaptersTypes.longVowelsArabic.text())) {
      foundValue = mapOfArabic.entries
          .firstWhere((entry) => unitName.contains(entry.key))
          .value;
    } else {
      foundValue = (mapOfArabic[unitName]);
    }
    return foundValue;
  }

  static getTheChapterDataType({
    required String subLetter,
    required String subGame,
    required String unitName,
    required String programName,
    required int audioFlag,
    required String lessonName,
    required String stageName,
    required String gameName,
  }) {
    if (programName.toLowerCase() ==
        ProgramsForStudents.math.text().toLowerCase()) {
      return chooseTheMathChapter(
          stageName: stageName,
          subGame: subGame,
          audioFlag: audioFlag,
          programName: programName);
    } else if (unitName
        .toLowerCase()
        .contains(MainDataOfChaptersTypes.shortVowels.text())) {
      return ShortVowels(
          isArabicSub:
              BasicOfGameData.enumValues.contains(programName.toLowerCase()),
          subBackGround: detectTheArabicChapter(
              programName: unitName,
              gameData: BasicOfGameData.getTheGameType(
                  gameType: subGame.toLowerCase(), audioFlag: audioFlag)),
          mineGameData: BasicOfGameData.getTheGameType(
              gameType: subGame.toLowerCase(), audioFlag: audioFlag));
    } else if (BasicOfGameData.isConnectGame(game: subGame.toLowerCase()) ==
        true) {
      if ((subGame.toLowerCase() == GameTypes.sortingCups.text())) {
        return ConnectionSortingCups(
            isArabicSub:
                BasicOfGameData.enumValues.contains(programName.toLowerCase()),
            subBackGround: detectTheArabicChapter(
                programName: unitName, gameData: SortingCupsGame()),
            mineGameData: SortingCupsGame());
      } else {
        return ConnectionWithoutSortingCups(
            isArabicSub:
                BasicOfGameData.enumValues.contains(programName.toLowerCase()),
            subBackGround: detectTheArabicChapter(
                programName: unitName,
                gameData: BasicOfGameData.getTheGameType(
                    gameType: subGame.toLowerCase(), audioFlag: audioFlag)),
            mineGameData: BasicOfGameData.getTheGameType(
                gameType: subGame.toLowerCase(), audioFlag: audioFlag));
      }
    } else if (programName.toLowerCase() ==
        ProgramsForStudents.phonics.text()) {
      return chooseThePhoneticsChapter(
          subLetter: subLetter,
          subGame: subGame,
          audioFlag: audioFlag,
          unitName: unitName,
          programName: programName);
    } else if (programName.toLowerCase() == ProgramsForStudents.arabic.text()) {
      return chooseTheArabicChapter(
          unitName: unitName,
          audioFlag: audioFlag,
          subGame: subGame,
          gameName: gameName);
    }
    return null;
  }
}
