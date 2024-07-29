import '../assets_images_phonetics.dart';
import '../game_types/assets_images_arabic.dart';
import '../game_types/assets_images_math.dart';
import '../game_types/game_phonatics_types.dart';
import '../game_types/programs_name_rtl.dart';

abstract class BasicOfGameData {
  late bool isRound;
  late String titleImageEn;
  late String? titleImageAr;
  late String? completeBasket;
  late int countOfMinimizeStar;
  static String connect = 'Connect';
  static String stateOIdle = 'idle';
  static String stateOfWin = 'win';
  static String stateOfSad = 'sad';
  bool isConnect = false;
  static List<String> enumValues =
      ProgramsNameWillRTL.values.map((e) => e.text()).toList();

  static getTheGameType(
      {required String gameType,
      required int audioFlag,
      String? programName,
      String? gameName}) {
    print('${gameType} == ${GameTypes.wordFamily.text()}');
    gameType.toLowerCase();
    if (gameType == GameTypes.dragOut.text()) {
      return BasicDragOutGame(isArabic: enumValues.contains(programName));
    } else if ((gameType == GameTypes.clickPicture.text()) && audioFlag == 1) {
      return ClickPictureOfWord(isArabic: enumValues.contains(programName));

      ///audio flag == 1 say the word
    } else if (gameType == GameTypes.clickPicture.text() && audioFlag == 0) {
      return ClickPicture();
    } else if (gameType == GameTypes.clickTheSound.text()) {
      return BasicClickTheSoundGame(isArabic: enumValues.contains(programName));
    } else if (gameType == GameTypes.bingo.text()) {
      return BingoGame();
    } else if (gameType == GameTypes.sortingCups.text()) {
      return SortingCupsGame();
    } else if (gameType == GameTypes.sortingCupsUP.text()) {
      return SortingCupsGame();
    } else if (gameType == GameTypes.sortingPictures.text()) {
      return SortingPicturesGame();
    } else if (gameType == GameTypes.spelling.text()) {
      return SpellingGame();
    } else if (gameType == GameTypes.xOut.text()) {
      return XOutGame();
    } else if (gameType == GameTypes.dice.text()) {
      return DiceGame();
    } else if (gameType == GameTypes.tracing.text()) {
      return Tracking();
    } else if (gameType == GameTypes.video.text()) {
      return Video();
    } else if (gameType == GameTypes.spellingWord.text()) {
      return SpellingWordGame();
    } else if (gameType == GameTypes.dragPicToWord.text()) {
      return DragPicToWordGame();
    } else if (gameType == GameTypes.dragWordToPic.text()) {
      return DragWordToPicGame(isArabic: enumValues.contains(programName));
    } else if (gameType == GameTypes.wordFamily.text()) {
      print('WordFamilyGame');
      return WordFamilyGame();
    } else if (gameType == GameTypes.rearrange.text()) {
      print('WordFamilyGame');
      return RearrangeGame();
    } else if (gameType == GameTypes.match.text()) {
      print('WordFamilyGame');
      return MatchGame();
    } else if (gameType == GameTypes.listenAndChoose.text()) {
      return ListenAndChooseGame();
    } else if (gameType == GameTypes.clickTheWord.text()) {
      return ClickTheWordGame();
    } else if (gameType == GameTypes.chooseTheSentence.text()) {
      return ChooseTheSentenceGame();
    } else if (gameType == GameTypes.chooseTheCorrect.text()) {
      return ChooseTheCorrectGame();
    } else if (gameType == GameTypes.ninePicCards.text()) {
      return DragWordToPicGame(isArabic: enumValues.contains(programName));
    } else if (gameType == GameTypes.mathChooseSticks.text()) {
      return MathChooseSticksOrBeadsOrBlocks(tools: ToolsOfMath.sticks);
    } else if (gameType == GameTypes.mathChooseBeads.text()) {
      return MathChooseSticksOrBeadsOrBlocks(tools: ToolsOfMath.beads);
    } else if (gameType == GameTypes.mathChooseBlocks.text()) {
      return MathChooseSticksOrBeadsOrBlocks(tools: ToolsOfMath.blocks);
    } else if (gameType == GameTypes.mathChooseBeadsNumber.text()) {
      return MathChooseNumberSticksOrBeadsOrBlocks(tools: ToolsOfMath.beads);
    } else if (gameType == GameTypes.mathChooseBlocksNumber.text()) {
      return MathChooseNumberSticksOrBeadsOrBlocks(tools: ToolsOfMath.blocks);
    } else if (gameType == GameTypes.mathChooseDominoNumber.text()) {
      return MathChooseNumberSticksOrBeadsOrBlocks(tools: ToolsOfMath.domino);
    } else if (gameType == GameTypes.mathSortingBlocks.text()) {
      return MathSortingSticksOrBeadsOrBlocks(tools: ToolsOfMath.blocks);
    } else if (gameType == GameTypes.mathChooseDomino.text()) {
      return MathChooseSticksOrBeadsOrBlocks(tools: ToolsOfMath.domino);
    } else if (gameType == GameTypes.chooseCorrectWordArabic.text()) {
      return ChooseTheCorrectImageOrLetter(isImage: true);
    } else if (gameType == GameTypes.chooseFormationArabic.text()) {
      return ChooseTheCorrectImageOrLetter(
          isImage: false,
          isTashkeel: gameName == GameTypes.chooseFormationArabic.text());
    } else if (gameType == GameTypes.matchingArabic.text()) {
      return MatchingArabic();
    } else if (gameType == GameTypes.mathChooseDominoOE.text()) {
      return MathChooseOEDomino(tools: ToolsOfMath.domino);
    } else if (gameType == GameTypes.mathDragDominoOE.text()) {
      return MathDragDominoOE(tools: ToolsOfMath.domino);
    } else if (gameType == GameTypes.mathDragBlocksOE.text()) {
      return MathDragDominoOE(tools: ToolsOfMath.blocks);
    } else if (gameType == GameTypes.mathChooseBeadsOE.text()) {
      return MathChooseBeadsOE(tools: ToolsOfMath.beads);
    } else if (gameType == GameTypes.mathDragSticks.text()) {
      return MathDragSticks();
    } else if (gameType == GameTypes.mathChooseBlocksAdd.text()) {
      return MathChooseBlocksAdd(tools: ToolsOfMath.blocks);
    } else if (gameType == GameTypes.mathChooseBeadsAdd.text()) {
      return MathChooseBlocksAdd(tools: ToolsOfMath.beads);
    } else if (gameType == GameTypes.mathChooseBlocksAddLine.text()) {
      return MathChooseBlocksAddLine(tools: ToolsOfMath.blocks);
    } else if (gameType == GameTypes.mathChooseBeadsAddLine.text()) {
      return MathChooseBeadsAddLine(tools: ToolsOfMath.beads);
    } else if (gameType == GameTypes.mathDragBlocksAdd.text()) {
      return MathDragBlocksAdd(tools: ToolsOfMath.blocks);
    } else if (gameType == GameTypes.mathDragBeadsAdd.text()) {
      return MathSortingBeads(tools: ToolsOfMath.beads);
    } else if (gameType == GameTypes.mathChooseBlocksSub.text()) {
      return MathChooseBlocksSub(tools: ToolsOfMath.blocks);
    } else if (gameType == GameTypes.mathDragBlocksSub.text()) {
      return MathDragBlocksSub(tools: ToolsOfMath.blocks);
    } else if (gameType == GameTypes.bingoArabic.text()) {
      return BingoArabicGame();
    } else if (gameType == GameTypes.completeTheWord.text()) {
      return CompleteTheWord();
    } else if (gameType == GameTypes.chooseTheStretchedLetter.text()) {
      return ChooseTheStretchedLetter();
    } else if (gameType == GameTypes.memoryCards.text()) {
      return MemoryCard();
    }
  }

