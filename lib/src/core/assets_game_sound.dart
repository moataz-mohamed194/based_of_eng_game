import 'dart:math' hide log;

class AppGameSound {
  static const String mainPathOfSoundBase = 'sound/';

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

  static List ofSoundsOfCorrect = [
    youFoundItSound,
    youFoundItSound1,
    youFoundItSound2,
    youFoundItSound3,
    youFoundItSound4,
  ];

  static getRandomSoundOfCorrect() {
    Random random = Random();
    int randomIndex = random.nextInt(ofSoundsOfCorrect.length);
    return ofSoundsOfCorrect[randomIndex];
  }

  static List ofSoundsOfWrong = [
    notThatOneSound,
    notThatOneSound1,
  ];

  static getRandomSoundOfWrong() {
    Random random = Random();
    int randomIndex = random.nextInt(ofSoundsOfWrong.length);
    return ofSoundsOfWrong[randomIndex];
  }
}
