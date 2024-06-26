import '../assets_images_phonetics.dart';
import '../game_types/assets_images_arabic.dart';
import '../game_types/game_phonatics_types.dart';

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

  static getTheGameType({required String gameType, required int audioFlag}) {
    print('${gameType} == ${GameTypes.wordFamily.text()}');
    gameType.toLowerCase();
    if (gameType == GameTypes.dragOut.text()) {
      return BasicDragOutGame();
    }
    else if ((gameType == GameTypes.clickPicture.text()) && audioFlag == 1) {
      return ClickPictureOfWord();

      ///audio flag == 1 say the word
    }
    else if (gameType == GameTypes.clickPicture.text() && audioFlag == 0) {
      return ClickPicture();
    }
    else if (gameType == GameTypes.clickTheSound.text()) {
      return BasicClickTheSoundGame();
    }
    else if (gameType == GameTypes.bingo.text()) {
      return BingoGame();
    }
    else if (gameType == GameTypes.sortingCups.text()) {
      return SortingCupsGame();
    }
    else if (gameType == GameTypes.sortingPictures.text()) {
      return SortingPicturesGame();
    }
    else if (gameType == GameTypes.spelling.text()) {
      return SpellingGame();
    }
    else if (gameType == GameTypes.xOut.text()) {
      return XOutGame();
    }
    else if (gameType == GameTypes.dice.text()) {
      return DiceGame();
    }
    else if (gameType == GameTypes.tracing.text()) {
      return Tracking();
    }
    else if (gameType == GameTypes.video.text()) {
      return Video();
    }
    else if (gameType == GameTypes.spellingWord.text()) {
      return SpellingWordGame();
    }
    else if (gameType == GameTypes.dragPicToWord.text()) {
      return DragPicToWordGame();
    }
    else if (gameType == GameTypes.dragWordToPic.text()) {
      return DragWordToPicGame();
    }
    else if (gameType == GameTypes.wordFamily.text()) {
      print('WordFamilyGame');
      return WordFamilyGame();
    }
    else if (gameType == GameTypes.rearrange.text()) {
      print('WordFamilyGame');
      return RearrangeGame();
    }
    else if (gameType == GameTypes.match.text()) {
      print('WordFamilyGame');
      return MatchGame();
    }
  }

  static List listOfConnectGames = [
    GameTypes.bingo.text(),
    GameTypes.sortingPictures.text(),
    GameTypes.sortingCups.text(),
    GameTypes.dice.text(),
    GameTypes.xOut.text(),
    GameTypes.spelling.text(),
    GameTypes.spellingWord.text()
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

  @override
  String? completeBasket = AppImagesPhonetics.imageBasketComplete;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;

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
    AppImagesPhonetics.circleShape,
    AppImagesPhonetics.cloudShape,
    AppImagesPhonetics.diamondShape,
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
  @override
  bool isRound = false;

  @override
  String titleImageEn = AppImagesPhonetics.clickTheSound;

  @override
  String? completeBasket;

  @override
  bool isConnect = false;

  @override
  String? titleImageAr;

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

  List<String> backgroundImages = [
    AppImagesPhonetics.circleShape,
    AppImagesPhonetics.cloudShape,
    AppImagesPhonetics.diamondShape,
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
  String? titleImageAr;

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
  String? titleImageAr;

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
  String? titleImageAr;

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
  String? titleImageAr;

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
  String? titleImageAr;

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
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 1;
}

class DragWordToPicGame implements BasicOfGameData {
  @override
  bool isRound = true;

  @override
  String titleImageEn = AppImagesPhonetics.dragPicToWordGame;

  @override
  String? completeBasket;

  @override
  bool isConnect = true;

  @override
  String? titleImageAr;

  @override
  int countOfMinimizeStar = 1;
}

class WordFamilyGame implements BasicOfGameData {
  @override
  bool isRound = true;

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
  int countOfMinimizeStar = 1;
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