  static List listOfConnectGames = [
    GameTypes.bingo.text(),
    GameTypes.sortingPictures.text(),
    GameTypes.sortingCups.text(),
    GameTypes.dice.text(),
    GameTypes.xOut.text(),
    GameTypes.spelling.text(),
    GameTypes.spellingWord.text(),
    GameTypes.bingoArabic.text()
  ];

  static bool isConnectGame({required String game}) {
    if (listOfConnectGames.contains(game)) {
      return true;
    } else {
      return false;
    }
  }

  static List<String> customOrderOfGamesPhonetics = [
    "${GameTypes.video.text().toLowerCase()}_0",
    "${GameTypes.tracing.text().toLowerCase()}_1",
    "${GameTypes.clickTheSound.text().toLowerCase()}_1",
    "${GameTypes.clickPicture.text().toLowerCase()}_1",
    "${GameTypes.dragOut.text().toLowerCase()}_1",
    "${GameTypes.clickPicture.text().toLowerCase()}_0",
  ];

  static List<String> customOrderOfGamesConnect = [
    "${GameTypes.sortingCups.text().toLowerCase()}_1",
    "${GameTypes.bingo.text().toLowerCase()}_1",
    "${GameTypes.sortingPictures.text().toLowerCase()}_1",
    "${GameTypes.dice.text().toLowerCase()}_1",
    "${GameTypes.xOut.text().toLowerCase()}_1",
    "${GameTypes.spelling.text().toLowerCase()}_1",
  ];
}

