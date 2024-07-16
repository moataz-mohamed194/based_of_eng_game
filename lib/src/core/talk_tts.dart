import 'package:flutter_tts/flutter_tts.dart';

enum StateOfTalk { talking, stopped }

abstract class TalkTts {
  static FlutterTts flutterTts = FlutterTts();

  static StateOfTalk data = StateOfTalk.talking;
  static Future startTalk(
      {required String text,
      Function? actionOfStart,
      Function? actionPause,
      Function? actionCancel,
      bool? isArabic,
      Function? actionComplete}) async {
    print('object:$text');
    if (isArabic == true) {
      await flutterTts.setLanguage("ar");
    } else {
      await flutterTts.setLanguage("en-US");
    }
    flutterTts.setPitch(1.0);
    flutterTts.setSpeechRate(0.4);
    flutterTts.setStartHandler(() {
      data = StateOfTalk.talking;
      if (actionOfStart != null) {
        actionOfStart();
      }
    });
    flutterTts.setCompletionHandler(() {
      data = StateOfTalk.stopped;

      if (actionComplete != null) {
        actionComplete();
      }
    });
    flutterTts.setCancelHandler(() {
      data = StateOfTalk.stopped;
      if (actionCancel != null) {
        actionCancel();
      }
    });
    flutterTts.setPauseHandler(() {
      data = StateOfTalk.stopped;

      if (actionPause != null) {
        actionPause();
      }
    });
    flutterTts.awaitSpeakCompletion(true);
    await flutterTts.speak(text);
    data = StateOfTalk.stopped;
  }

  static stopTalk() async {
    await flutterTts.stop();
  }

  static reBackTheDefaultValue() {
    data = StateOfTalk.talking;
  }

  static reStopTheDefaultValue() {
    data = StateOfTalk.stopped;
  }
}
