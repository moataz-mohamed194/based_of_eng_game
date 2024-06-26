import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../core/assets_sound_letters.dart';
import '../core/audio_player_letters.dart';
import '../core/games_structure/basic_of_game_data.dart';
import '../core/talk_tts.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import '../games/drag_pic_to_word/manager/drag_pic_to_word_cubit.dart';
import '../games/drag_pic_to_word/page/drag_pic_to_word.dart';
import '../games/drag_word_to_pic/manager/drag_word_to_pic_cubit.dart';
import '../games/drag_word_to_pic/page/drag_pic_to_word.dart';
import '../games/family_word/pages/family_word_game.dart';
import '../games/rearrange/manager/rearrange_cubit.dart';
import '../games/rearrange/page/rearrange_screen.dart';
import '../games/sorting_game/manager/sorting_cubit.dart';
import '../games/sorting_game/pages/sorting_game.dart';
import '../games/spelling_game/manager/spelling_cubit.dart';
import '../games/spelling_game/pages/spelling_game.dart';

class BasedOfGameShortVowels extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  const BasedOfGameShortVowels(
      {super.key, required this.stateOfGame, required this.gamesData});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(stateOfGame.basicData?.background ?? ''),
                fit: BoxFit.fill)),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            /////////////////////game title//////////////////


            ///////////////////game//////////////////
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((stateOfGame.basicData?.gameData
                      is RearrangeGame)) ...{
                    BlocProvider<RearrangeCubit>(
                        create: (_) => RearrangeCubit(
                            // gameData: stateOfGameData.data[stateOfGame.index],
                            index: stateOfGame.index,
                            listGameData: gamesData, ),
                        child: RearrangeScreen())
                  }
                ],
              ),
            ),
            Positioned(
              top: 0,
              left: 20,
              // start: 45.w,
              child:
                  GestureDetector(
                    onTap: stateOfGame.beeTalking == true
                        ? null
                        : () async {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .beeTalkingTrue();
                            await TalkTts.startTalk(
                                text:
                                    gamesData[stateOfGame.index].inst ?? '');
                            TalkTts.flutterTts.setCompletionHandler(() async {
                              if (stateOfGame.stateOfStringIsWord == true) {
                                await TalkTts.startTalk(
                                    text: stateOfGame.stateOfStringWillSay ??
                                        '');
                              } else {
                                await AudioPlayerLetters.startPlaySound(
                                    soundPath:
                                        AssetsSoundLetters.getSoundOfLetter(
                                            mainGameLetter: stateOfGame
                                                    .stateOfStringWillSay ??
                                                ''));
                              }
                            });

                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .beeTalkingFalse();
                          },
                    child: Image.asset(
                      stateOfGame.basicData?.gameData?.titleImageEn ?? '',
                      height: 75.h,
                      width: 85.w,

                      // fit: BoxFit.fill,
                    ),
                  ),

            ),
            Positioned(
              bottom: 15,
              right: 0,
              child:
              GestureDetector(
                onTap: stateOfGame.beeTalking == true
                    ? null
                    : () async {
                  await context
                      .read<CurrentGamePhoneticsCubit>()
                      .beeTalkingTrue();
                  await TalkTts.startTalk(
                      text:
                      gamesData[stateOfGame.index].inst ?? '');
                  TalkTts.flutterTts.setCompletionHandler(() async {
                    if (stateOfGame.stateOfStringIsWord == true) {
                      await TalkTts.startTalk(
                          text: stateOfGame.stateOfStringWillSay ??
                              '');
                    } else {
                      await AudioPlayerLetters.startPlaySound(
                          soundPath:
                          AssetsSoundLetters.getSoundOfLetter(
                              mainGameLetter: stateOfGame
                                  .stateOfStringWillSay ??
                                  ''));
                    }
                  });

                  await context
                      .read<CurrentGamePhoneticsCubit>()
                      .beeTalkingFalse();
                },
                child: Container(
                    alignment: Alignment.center,
                    child: stateOfGame.avatarCurrentArtboard == null
                        ? SizedBox(
                      height:
                      MediaQuery.of(context).size.height > 450
                          ? 250.h
                          : 200.h,
                      width: 100.w,
                    )
                        : Container(
                      margin: EdgeInsets.only(left: 7.w),
                      child: SizedBox(
                          height:
                          MediaQuery.of(context).size.height >
                              450
                              ? 250.h
                              : 150.h,
                          width: 80.w,
                          child: Rive(
                            artboard:
                            stateOfGame.avatarCurrentArtboard!,
                            fit: BoxFit.fill,
                            useArtboardSize: true,
                            alignment: Alignment.center,
                          )),
                    )),
              ),

            ),
          ],
        ),
      ),
    );
  }
}