class BasicDragOutGame implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.dragOut;

  bool isArabic;
  @override
  String? completeBasket = AppImagesPhonetics.imageBasketComplete;
  BasicDragOutGame({required this.isArabic});
  @override
  bool isConnect = false;

  @override
  String? titleImageAr = AppImagesArabic.titleOfXOut;

  @override
  int countOfMinimizeStar = 2;
}

class ClickPicture implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.clickPicture;

  @override
  String? completeBasket;
  List<String> backgroundImages = [
    // AppImagesPhonetics.circleShape,
    // AppImagesPhonetics.cloudShape,
    // AppImagesPhonetics.diamondShape,
    AppImagesPhonetics.hexagonShape,
    AppImagesPhonetics.hexagonShape,
    AppImagesPhonetics.hexagonShape,
    AppImagesPhonetics.hexagonShape,
  ];

  List<String> getBackGround(int length) {
    if (length <= backgroundImages.length) {
      return backgroundImages.sublist(0, length);
    } else {
      List<String> newList = [];
      for (int i = 0; i < backgroundImages.length; i++) {
        newList.add(backgroundImages[i]);
        if (i == backgroundImages.length - 1) {
          i = 0;
        }
        if (newList.length == length) {
          break;
        }
      }

      return newList;
    }
  }

  @override
  bool isConnect = false;

  @override
  String? titleImageAr = AppImagesArabic.titleOfClickThePicture;

  @override
  int countOfMinimizeStar = 1;
}

class Tracking implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.tracingWithFinger;

  // @override
  // String keyGame = 'Click the picture';

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 1;
}

class Video implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.tracingWithFinger;

  // @override
  // String keyGame = 'Click the picture';

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 1;
}

class BasicClickTheSoundGame implements BasicOfGameData {
  bool isArabic;

  BasicClickTheSoundGame({required this.isArabic});
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.clickTheSound;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr = AppImagesArabic.clickTheSound;

  @override
  int countOfMinimizeStar = 1;
}

class ClickPictureOfWord implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.clickPictureWithWord;

  @override
  String? completeBasket;
  bool isArabic;
  ClickPictureOfWord({required this.isArabic});
  List<String> backgroundImages = [
    // AppImagesPhonetics.circleShape,
    // AppImagesPhonetics.cloudShape,
    // AppImagesPhonetics.diamondShape,
    AppImagesPhonetics.hexagonShape,
    AppImagesPhonetics.hexagonShape,
    AppImagesPhonetics.hexagonShape,
    AppImagesPhonetics.hexagonShape,
  ];

  List<String> getBackGround(int length) {
    if (length <= backgroundImages.length) {
      return backgroundImages.sublist(0, length);
    } else {
      List<String> newList = [];
      for (int i = 0; i < backgroundImages.length; i++) {
        newList.add(backgroundImages[i]);
        if (i == backgroundImages.length - 1) {
          i = 0;
        }
        if (newList.length == length) {
          break;
        }
      }

      return newList;
    }
  }

  @override
  bool isConnect = false;

  @override
  String? titleImageAr = AppImagesArabic.titleOfClickThePicture;

  @override
  int countOfMinimizeStar = 1;
}

