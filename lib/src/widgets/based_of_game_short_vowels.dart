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

            Positioned(
              top: 0,
              left: -20,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              ? Image.asset(
                                  stateOfGame.currentAvatar ?? '',
                                  // height:
                                  // MediaQuery.of(context).size.height - (70.h),
                                  height: 75.h,
                                  width: 80.w,
                                )
                              : Container(
                                  margin: EdgeInsets.only(left: 7.w),
                                  child: SizedBox(
                                      height: 90.h,
                                      width: 65.w,
                                      child: Rive(
                                        artboard:
                                            stateOfGame.avatarCurrentArtboard!,
                                        fit: BoxFit.fill,
                                        useArtboardSize: true,
                                        alignment: Alignment.center,
                                      )),
                                )),
                    ),
                  ],
                ),
              ),
            ),
            /////////////////////game//////////////////
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((stateOfGame.basicData?.gameData
                      is SpellingWordGame)) ...{
                    BlocProvider<SpellingCubit>(
                        create: (_) => SpellingCubit(
                            // gameData: stateOfGameData.data[stateOfGame.index],
                            index: stateOfGame.index,
                            background: (stateOfGame.basicData?.gameData
                                    as SpellingWordGame)
                                .woodenBackground,
                            allGames: gamesData),
                        child: const SpellingGameScreen())
                  } else if ((stateOfGame.basicData?.gameData
                      is DragPicToWordGame)) ...{
                    BlocProvider<DragPicToWordCubit>(
                        create: (_) => DragPicToWordCubit(
                            gameData: gamesData[stateOfGame.index]),
                        child: DragPicToWordGameScreen())
                  } else if ((stateOfGame.basicData?.gameData
                  is DragWordToPicGame)) ...{
                    BlocProvider<DragWordToPicCubit>(
                        create: (_) => DragWordToPicCubit(
                            gameData: gamesData[stateOfGame.index]),
                        child: DragWordToPicGameScreen())
                  } else if ((stateOfGame.basicData?.gameData
                  is WordFamilyGame)) ...{
                    BlocProvider<SortingCubit>(
                        create: (_) => SortingCubit(
                            index: stateOfGame.index,
                            background: (stateOfGame.basicData?.gameData
                            as WordFamilyGame)
                                .woodenBackground,
                            listGameData: gamesData),
                        child: FamilyWordGameScreen())
                  }
                ],
              ),
            ),
            PositionedDirectional(
              top: 0,
              start: 45.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w, top: 10.h),
                    child: GestureDetector(
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
                        width: 120.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
