import 'package:based_of_eng_game/src/games/choose_the_sentence/manager/listen_choose_cubit.dart';
import 'package:based_of_eng_game/src/games/choose_the_sentence/page/listen_and_choose_screen.dart';
import 'package:based_of_eng_game/src/games/complete_the_word/manager/complete_the_word_cubit.dart';
import 'package:based_of_eng_game/src/games/complete_the_word/page/complete_the_word_game.dart';
import 'package:based_of_eng_game/src/games/drag_pic_to_word/manager/drag_pic_to_word_cubit.dart';
import 'package:based_of_eng_game/src/games/drag_pic_to_word/page/drag_pic_to_word.dart';
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

class BasedOfFullBoardGamesAr extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  const BasedOfFullBoardGamesAr(
      {super.key, required this.stateOfGame, required this.gamesData});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          /////////////////////game title//////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (stateOfGame.basicData?.gameData is CompleteTheWord ||
                  stateOfGame.basicData?.gameData
                      is ChooseTheStretchedLetter) ...{
                BlocProvider<CompleteTheWordCubit>(
                    create: (_) => CompleteTheWordCubit(
                          // gameData: stateOfGameData.data[stateOfGame.index],
                          index: stateOfGame.index,
                          listGameData: gamesData,
                          isArabic: true,
                        ),
                    child: CompleteTheWordGame())
              } else if ((stateOfGame.basicData?.gameData
                  is DragPicToWordGame)) ...{
                BlocProvider<DragPicToWordCubit>(
                    create: (_) => DragPicToWordCubit(
                          gameData: gamesData[stateOfGame.index],
                          isArabic: true,
                        ),
                    child: DragPicToWordGameScreen())
              } else ...{
                const Text('no game')
              },
            ],
          ),

          Positioned(
            top: -10,
            right: 20.w,
            child: Container(
                padding: EdgeInsets.only(right: 10.w),
                child: Row(children: [
                  Image.asset(
                    stateOfGame.basicData?.gameData?.titleImageAr ?? '',
                    height: 70.h,
                    fit: BoxFit.fitHeight,
                  ),
                  GestureDetector(
                    onTap: context
                            .read<CurrentGamePhoneticsCubit>()
                            .ableButton()
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
                                    text:
                                        stateOfGame.stateOfStringWillSay ?? '',
                                    isArabic: true);
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
                              height: 45.h,
                              width: 45.w,
                            )
                          : SizedBox(
                              // height: 60.h,
                              width: 45.w,
                              child: Rive(
                                artboard: stateOfGame.avatarCurrentArtboard!,
                                fit: BoxFit.fill,
                                useArtboardSize: true,
                                alignment: Alignment.center,
                              ),
                            ),
                    ),
                  ),
                ])),
          ),
        ],
      ),
    );
  }
}