class BingoGame implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.bingoNameGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 1;
}

class SortingCupsGame implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.sortingCupsNameGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr = AppImagesArabic.titleOfSortingCups;

  @override
  int countOfMinimizeStar = 2;
}

class SortingPicturesGame implements BasicOfGameData {
  @override
  bool isRound = true;

  @override
  String titleImageEn = AppImagesPhonetics.sortingGame;
  String woodenBackground = AppImagesPhonetics.woodBackground;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr = AppImagesArabic.titleOfSortingPictures;

  @override
  int countOfMinimizeStar = 2;
}

class SpellingGame implements BasicOfGameData {
  @override
  bool isRound = true;

  @override
  String titleImageEn = AppImagesPhonetics.spellingNameGame;

  String woodenBackground = AppImagesPhonetics.woodBackground;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr = AppImagesArabic.titleOfSpelling;

  @override
  int countOfMinimizeStar = 2;
}

class XOutGame implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.xOutGameName;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr = AppImagesArabic.titleOfXOut;

  @override
  int countOfMinimizeStar = 2;
}

class DiceGame implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.diceNameGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 2;
}

class SpellingWordGame implements BasicOfGameData {
  @override
  bool isRound = true;

  @override
  String titleImageEn = AppImagesPhonetics.spellingWordGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr;
  String woodenBackground = AppImagesPhonetics.woodBackground;

  @override
  int countOfMinimizeStar = 2;
}

class DragPicToWordGame implements BasicOfGameData {
  @override
  bool isRound = true;

  @override
  String titleImageEn = AppImagesPhonetics.dragPicToWordGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr = AppImagesArabic.titleOfDragAndDrop;

  @override
  int countOfMinimizeStar = 1;
}

class DragWordToPicGame implements BasicOfGameData {
  bool isArabic;

  DragWordToPicGame({required this.isArabic});
  @override
  bool isRound = true;

  @override
  String titleImageEn = AppImagesPhonetics.dragPicToWordGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr = AppImagesArabic.titleOfDragAndDrop;

  @override
  int countOfMinimizeStar = 1;
}

class WordFamilyGame implements BasicOfGameData {
  @override
  bool isRound = false;

  String woodenBackground = AppImagesPhonetics.woodBackground;

  @override
  String titleImageEn = AppImagesPhonetics.wordFamilyGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 2;
}

class RearrangeGame implements BasicOfGameData {
  @override
  bool isRound = true;

  @override
  String titleImageEn = AppImagesPhonetics.rearrangeGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 2;
}

class MatchGame implements BasicOfGameData {
  @override
  bool isRound = true;

  @override
  String titleImageEn = AppImagesPhonetics.matchGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 1;
}

class MatchingArabic implements BasicOfGameData {
  @override
  bool isRound = true;

  @override
  String titleImageEn = AppImagesArabic.titleOfMatching;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr = AppImagesArabic.titleOfMatching;

  @override
  int countOfMinimizeStar = 1;
}

class ListenAndChooseGame implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.listenAndChooseGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 1;
}

class ClickTheWordGame implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.clickTheWordGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 2;
}

class ChooseTheSentenceGame implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.chooseTheSentenceGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 1;
}

class ChooseTheStretchedLetter implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = '';

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr = AppImagesArabic.titleOfChooseTheStretchedLetter;
  @override
  int countOfMinimizeStar = 1;
}

class MemoryCard implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.listenAndChooseGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  @override
  int countOfMinimizeStar = 2;
}

class CompleteTheWord implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = '';

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr = AppImagesArabic.titleOfCompleteTheWord;
  @override
  int countOfMinimizeStar = 1;
}

class ChooseTheCorrectGame implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.chooseTheCorrectGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 1;
}

