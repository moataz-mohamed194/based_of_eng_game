import 'dart:math' hide log;

class AppGameSound {
  static const String mainPathOfSoundBase = 'sound/base/';
  static const String mainPathOfArabicSoundBase = 'sound/arabic_base/';

  static const String l1 = '${mainPathOfArabicSoundBase}l1.mp3';
  static const String l2 = '${mainPathOfArabicSoundBase}l2.mp3';
  static const String l3 = '${mainPathOfArabicSoundBase}l3.mp3';
  static const String l4 = '${mainPathOfArabicSoundBase}l4.mp3';
  static const String w1 = '${mainPathOfArabicSoundBase}w1.mp3';
  static const String w2 = '${mainPathOfArabicSoundBase}w2.mp3';
  static const String w3 = '${mainPathOfArabicSoundBase}w3.mp3';
  static const String bingo = '${mainPathOfSoundBase}Bingo.mp3';
  static const String notThatOneSound =
      "${mainPathOfSoundBase}notThatOneSound.mp3";
  static const String notThatOneSound1 =
      "${mainPathOfSoundBase}notThatOneSound1.mp3";
  static const String youFoundItSound =
      "${mainPathOfSoundBase}youFoundItSound.mp3";
  static const String youFoundItSound1 =
      "${mainPathOfSoundBase}youFoundItSound1.mp3";
  static const String youFoundItSound2 =
      "${mainPathOfSoundBase}youFoundItSound2.mp3";
  static const String youFoundItSound3 =
      "${mainPathOfSoundBase}youFoundItSound3.mp3";
  static const String youFoundItSound4 =
      "${mainPathOfSoundBase}youFoundItSound4.mp3";

  static List ofSoundsOfCorrectAr = [
    w1,
    w2,
    w3,
  ];
  static List ofSoundsOfCorrect = [
    youFoundItSound,
    youFoundItSound1,
    youFoundItSound2,
    youFoundItSound3,
    youFoundItSound4,
  ];

  static getRandomSoundOfCorrect({bool? isArabic}) {
    Random random = Random();
    if (isArabic == true) {
      int randomIndex = random.nextInt(ofSoundsOfCorrectAr.length);
      return ofSoundsOfCorrectAr[randomIndex];
    }
    int randomIndex = random.nextInt(ofSoundsOfCorrect.length);
    return ofSoundsOfCorrect[randomIndex];
  }

  static List ofSoundsOfWrongAr = [
    l1,
    l2,
    l3,
    l4,
  ];
  static List ofSoundsOfWrong = [
    notThatOneSound,
    notThatOneSound1,
  ];

  static getRandomSoundOfWrong({bool? isArabic}) {
    Random random = Random();
    if (isArabic == true) {
      int randomIndex = random.nextInt(ofSoundsOfWrongAr.length);
      return ofSoundsOfWrongAr[randomIndex];
    }
    int randomIndex = random.nextInt(ofSoundsOfWrong.length);
    return ofSoundsOfWrong[randomIndex];
  }
}
