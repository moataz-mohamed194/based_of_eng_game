import 'package:based_of_eng_game/based_of_eng_game.dart';
import 'package:based_of_eng_game/src/games/culture/choose_your_age/manager/click_to_choose_cubit.dart';
import 'package:based_of_eng_game/src/games/culture/choose_your_age/pages/click_to_choose_page.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../core/assets_sound_letters.dart';
import '../core/audio_player_letters.dart';
import '../core/talk_tts.dart';
import '../cubit/current_game_phonetics_cubit.dart';

class BasedOfCultureGames extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  const BasedOfCultureGames(
      {super.key, required this.stateOfGame, required this.gamesData});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          /////////////////////game title//////////////////
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (stateOfGame.basicData?.gameData is ChooseSenses) ...{
                  BlocProvider(
                    create: (_) => ClickToChooseCubit(
                        // gameData: stateOfGameData.data[stateOfGame.index],
                        index: stateOfGame.index,
                        listGameData: gamesData,
                        type: ClickToChooseType.chooseSenses),
                    child: ClickToChoosePage(),
                  )
                }
              ],
            ),
          ),

          Positioned(
            top: -10,
            left: 20.w,
            child: Container(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(children: [
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
                  Image.asset(
                    stateOfGame.basicData?.gameData?.titleImageEn ?? '',
                    height:
                        MediaQuery.of(context).size.height > 650 ? 70.h : 40.h,
                    fit: BoxFit.fitHeight,
                  ),
                ])),
          ),
        ],
      ),
    );
  }
}