class ChooseTheCorrectImageOrLetter implements BasicOfGameData {
  bool isImage;
  bool isTashkeel;
  ChooseTheCorrectImageOrLetter(
      {this.isImage = false, this.isTashkeel = false}) {
    titleImageAr = isImage
        ? AppImagesArabic.titleOfChooseTheCorrectImage
        : isTashkeel
            ? AppImagesArabic.titleOfA5tarElTashkeel
            : AppImagesArabic.titleOfChooseTheCorrectLetter;
  }
  @override
  String? completeBasket;

  @override
  int countOfMinimizeStar = 2;

  @override
  bool isConnect = false;

  @override
  bool isRound = false;

  @override
  String? titleImageAr;
  @override
  String titleImageEn = '';
}

class MathChooseSticksOrBeadsOrBlocks implements BasicOfGameData {
  @override
  bool isRound = false;
  MathChooseSticksOrBeadsOrBlocks({required this.tools});

  @override
  String titleImageEn = AppImagesMath.clickTheChoose;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathChooseNumberSticksOrBeadsOrBlocks implements BasicOfGameData {
  @override
  bool isRound = false;
  MathChooseNumberSticksOrBeadsOrBlocks({required this.tools});

  @override
  String titleImageEn = AppImagesMath.clickTheChoose;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathSortingSticksOrBeadsOrBlocks implements BasicOfGameData {
  @override
  bool isRound = false;
  MathSortingSticksOrBeadsOrBlocks({required this.tools});

  @override
  String titleImageEn = AppImagesMath.mathDragDrop;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathSortingBeads implements BasicOfGameData {
  @override
  bool isRound = false;
  MathSortingBeads({required this.tools});

  @override
  String titleImageEn = AppImagesMath.mathDragDrop;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathChooseBlocksSub implements BasicOfGameData {
  @override
  bool isRound = false;
  MathChooseBlocksSub({required this.tools});

  @override
  String titleImageEn = AppImagesMath.clickTheChoose;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathDragBlocksSub implements BasicOfGameData {
  @override
  bool isRound = false;
  MathDragBlocksSub({required this.tools});

  @override
  String titleImageEn = AppImagesMath.clickTheChoose;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathChooseOEDomino implements BasicOfGameData {
  @override
  bool isRound = false;
  MathChooseOEDomino({required this.tools});

  @override
  String titleImageEn = AppImagesMath.clickTheChoose;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathDragDominoOE implements BasicOfGameData {
  @override
  bool isRound = false;
  MathDragDominoOE({required this.tools});

  @override
  String titleImageEn = AppImagesMath.clickTheChoose;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathChooseBeadsOE implements BasicOfGameData {
  @override
  bool isRound = false;
  MathChooseBeadsOE({required this.tools});

  @override
  String titleImageEn = AppImagesMath.clickTheChoose;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathChooseBlocksAdd implements BasicOfGameData {
  @override
  bool isRound = false;
  MathChooseBlocksAdd({required this.tools});

  @override
  String titleImageEn = AppImagesMath.clickTheChoose;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathDragBlocksAdd implements BasicOfGameData {
  @override
  bool isRound = false;
  MathDragBlocksAdd({required this.tools});

  @override
  String titleImageEn = AppImagesMath.mathDragDrop;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathChooseBlocksAddLine implements BasicOfGameData {
  @override
  bool isRound = false;
  MathChooseBlocksAddLine({required this.tools});

  @override
  String titleImageEn = AppImagesMath.clickTheChoose;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathDragSticks implements BasicOfGameData {
  @override
  bool isRound = false;
  MathDragSticks();

  @override
  String titleImageEn = AppImagesMath.mathDragDrop;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class MathChooseBeadsAddLine implements BasicOfGameData {
  @override
  bool isRound = false;
  MathChooseBeadsAddLine({required this.tools});

  @override
  String titleImageEn = AppImagesMath.clickTheChoose;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;
  late ToolsOfMath tools;
  @override
  int countOfMinimizeStar = 1;
}

class BingoArabicGame implements BasicOfGameData {
  @override
  bool isRound = false;

  @override
  String titleImageEn = '';

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr = '';

  @override
  int countOfMinimizeStar = 1;
}
