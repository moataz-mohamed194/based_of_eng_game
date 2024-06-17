import 'package:audioplayers/audioplayers.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_models/games_models.dart';
import '../../based_of_game.dart';
import '../core/audio_player_game.dart';
import '../core/audio_player_letters.dart';
import '../core/games_structure/basic_of_game.dart';
import '../core/talk_tts.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import '../games/sorting_cups/manager/sorting_cups_cubit.dart';
import '../games/sorting_cups/page/game_soting_cups.dart';

class BasedOfGameConnectSortingCups extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameModel> gamesData;

  const BasedOfGameConnectSortingCups(
      {Key? key, required this.stateOfGame, required this.gamesData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          /////////////////////game title//////////////////
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if ((stateOfGame.basicData?.gameData is SortingCupsGame)) ...{
                BlocProvider<SortingCupsCubit>(
                    create: (_) => SortingCupsCubit(
                          gameData: gamesData[stateOfGame.index],
                        ),
                    child: GamesSortingCups())
              },
            ],
          ),

          Positioned(
            top: 0,
            left: 0,
            child: Container(
                width: 120.w,
                padding: EdgeInsets.only(left: 10.w),
                child: GestureDetector(
                  onTap: stateOfGame.beeTalking == true
                      ? null
                      : () async {
                          await context
                              .read<CurrentGamePhoneticsCubit>()
                              .beeTalkingTrue();
                          await TalkTts.startTalk(
                              text: gamesData[stateOfGame.index].inst ?? '');
                          TalkTts.flutterTts.setCompletionHandler(() async {
                            if (stateOfGame.stateOfStringIsWord == true) {
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

                          await context
                              .read<CurrentGamePhoneticsCubit>()
                              .beeTalkingFalse();
                        },
                  child: Image.asset(
                    stateOfGame.basicData?.gameData?.titleImageEn ?? '',
                    height: 50.h,
                    width: 120.w,
                    fit: BoxFit.fill,
                  ),
                )),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: stateOfGame.beeTalking == true ||
                      AudioPlayerGame.playerCorrect.state ==
                          PlayerState.playing ||
                      AudioPlayerGame.playerWrong.state == PlayerState.playing
                  ? null
                  : () async {
                      await context
                          .read<CurrentGamePhoneticsCubit>()
                          .beeTalkingTrue();
                      await TalkTts.startTalk(
                          text: gamesData[stateOfGame.index].inst ?? '');
                      TalkTts.flutterTts.setCompletionHandler(() async {
                        if (stateOfGame.stateOfStringIsWord == true) {
                          await TalkTts.startTalk(
                              text: stateOfGame.stateOfStringWillSay ?? '');
                        } else {
                          await AudioPlayerLetters.startPlaySound(
                              soundPath: AssetsSoundLetters.getSoundOfLetter(
                                  mainGameLetter:
                                      stateOfGame.stateOfStringWillSay ?? ''));
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
                          height: 85.h,
                          width: 80.w,
                        )
                      : SizedBox(
                          height: 110.h,
                          width: 70.w,
                          child: Rive(
                            artboard: stateOfGame.avatarCurrentArtboard!,
                            fit: BoxFit.fill,
                            useArtboardSize: true,
                            alignment: Alignment.center,
                          ))),
            ),
          ),
        ],
      ),
    );
  }
}
