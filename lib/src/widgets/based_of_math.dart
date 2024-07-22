import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../based_of_eng_game.dart';
import '../core/assets_sound_letters.dart';
import '../core/audio_player_letters.dart';
import '../core/talk_tts.dart';
import '../cubit/current_game_phonetics_cubit.dart';

class BasedOfMath extends StatelessWidget{
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  const BasedOfMath(
      {super.key, required this.stateOfGame, required this.gamesData});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: context.read<CurrentGamePhoneticsCubit>().ableButton()?()async {
                await context
                    .read<CurrentGamePhoneticsCubit>()
                    .beeTalkingTrue();
                await TalkTts.startTalk(
                    text: gamesData[stateOfGame.index].inst ?? '');

                if (stateOfGame.stateOfStringIsWord !=
                    StateOfSubWord.stopTalk) {
                  TalkTts.flutterTts.setCompletionHandler(() async {
                    if (stateOfGame.stateOfStringIsWord ==
                        StateOfSubWord.isWord) {
                      await TalkTts.startTalk(
                          text: stateOfGame.stateOfStringWillSay ?? '');
                    } else {
                      await AudioPlayerLetters.startPlaySound(
                          soundPath:
                          AssetsSoundLetters.getSoundOfLetter(
                              mainGameLetter: stateOfGame
                                  .stateOfStringWillSay ??
                                  ''));
                    }
                  });
                }
                await context
                    .read<CurrentGamePhoneticsCubit>()
                    .beeTalkingFalse();
              }:null,
              child: Container(
                  alignment: Alignment.center,
                  child: stateOfGame.avatarCurrentArtboard == null
                      ? SizedBox(
                    height: MediaQuery.of(context).size.height > 450
                        ? 250.h
                        : 200.h,
                    width: 100.w,
                  )
                      : Container(
                    margin: EdgeInsets.only(left: 7.w),
                    child: SizedBox(
                        // height: MediaQuery.of(context).size.height > 450
                        //     ? 250.h
                        //     : 150.h,
                        width: 50.w,
                        child: Rive(
                          artboard: stateOfGame.avatarCurrentArtboard!,
                          fit: BoxFit.fill,
                          useArtboardSize: true,
                          alignment: Alignment.center,
                        )),
                  )),
            ),
            Image.asset(
              stateOfGame.basicData?.gameData?.titleImageEn ?? '',
              height: 50.h,
              // width: 85.w,

              // fit: BoxFit.fill,
            )
          ],
        ),
        if(stateOfGame.basicData?.gameData is MathChooseSticks)...{

        }
      ],
    );
  }

}