import 'package:based_of_eng_game/based_of_eng_game.dart';
import 'package:based_of_eng_game/src/core/assets_sound_letters.dart';
import 'package:based_of_eng_game/src/core/audio_player_letters.dart';
import 'package:based_of_eng_game/src/core/talk_tts.dart';
import 'package:based_of_eng_game/src/cubit/current_game_phonetics_cubit.dart';
import 'package:based_of_eng_game/src/games/choose_the_correct_letter_or_image/manager/choose_the_correct_letter_or_image_cubit.dart';
import 'package:based_of_eng_game/src/games/choose_the_correct_letter_or_image/pages/choose_the_correct_letter_or_image.dart';
import 'package:based_of_eng_game/src/games/click_the_picture/manager/click_picture_cubit.dart';
import 'package:based_of_eng_game/src/games/click_the_picture/pages/click_picture_game.dart';
import 'package:based_of_eng_game/src/games/click_the_picture_with_word/manager/click_the_picture_with_word_cubit.dart';
import 'package:based_of_eng_game/src/games/click_the_picture_with_word/page/click_the_picture_with_word.dart';
import 'package:based_of_eng_game/src/games/click_the_sound/manager/click_the_sound_cubit.dart';
import 'package:based_of_eng_game/src/games/click_the_sound/pages/click_the_sound_game.dart';
import 'package:based_of_eng_game/src/games/drag_out/manager/drag_out_cubit.dart';
import 'package:based_of_eng_game/src/games/drag_out/pages/drag_out_game.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../games/match/manager/match_cubit.dart';
import '../games/match/page/match_screen.dart';
import '../games/match_arabic/manager/match_arabic_cubit.dart';
import '../games/match_arabic/page/match_arabic_screen.dart';
import '../games/tracing/manager/tracing_cubit.dart';
import '../games/tracing/page/tracing_game.dart';

class BasedOfGameArabic extends StatelessWidget {
  const BasedOfGameArabic(
      {super.key, required this.stateOfGame, required this.gamesData});
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned(
            right: (stateOfGame.basicData?.gameData is Tracking) ? null : 0,
            bottom: 0,
            child: SizedBox(
                child: Column(
              children: [
                if ((stateOfGame.basicData?.gameData is BasicDragOutGame)) ...{
                  ///todo need to know why when the index of CurrentGamePhoneticsCubit change not the gameData change
                  BlocProvider<DragOutCubit>(
                      create: (_) => DragOutCubit(
                          index: stateOfGame.index,
                          gameData: gamesData[stateOfGame.index],
                          allGameData: gamesData,
                          isArabic: true),
                      child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: DragOutGame()))
                } else if ((stateOfGame.basicData?.gameData
                    is ClickPictureOfWord)) ...{
                  BlocProvider<ClickThePictureWithWordCubit>(
                      create: (_) => ClickThePictureWithWordCubit(
                          gameData: gamesData[stateOfGame.index],
                          backGround: (stateOfGame.basicData?.gameData
                                  as ClickPictureOfWord)
                              .getBackGround(
                            gamesData[stateOfGame.index].gameImages?.length ??
                                0,
                          ),
                          isArabic: true),
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: ClickThePictureWithWord(isArabic: true)),
                      ))
                } else if ((stateOfGame.basicData?.gameData
                    is BasicClickTheSoundGame)) ...{
                  BlocProvider<ClickTheSoundCubit>(
                      create: (_) => ClickTheSoundCubit(
                            gameData: gamesData[stateOfGame.index],
                            isArabic: true,
                          ),
                      child: Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: const Directionality(
                            textDirection: TextDirection.rtl,
                            child: ClickTheSoundGame()),
                      )),
                } else if ((stateOfGame.basicData?.gameData
                    is ChooseTheCorrectImageOrLetter)) ...{
                  BlocProvider<ChooseTheCorrectLetterOrImageCubit>(
                      create: (_) => ChooseTheCorrectLetterOrImageCubit(
                          index: stateOfGame.index,
                          gameData: gamesData[stateOfGame.index],
                          allGameData: gamesData,
                          isLetter: (stateOfGame.basicData?.gameData
                                  as ChooseTheCorrectImageOrLetter)
                              .isImage),
                      child: const ChooseTheCorrectLetterOrImageGame())
                } else if ((stateOfGame.basicData?.gameData
                    is MatchingArabic)) ...{
                  BlocProvider<MatchArabicCubit>(
                      create: (_) => MatchArabicCubit(
                            gameData: gamesData[stateOfGame.index],
                          ),
                      child: MatchArabicScreen())
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
                          isArabic: true),
                      child: const ClickPictureGame())
                } else if (stateOfGame.basicData?.gameData is Tracking) ...{
                  BlocProvider<TracingCubit>(
                      create: (_) {
                        print('createdd');
                        return TracingCubit(
                            gameData: gamesData[stateOfGame.index],
                            stateOfGame: stateOfGame,
                            traceLetter:
                                stateOfGame.basicData?.lettersModel ?? [],
                            isArabic: true);
                      },
                      child: const TracingGame()),
                }
              ],
            ))),
        if (stateOfGame.basicData?.gameData is! Video) ...{
          Positioned(
              top: MediaQuery.of(context).size.height > 650 ? 70.h : 0.h,
              right: MediaQuery.of(context).size.height > 650 ? 10.w : 20.w,
              child: Image.asset(
                stateOfGame.basicData?.gameData?.titleImageAr ?? '',
                height: MediaQuery.of(context).size.height > 650 ? 125.h : 80.h,
                fit: BoxFit.fill,
              )),
          Positioned(
            bottom: 15,
            left: 0,
            child: Row(
              children: [
                GestureDetector(
                  onTap: context.read<CurrentGamePhoneticsCubit>().ableButton()
                      ? () async {
                          await context
                              .read<CurrentGamePhoneticsCubit>()
                              .beeTalkingTrue();
                          await TalkTts.startTalk(
                              text: gamesData[stateOfGame.index].inst ?? '',
                              isArabic: true);
                          TalkTts.flutterTts.setCompletionHandler(() async {
                            if (stateOfGame.stateOfStringIsWord ==
                                StateOfSubWord.isWord) {
                              await TalkTts.startTalk(
                                  text: stateOfGame.stateOfStringWillSay ?? '',
                                  isArabic: true);
                            } else {
                              await AudioPlayerLetters.startPlaySound(
                                  soundPath:
                                      AssetsSoundLetters.getSoundOfLetter(
                                mainGameLetter:
                                    stateOfGame.stateOfStringWillSay ?? '',
                              ));
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
                              height: MediaQuery.of(context).size.height > 450
                                  ? 250.h
                                  : 200.h,
                              width: 100.w,
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height > 450
                                  ? 250.h
                                  : 180.h,
                              width: 80.w,
                              child: Rive(
                                artboard: stateOfGame.avatarCurrentArtboard!,
                                fit: BoxFit.fill,
                                // useArtboardSize: true,
                              ))),
                ),
                const SizedBox(),
                // SizedBox(),
              ],
            ),
          ),
        },
      ],
    ));
  }
}
