import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../based_of_eng_game.dart';
import '../core/assets_sound_letters.dart';
import '../core/audio_player_letters.dart';
import '../core/game_types/game_phonatics_types.dart';
import '../core/talk_tts.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import '../games/math/choose_number/manager/choose_number_cubit.dart';
import '../games/math/choose_number/screen/choose_numbers_screen.dart';
import '../games/math/choose_sticks/manager/choose_sticks_cubit.dart';
import '../games/math/choose_sticks/screen/choose_sticks_screen.dart';
import '../games/math/sorting_blocks/manager/sorting_blocks_cubit.dart';
import '../games/math/sorting_blocks/screen/sorting_blocks_screen.dart';

class BasedOfMath extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  const BasedOfMath(
      {super.key, required this.stateOfGame, required this.gamesData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: context.read<CurrentGamePhoneticsCubit>().ableButton()
                  ? () async {
                      await context
                          .read<CurrentGamePhoneticsCubit>()
                          .beeTalkingTrue();
                      await TalkTts.startTalk(
                          text: gamesData[stateOfGame.index].inst ?? '');

                      if (stateOfGame.stateOfStringIsWord !=
                          StateOfSubWord.stopTalk) {
                        TalkTts.flutterTts.setCompletionHandler(() async {
                          if (stateOfGame.stateOfStringIsWord ==
                              StateOfSubWord.isWord) {
                            await TalkTts.startTalk(
                                text: stateOfGame.stateOfStringWillSay ?? '');
                          } else {
                            await AudioPlayerLetters.startPlaySound(
                                soundPath: AssetsSoundLetters.getSoundOfLetter(
                                    mainGameLetter:
                                        stateOfGame.stateOfStringWillSay ??
                                            ''));
                          }
                        });
                      }
                      await context
                          .read<CurrentGamePhoneticsCubit>()
                          .beeTalkingFalse();
                    }
                  : null,
              child: Container(
                  alignment: Alignment.center,
                  child: stateOfGame.avatarCurrentArtboard == null
                      ? SizedBox(
                          height: 90.h,
                          // width: 100.w,
                        )
                      : Container(
                          margin: EdgeInsets.only(left: 7.w),
                          child: SizedBox(
                              height: 90.h,
                              // width: 50.w,
                              child: Rive(
                                artboard: stateOfGame.avatarCurrentArtboard!,
                                fit: BoxFit.fill,
                                useArtboardSize: true,
                                alignment: Alignment.center,
                              )),
                        )),
            ),
            Image.asset(
              stateOfGame.basicData?.gameData?.titleImageEn ?? '',
              height: 50.h,
              // width: 85.w,

              // fit: BoxFit.fill,
            )
          ],
        ),
        if (stateOfGame.basicData?.gameData
            is MathChooseSticksOrBeadsOrBlocks) ...{
          BlocProvider<ChooseSticksCubit>(
            create: (_) => ChooseSticksCubit(
                allGameData: gamesData,
                basicData: stateOfGame.basicData!.gameData!),
            child: BlocListener<ChooseSticksCubit, ChooseSticksInitial>(
                listener: (context, state) {
                  final List<GameFinalModel> gameData = gamesData;
                  context
                      .read<CurrentGamePhoneticsCubit>()
                      .getStateOfStars(mainCountOfQuestion: gameData.length);
                  context
                      .read<CurrentGamePhoneticsCubit>()
                      .saveTheStringWillSay(
                          stateOfStringIsWord: StateOfSubWord.stopTalk,
                          stateOfStringWillSay: gameData.first.inst ?? '');
                },
                child: ChooseSticksScreen()),
          )
        } else if (stateOfGame.basicData?.gameData
            is MathChooseNumberSticksOrBeadsOrBlocks) ...{
          BlocProvider<ChooseNumberCubit>(
            create: (_) => ChooseNumberCubit(
                allGameData: gamesData,
                basicData: stateOfGame.basicData!.gameData!),
            child: BlocListener<ChooseNumberCubit, ChooseNumberInitial>(
                listener: (context, state) {
                  final List<GameFinalModel> gameData = gamesData;
                  context
                      .read<CurrentGamePhoneticsCubit>()
                      .getStateOfStars(mainCountOfQuestion: gameData.length);
                  context
                      .read<CurrentGamePhoneticsCubit>()
                      .saveTheStringWillSay(
                          stateOfStringIsWord: StateOfSubWord.stopTalk,
                          stateOfStringWillSay: gameData.first.inst ?? '');
                },
                child: ChooseNumberScreen()),
          )
        } else if (stateOfGame.basicData?.gameData
            is MathSortingSticksOrBeadsOrBlocks) ...{
          BlocProvider<SortingBlocksCubit>(
              create: (_) => SortingBlocksCubit(
                  gameData: gamesData[0],
                  subBloc: context.read<CurrentGamePhoneticsCubit>(),
                  tools: (stateOfGame.basicData?.gameData
                          as MathSortingSticksOrBeadsOrBlocks)
                      .tools),
              child: SortingBlocksScreen())
        }
      ],
    );
  }
}
