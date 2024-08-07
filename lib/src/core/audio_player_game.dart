import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:based_of_eng_game/src/core/talk_tts.dart';

abstract class AudioPlayerGame {
  static AudioPlayer playerWrong = AudioPlayer();
  static AudioPlayer playerCorrect = AudioPlayer();
  static StateOfTalk data = StateOfTalk.stopped;
  static Future startPlaySoundOfWrong(
      {AudioPlayer? playerWrong2, required String soundPath}) async {
    try {
      data = StateOfTalk.talking;
      await (playerWrong2 ?? playerWrong).play(AssetSource(soundPath));
      await (playerWrong2 ?? playerWrong).setVolume(1);
      await (playerWrong2 ?? playerWrong).resume();
      (playerWrong2 ?? playerWrong)
          .onPlayerStateChanged
          .listen((PlayerState state) {
        if (state == PlayerState.completed) data = StateOfTalk.stopped;
      });
    } catch (e) {
      log('error:$e');
    }
  }

  static Future startPlaySoundOfCorrect(
      {AudioPlayer? playerCorrect2, required String soundPath}) async {
    try {
      data = StateOfTalk.talking;
      await (playerCorrect2 ?? playerCorrect).play(AssetSource(soundPath));
      await (playerCorrect2 ?? playerCorrect).setVolume(1);
      await (playerCorrect2 ?? playerCorrect).resume();
      (playerCorrect2 ?? playerCorrect)
          .onPlayerStateChanged
          .listen((PlayerState state) {
        if (state == PlayerState.completed) data = StateOfTalk.stopped;
      });
    } catch (e) {
      log('error:$e');
    }
  }

  static forceStopSound() async {
    await playerCorrect.stop();
    await playerWrong.stop();
  }
}
