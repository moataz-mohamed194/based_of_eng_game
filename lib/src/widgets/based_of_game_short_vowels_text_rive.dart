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
import '../games/listen_and_choose/manager/listen_choose_cubit.dart';
import '../games/listen_and_choose/page/listen_and_choose_screen.dart';
import '../games/sorting_game/manager/sorting_cubit.dart';
import '../games/sorting_game/pages/sorting_game.dart';
import '../games/spelling_game/manager/spelling_cubit.dart';
import '../games/spelling_game/pages/spelling_game.dart';

class BasedOfGameShortVowelsTextNextRive extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;
  final bool isArabic;

  const BasedOfGameShortVowelsTextNextRive(
      {super.key,
      required this.stateOfGame,
      required this.gamesData,
      this.isArabic = false});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(stateOfGame.basicData?.background ?? ''),
                  fit: BoxFit.fill)),
          child: Stack(
            alignment: isArabic ? Alignment.topLeft : Alignment.topRight,
            children: [
              /////////////////////game title//////////////////

              Positioned(
                top: 0,
                left: isArabic ? null : -20,
                right: isArabic ? -20 : null,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                        gamesData[stateOfGame.index].inst ?? '',
                                    isArabic: isArabic);
                                TalkTts.flutterTts
                                    .setCompletionHandler(() async {
                                  if (stateOfGame.stateOfStringIsWord !=
                                      StateOfSubWord.stopTalk) {
                                    if (stateOfGame.stateOfStringIsWord ==
                                        StateOfSubWord.isWord) {
                                      await TalkTts.startTalk(
                                          text: stateOfGame
                                                  .stateOfStringWillSay ??
                                              '',
                                          isArabic: isArabic);
                                    } else {
                                      await AudioPlayerLetters.startPlaySound(
                                          soundPath: AssetsSoundLetters
                                              .getSoundOfLetter(
                                                  mainGameLetter: stateOfGame
                                                          .stateOfStringWillSay ??
                                                      ''));
                                    }
                                  }
                                });

                                await context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .beeTalkingFalse();
                              }
                            : null,
                        child: Container(
                            alignment: Alignment.center,
                            child: stateOfGame.avatarCurrentArtboard == null
                                ? SizedBox(
                                    height: 75.h,
                                    width: 80.w,
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        left: isArabic ? 0.w : 7.w,
                                        right: isArabic ? 7.w : 0.w),
                                    child: SizedBox(
                                        height: 100.h,
                                        // width: 65.w,
                                        child: Rive(
                                          artboard: stateOfGame
                                              .avatarCurrentArtboard!,
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
                              gameData: gamesData[stateOfGame.index],
                              isArabic: isArabic),
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
                    } else if ((stateOfGame.basicData?.gameData
                        is ListenAndChooseGame)) ...{
                      BlocProvider<ListenChooseCubit>(
                          create: (_) => ListenChooseCubit(
                              index: stateOfGame.index,
                              listGameData: gamesData),
                          child: ListenAndChooseScreen())
                    }
                  ],
                ),
              ),
              PositionedDirectional(
                top: 0,
                start: 35.w,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: isArabic ? 0.w : 10.w,
                      right: isArabic ? 10.w : 0.w,
                      top: 10.h),
                  child: Image.asset(
                    isArabic
                        ? stateOfGame.basicData?.gameData?.titleImageAr ?? ''
                        : stateOfGame.basicData?.gameData?.titleImageEn ?? '',
                    height: 75.h,
                    width: 120.w,
                    // fit: BoxFit.fill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
