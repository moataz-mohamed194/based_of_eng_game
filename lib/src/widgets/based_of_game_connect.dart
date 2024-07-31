import 'package:based_of_eng_game/src/games/bingo_arabic_game/manager/bingo_arabic_cubit.dart';
import 'package:based_of_eng_game/src/games/bingo_arabic_game/pages/bingo_arabic_game.dart';
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
import '../games/bingo_game/manager/bingo_cubit.dart';
import '../games/bingo_game/pages/bingo_game.dart';
import '../games/dice/manager/dice_cubit.dart';
import '../games/dice/page/dice_game.dart';
import '../games/dice/widget/wave_dice.dart';
import '../games/sorting_game/manager/sorting_cubit.dart';
import '../games/sorting_game/pages/sorting_game.dart';
import '../games/spelling_game/manager/spelling_cubit.dart';
import '../games/spelling_game/pages/spelling_game.dart';
import '../games/x_out_game/manager/x_out_cubit.dart';
import '../games/x_out_game/pages/x_out_game.dart';

class BasedOfGameConnect extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;
  final bool isArabic;
  const BasedOfGameConnect(
      {super.key,
      required this.stateOfGame,
      required this.gamesData,
      required this.isArabic});
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: isArabic
          ? stateOfGame.basicData?.gameData is BingoArabicGame
              ? TextDirection.ltr
              : TextDirection.rtl
          : TextDirection.ltr,
      child: Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(stateOfGame.basicData?.background ?? ''),
                  fit: BoxFit.fill)),
          child: Stack(
            alignment: isArabic
                ? stateOfGame.basicData?.gameData is BingoArabicGame
                    ? Alignment.topRight
                    : Alignment.topLeft
                : Alignment.topRight,
            children: [
             
              /////////////////////game//////////////////
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((stateOfGame.basicData?.gameData is BingoGame)) ...{
                    BlocProvider<BingoCubit>(
                        create: (_) => BingoCubit(
                              gameData: gamesData[stateOfGame.index],
                            ),
                        child: const BingoGameScreen())
                  } else if ((stateOfGame.basicData?.gameData
                      is BingoArabicGame)) ...{
                    BlocProvider<BingoArabicCubit>(
                      create: (_) => BingoArabicCubit(
                          gameData: gamesData[stateOfGame.index]),
                      child: const BingoArabicGameScreen(),
                    )
                  } else if ((stateOfGame.basicData?.gameData is XOutGame)) ...{
                    BlocProvider<XOutCubit>(
                        create: (_) => XOutCubit(
                              listGameData: gamesData,
                              index: stateOfGame.index,
                              isArabic: isArabic,
                            ),
                        child: const XOutGameScreen())
                  } else if ((stateOfGame.basicData?.gameData
                      is SpellingGame)) ...{
                    // const Text('SpellingGame')
                    BlocProvider<SpellingCubit>(
                        create: (_) => SpellingCubit(
                            // gameData: stateOfGameData.data[stateOfGame.index],
                            isArabic: isArabic,
                            index: stateOfGame.index,
                            background: (stateOfGame.basicData?.gameData
                                    as SpellingGame)
                                .woodenBackground,
                            allGames: gamesData),
                        child: SpellingGameScreen())
                  } else if ((stateOfGame.basicData?.gameData
                      is SortingPicturesGame)) ...{
                    // const Text('SortingPicturesGame')
                    BlocProvider<SortingCubit>(
                        create: (_) => SortingCubit(
                            isArabic: isArabic,
                            index: stateOfGame.index,
                            background: (stateOfGame.basicData?.gameData
                                    as SortingPicturesGame)
                                .woodenBackground,
                            listGameData: gamesData),
                        child: SortingGameScreen())
                  } else if ((stateOfGame.basicData?.gameData is DiceGame)) ...{
                    BlocProvider<DiceCubit>(
                        create: (_) => DiceCubit(
                              gameData: gamesData[stateOfGame.index],
                            ),
                        child: DiceGamePage())
                  }
                ],
              ),
 if (stateOfGame.basicData!.gameData!.isRound) ...{
                PositionedDirectional(
                  top: -10,
                  start: 90.w,
                  child: GestureDetector(
                    onTap: context
                            .read<CurrentGamePhoneticsCubit>()
                            .ableButton()
                        ? () async {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .beeTalkingTrue();
                            await TalkTts.startTalk(
                                text: gamesData[stateOfGame.index].inst ?? '',
                                isArabic: isArabic);
                            TalkTts.flutterTts.setCompletionHandler(() async {
                              if (stateOfGame.stateOfStringIsWord ==
                                  StateOfSubWord.isWord) {
                                await TalkTts.startTalk(
                                    text:
                                        stateOfGame.stateOfStringWillSay ?? '',
                                    isArabic: isArabic);
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
                        alignment: Alignment.center,
                        child: stateOfGame.avatarCurrentArtboard == null
                            ? SizedBox(
                                // stateOfGame.currentAvatar ?? '',
                                // height:
                                // MediaQuery.of(context).size.height - (70.h),
                                height: 85.h,
                                width: 80.w,
                              )
                            : SizedBox(
                                height: 110.h,
                                // width: 70.w,
                                child: Rive(
                                  artboard: stateOfGame.avatarCurrentArtboard!,
                                  fit: BoxFit.fill,
                                  useArtboardSize: true,
                                  alignment: Alignment.center,
                                ))),
                  ),
                ),
              },
              /////////////////////game title//////////////////
              Positioned(
                top: 0,
                left: isArabic
                    ? stateOfGame.basicData?.gameData is BingoArabicGame
                        ? 0
                        : null
                    : 0,
                right: isArabic
                    ? stateOfGame.basicData?.gameData is BingoArabicGame
                        ? null
                        : 0
                    : null,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      stateOfGame.basicData!.gameData!.isRound
                          ? Padding(
                              padding: EdgeInsets.only(
                                  left: isArabic
                                      ? stateOfGame.basicData?.gameData
                                              is BingoArabicGame
                                          ? 10.w
                                          : 0
                                      : 10.w,
                                  right: isArabic
                                      ? stateOfGame.basicData?.gameData
                                              is BingoArabicGame
                                          ? 0
                                          : 10.w
                                      : 0,
                                  top: 10.h),
                              child: Image.asset(
                                isArabic
                                    ? stateOfGame.basicData?.gameData
                                            ?.titleImageAr ??
                                        ''
                                    : stateOfGame.basicData?.gameData
                                            ?.titleImageEn ??
                                        '',
                                // height: 75.h,
                                width: 90.w,
                                fit: BoxFit.fill,
                              ),
                            )
                          : Container(
                              width: 0.4.sw,
                              height: 0.41.sh,
                              padding: EdgeInsets.only(
                                  left: isArabic
                                      ? stateOfGame.basicData?.gameData
                                              is BingoArabicGame
                                          ? 10
                                          : 0
                                      : 10,
                                  right: isArabic
                                      ? stateOfGame.basicData?.gameData
                                              is BingoArabicGame
                                          ? 0
                                          : 10
                                      : 0),
                              child: Stack(
                                // crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Positioned(
                                    top: stateOfGame.basicData?.gameData
                                            is BingoArabicGame
                                        ? null
                                        : 0,
                                    bottom: stateOfGame.basicData?.gameData
                                            is BingoArabicGame
                                        ? 0
                                        : null,
                                    child: GestureDetector(
                                      onTap: context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .ableButton()
                                          ? () async {
                                              await context
                                                  .read<
                                                      CurrentGamePhoneticsCubit>()
                                                  .beeTalkingTrue();
                                              await TalkTts.startTalk(
                                                  text: gamesData[
                                                              stateOfGame.index]
                                                          .inst ??
                                                      '',
                                                  isArabic: isArabic);
                                              TalkTts.flutterTts
                                                  .setCompletionHandler(
                                                      () async {
                                                if (stateOfGame
                                                        .stateOfStringIsWord ==
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
                                                              mainGameLetter:
                                                                  stateOfGame
                                                                          .stateOfStringWillSay ??
                                                                      ''));
                                                }
                                              });

                                              await context
                                                  .read<
                                                      CurrentGamePhoneticsCubit>()
                                                  .beeTalkingFalse();
                                            }
                                          : null,
                                      child: Container(
                                          alignment: Alignment.center,
                                          child: stateOfGame
                                                      .avatarCurrentArtboard ==
                                                  null
                                              ? SizedBox(
                                                  // stateOfGame.currentAvatar ?? '',
                                                  // height:
                                                  // MediaQuery.of(context).size.height - (70.h),
                                                  height: 75.h,
                                                  width: 80.w,
                                                )
                                              : Container(
                                                  width: 75.w,
                                                  alignment: Alignment.center,
                                                  margin: EdgeInsets.only(
                                                      left: isArabic
                                                          ? stateOfGame
                                                                      .basicData
                                                                  is BingoArabicGame
                                                              ? 7.w
                                                              : 0.w
                                                          : 7.w,
                                                      right: isArabic
                                                          ? stateOfGame
                                                                      .basicData
                                                                  is BingoArabicGame
                                                              ? 0.w
                                                              : 7.w
                                                          : 0.w),
                                                  child: SizedBox(
                                                      height: 120.h,
                                                      // width: 65.w,
                                                      child: Rive(
                                                        artboard: stateOfGame
                                                            .avatarCurrentArtboard!,
                                                        fit: BoxFit.fill,
                                                        useArtboardSize: true,
                                                        alignment:
                                                            Alignment.center,
                                                      )),
                                                )),
                                    ),
                                  ),
                                  if (stateOfGame.basicData?.gameData
                                      is BingoArabicGame)
                                    const SizedBox()
                                  else
                                    PositionedDirectional(
                                      top: 59.h,
                                      child: Image.asset(
                                        isArabic
                                            ? stateOfGame.basicData?.gameData
                                                    ?.titleImageAr ??
                                                ''
                                            : stateOfGame.basicData?.gameData
                                                    ?.titleImageEn ??
                                                '',
                                        // height: 0.41.sh - 70.h,
                                        width: isArabic ? 100.w : 75.w,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                      if (stateOfGame.currentStringOfDice != null) ...{
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20.w),
                          child: WaveDice(
                            currentAlphabet:
                                '${stateOfGame.currentStringOfDice}',
                            width: 90.h,
                            height: 90.h,
                          ),
                        )
                      }
                    ],
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
