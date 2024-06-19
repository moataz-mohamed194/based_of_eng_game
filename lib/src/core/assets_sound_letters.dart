abstract class AssetsSoundLetters {
  static const String mainPathOfSound = 'letters/';

  static String getPathOfLetter({required String letter}) {
    return "$mainPathOfSound$letter.mp3";
  }

  static getSoundOfLetter({required String mainGameLetter}) {
    return getPathOfLetter(letter: mainGameLetter.toLowerCase());
  }
}