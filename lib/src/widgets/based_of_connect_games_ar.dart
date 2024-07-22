import 'package:audioplayers/audioplayers.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../core/assets_sound_letters.dart';
import '../core/audio_player_game.dart';
import '../core/audio_player_letters.dart';
import '../core/games_structure/basic_of_game_data.dart';
import '../core/talk_tts.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import '../games/sorting_cups/manager/sorting_cups_cubit.dart';
import '../games/sorting_cups/page/game_soting_cups.dart';

class BasedOfGameConnectSortingCupsAr extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  const BasedOfGameConnectSortingCupsAr(
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
            top: -10,
            right: 0,
            child: Container(
                width: 120.w,
                padding: EdgeInsets.only(right: 10.w),
                child: Image.asset(
                  stateOfGame.basicData?.gameData?.titleImageAr ?? '',
                  height: 50.h,
                  width: 120.w,
                  fit: BoxFit.fill,
                )),
          ),
          Positioned(
            bottom: 15.h,
            right: 20,
            child: GestureDetector(
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
                              soundPath: AssetsSoundLetters.getSoundOfLetter(
                                  mainGameLetter:
                                      stateOfGame.stateOfStringWillSay ?? ''));
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
                          // height: 110.h,
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
