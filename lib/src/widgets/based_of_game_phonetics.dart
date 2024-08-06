import 'package:based_of_eng_game/src/games/videos/cubit/video_cubit.dart';
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
import '../games/click_the_picture/manager/click_picture_cubit.dart';
import '../games/click_the_picture/pages/click_picture_game.dart';
import '../games/click_the_picture_with_word/manager/click_the_picture_with_word_cubit.dart';
import '../games/click_the_picture_with_word/page/click_the_picture_with_word.dart';
import '../games/click_the_sound/manager/click_the_sound_cubit.dart';
import '../games/click_the_sound/pages/click_the_sound_game.dart';
import '../games/drag_out/manager/drag_out_cubit.dart';
import '../games/drag_out/pages/drag_out_game.dart';
import '../games/tracing/manager/tracing_cubit.dart';
import '../games/tracing/page/tracing_game.dart';
import '../games/videos/screen/game_video.dart';

class BasedOfGamePhonetics extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  const BasedOfGamePhonetics(
      {super.key, required this.stateOfGame, required this.gamesData});
  @override
  Widget build(BuildContext context) {


    return Expanded(
        child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
            left: (stateOfGame.basicData?.gameData is Tracking) ? null : 0,
            bottom: 0,
            child: SizedBox(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if ((stateOfGame.basicData?.gameData is BasicDragOutGame)) ...{
                  ///todo need to know why when the index of CurrentGamePhoneticsCubit change not the gameData change
                  BlocProvider<DragOutCubit>(
                      create: (_) => DragOutCubit(
                          index: stateOfGame.index,
                          gameData: gamesData[stateOfGame.index],
                          allGameData: gamesData),
                      child: DragOutGame())
                } else if ((stateOfGame.basicData?.gameData
                    is ClickPicture)) ...{
                  BlocProvider<ClickPictureCubit>(
                      create: (_) => ClickPictureCubit(
                          gameData: gamesData[stateOfGame.index],
                          background:
                              (stateOfGame.basicData?.gameData as ClickPicture)
                                  .getBackGround(gamesData[stateOfGame.index]
                                          .gameImages
                                          ?.length ??
                                      0),
                          isArabic: false),
                      child: const ClickPictureGame())
                } else if ((stateOfGame.basicData?.gameData
                    is ClickPictureOfWord)) ...{
                  BlocProvider<ClickThePictureWithWordCubit>(
                      create: (_) => ClickThePictureWithWordCubit(
                          gameData: gamesData[stateOfGame.index],
                          backGround: (stateOfGame.basicData?.gameData
                                  as ClickPictureOfWord)
                              .getBackGround(gamesData[stateOfGame.index]
                                      .gameImages
                                      ?.length ??
                                  0),
                          isArabic: false),
                      child: const ClickThePictureWithWord())
                } else if ((stateOfGame.basicData?.gameData
                    is BasicClickTheSoundGame)) ...{
                  BlocProvider<ClickTheSoundCubit>(
                      create: (_) => ClickTheSoundCubit(
                            gameData: gamesData[stateOfGame.index],
                          ),
                      child: const ClickTheSoundGame()),
                } else if (stateOfGame.basicData?.gameData is Video) ...{
                  BlocProvider<VideoCubit>(
                    create: (_) => VideoCubit(
                      gameData: gamesData[stateOfGame.index],
                    ),
                    child: const GameVideo(),
                  )
                } else if (stateOfGame.basicData?.gameData is Tracking) ...{
                  BlocProvider<TracingCubit>(
                      create: (_) {
                        
                        return TracingCubit(
                          gameData: gamesData[stateOfGame.index],
                          stateOfGame: stateOfGame,
                        );
                      },
                      child: const TracingGame()),
                }
              ],
            ))),
        if (stateOfGame.basicData?.gameData is! Video) ...{
          Positioned(
              top: MediaQuery.of(context).size.height > 650 ? 100.h : 0.h,
              left: 20,
              child: Image.asset(
                stateOfGame.basicData?.gameData?.titleImageEn ?? '',
                height:
                    MediaQuery.of(context).size.height > 650 ? .15.sh : 75.h,
                fit: BoxFit.fill,
              )),
          Positioned(
            bottom: 15,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: SizedBox(
                // width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    GestureDetector(
                      onTap: context
                              .read<CurrentGamePhoneticsCubit>()
                              .ableButton()
                          ? () async {
                              await context
                                  .read<CurrentGamePhoneticsCubit>()
                                  .beeTalkingTrue();
                              await TalkTts.startTalk(
                                  text:
                                      gamesData[stateOfGame.index].inst ?? '');
                              TalkTts.flutterTts.setCompletionHandler(() async {
                                if (stateOfGame.stateOfStringIsWord ==
                                    StateOfSubWord.isWord) {
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
                            }
                          : null,
                      child: Container(
                          child: stateOfGame.avatarCurrentArtboard == null
                              ? SizedBox(
                                  // stateOfGame.currentAvatar ?? '',
                                  height:
                                      MediaQuery.of(context).size.height > 450
                                          ? 250.h
                                          : 200.h,
                                  width: 100.w,
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height > 450
                                          ? 250.h
                                          : 180.h,
                                  width: 80.w,
                                  child: Rive(
                                    artboard:
                                        stateOfGame.avatarCurrentArtboard!,
                                    fit: BoxFit.fill,
                                    // useArtboardSize: true,
                                  ))),
                    ),
                    // SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        },
      ],
    ));
  }
}
