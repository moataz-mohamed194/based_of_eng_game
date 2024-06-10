import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';

abstract class AudioPlayerLetters {
  static AudioPlayer player = AudioPlayer();
  static startPlaySound({required String soundPath}) async {
    print('soundPath:$soundPath');
    try {
      await player.play(AssetSource(soundPath));
      await player.setVolume(1);
      await player.resume();
    } catch (e) {
      log('error:$e');
    }
  }

  static forceStopSound() async {
    await player.stop();
  }
}
