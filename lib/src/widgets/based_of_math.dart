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
import '../games/math/CT_number/manager/ct_number_cubit.dart';
import '../games/math/CT_number/screen/ct_number_screen.dart';
import '../games/math/DDT_change/manager/ddt_number_cubit.dart';
import '../games/math/DDT_change/screen/ddt_number_screen.dart';
import '../games/math/add_bead_number_line/manager/add_bead_number_line_cubit.dart';
import '../games/math/add_bead_number_line/screen/add_bead_number_line_screen.dart';
import '../games/math/add_rod_number_line/manager/add_rod_number_line_cubit.dart';
import '../games/math/add_rod_number_line/screen/add_rod_number_line_screen.dart';
import '../games/math/choose_OE/manager/choose_oe_cubit.dart';
import '../games/math/choose_OE/screen/choose_oe_screen.dart';
import '../games/math/choose_add/manager/choose_add_cubit.dart';
import '../games/math/choose_add/screen/choose_add_screen.dart';
import '../games/math/choose_add_beads_line/manager/choose_add_beads_line_cubit.dart';
import '../games/math/choose_add_beads_line/screen/choose_add_beads_line_screen.dart';
import '../games/math/choose_add_line/manager/choose_add_line_cubit.dart';
import '../games/math/choose_add_line/screen/choose_add_line_screen.dart';
import '../games/math/choose_from_obj/manager/choose_sticks_cubit.dart';
import '../games/math/choose_from_obj/screen/choose_sticks_screen.dart';
import '../games/math/choose_number/manager/choose_number_cubit.dart';
import '../games/math/choose_number/screen/choose_numbers_screen.dart';
import '../games/math/choose_number_from_wood/manager/choose_number_from_wood_cubit.dart';
import '../games/math/choose_number_from_wood/screen/choose_number_from_wood_screen.dart';
import '../games/math/choose_number_oe/manager/choose_number_oe_cubit.dart';
import '../games/math/choose_number_oe/screen/choose_numbers_oe_screen.dart';
import '../games/math/choose_sub/manager/choose_sub_cubit.dart';
import '../games/math/choose_sub/screen/choose_sub_screen.dart';
import '../games/math/count_type_number/manager/count_type_number_cubit.dart';
import '../games/math/count_type_number/screen/count_type_number_screen.dart';
import '../games/math/drag_add/manager/drag_add_cubit.dart';
import '../games/math/drag_add/screen/drag_add_screen.dart';
import '../games/math/drag_oe/manager/drag_oe_cubit.dart';
import '../games/math/drag_oe/screen/drag_oe_screen.dart';
import '../games/math/drag_sticks/manager/drag_sticks_cubit.dart';
import '../games/math/drag_sticks/screen/drag_sticks_screen.dart';
import '../games/math/drag_sub/manager/choose_sub_cubit.dart';
import '../games/math/drag_sub/screen/drag_sub_screen.dart';
import '../games/math/sorting_beads/manager/sorting_blocks_cubit.dart';
import '../games/math/sorting_beads/screen/sorting_blocks_screen.dart';
import '../games/math/sorting_blocks/manager/sorting_blocks_cubit.dart';
import '../games/math/sorting_blocks/screen/sorting_blocks_screen.dart';
import '../games/math/sub_rods_choose_number/manager/sub_rods_choose_number_cubit.dart';
import '../games/math/sub_rods_choose_number/screen/sub_rods_choose_number_screen.dart';

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
        } else if (stateOfGame.basicData?.gameData is MathSortingBeads) ...{
          BlocProvider<SortingBeadsCubit>(
              create: (_) => SortingBeadsCubit(
                  gameData: gamesData[0],
                  subBloc: context.read<CurrentGamePhoneticsCubit>(),
                  tools: (stateOfGame.basicData?.gameData as MathSortingBeads)
                      .tools),
              child: SortingBeadsScreen())
        } else if (stateOfGame.basicData?.gameData is MathChooseOEDomino) ...{
          BlocProvider<ChooseOeCubit>(
              create: (_) => ChooseOeCubit(
                  allGameData: gamesData,
                  basicData: stateOfGame.basicData!.gameData!),
              child: BlocListener<ChooseOeCubit, ChooseOeInitial>(
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
                  child: ChooseOeScreen()))
        } else if (stateOfGame.basicData?.gameData is MathDragDominoOE) ...{
          BlocProvider<DragOeCubit>(
              create: (_) => DragOeCubit(
                  allGameData: gamesData,
                  subBloc: context.read<CurrentGamePhoneticsCubit>(),
                  tools: (stateOfGame.basicData?.gameData as MathDragDominoOE)
                      .tools),
              child: BlocListener<DragOeCubit, DragOeInitial>(
                  listener: (context, state) {}, child: DragOeScreen()))
        } else if (stateOfGame.basicData?.gameData is MathChooseBeadsOE) ...{
          BlocProvider<ChooseNumberOECubit>(
            create: (_) => ChooseNumberOECubit(
                allGameData: gamesData,
                basicData: stateOfGame.basicData!.gameData!),
            child: BlocListener<ChooseNumberOECubit, ChooseNumberOEInitial>(
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
                child: ChooseNumberOEScreen()),
          )
        } else if (stateOfGame.basicData?.gameData is MathDragSticks) ...{
          BlocProvider<DragSticksCubit>(
            create: (_) => DragSticksCubit(
                allGameData: gamesData,
                subBloc: context.read<CurrentGamePhoneticsCubit>()),
            child: DragSticksScreen(),
          )
        } else if (stateOfGame.basicData?.gameData is CTNumberGame) ...{
          BlocProvider<CtNumberCubit>(
            create: (_) => CtNumberCubit(
              allGameData: gamesData,
              subBloc: context.read<CurrentGamePhoneticsCubit>(),
              tools: (stateOfGame.basicData!.gameData! as CTNumberGame).tools,
              showLineOfNumbers:
                  (stateOfGame.basicData!.gameData! as CTNumberGame)
                      .showLineOfNumbers,
            ),
            child: CtNumberScreen(),
          )
        } else if (stateOfGame.basicData?.gameData is DDTChangeGame) ...{
          BlocProvider<DDTChangeCubit>(
            create: (_) => DDTChangeCubit(
              allGameData: gamesData,
              subBloc: context.read<CurrentGamePhoneticsCubit>(),
            ),
            child: DDtNumberScreen(),
          )
        } else if (stateOfGame.basicData?.gameData is MathChooseBlocksAdd) ...{
          BlocProvider<ChooseAddCubit>(
            create: (_) => ChooseAddCubit(
                allGameData: gamesData,
                tools: (stateOfGame.basicData!.gameData! as MathChooseBlocksAdd)
                    .tools),
            child: BlocListener<ChooseAddCubit, ChooseAddInitial>(
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
                child: ChooseAddScreen()),
          )
        } else if (stateOfGame.basicData?.gameData is MathChooseBlocksSub) ...{
          BlocProvider<ChooseSubCubit>(
            create: (_) => ChooseSubCubit(
                allGameData: gamesData,
                tools: (stateOfGame.basicData!.gameData! as MathChooseBlocksSub)
                    .tools),
            child: BlocListener<ChooseSubCubit, ChooseSubInitial>(
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
                child: ChooseSubScreen()),
          )
        } else if (stateOfGame.basicData?.gameData is MathDragBlocksSub) ...{
          BlocProvider<DragSubCubit>(
            create: (_) => DragSubCubit(
                allGameData: gamesData,
                tools: (stateOfGame.basicData!.gameData! as MathDragBlocksSub)
                    .tools),
            child: BlocListener<DragSubCubit, DragSubInitial>(
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
                child: DragSubScreen()),
          )
        } else if (stateOfGame.basicData?.gameData
            is MathChooseBlocksAddLine) ...{
          BlocProvider<ChooseAddLineCubit>(
            create: (_) => ChooseAddLineCubit(
                allGameData: gamesData,
                tools: (stateOfGame.basicData!.gameData!
                        as MathChooseBlocksAddLine)
                    .tools),
            child: BlocListener<ChooseAddLineCubit, ChooseAddLineInitial>(
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
                child: ChooseAddLineScreen()),
          )
        } else if (stateOfGame.basicData?.gameData
            is MathChooseBeadsAddLine) ...{
          BlocProvider<ChooseAddBeadsLineCubit>(
            create: (_) => ChooseAddBeadsLineCubit(
                allGameData: gamesData,
                tools:
                    (stateOfGame.basicData!.gameData! as MathChooseBeadsAddLine)
                        .tools),
            child: BlocListener<ChooseAddBeadsLineCubit,
                    ChooseAddBeadsLineInitial>(
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
                child: ChooseAddBeadsLineScreen()),
          )
        } else if (stateOfGame.basicData?.gameData is MathDragBlocksAdd) ...{
          BlocProvider<DragAddCubit>(
            create: (_) => DragAddCubit(
                allGameData: gamesData,
                tools: (stateOfGame.basicData!.gameData! as MathDragBlocksAdd)
                    .tools),
            child: BlocListener<DragAddCubit, DragAddInitial>(
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
                child: DragAddScreen()),
          )
        } else if (stateOfGame.basicData?.gameData is MathChooseBoard) ...{
          BlocProvider<ChooseNumberFromWoodCubit>(
            create: (_) => ChooseNumberFromWoodCubit(
              allGameData: gamesData,
              tools:
                  (stateOfGame.basicData!.gameData! as MathChooseBoard).tools,
            ),
            child: BlocListener<ChooseNumberFromWoodCubit,
                    ChooseNumberFromWoodInitial>(
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
                child: ChooseNumberFromWoodScreen()),
          )
        } else if (stateOfGame.basicData?.gameData is AddRodNumberLineGame) ...{
          BlocProvider<AddRodNumberLineCubit>(
            create: (_) => AddRodNumberLineCubit(
              allGameData: gamesData,
              tools: (stateOfGame.basicData!.gameData! as AddRodNumberLineGame)
                  .tools,
            ),
            child: BlocListener<AddRodNumberLineCubit, AddRodNumberLineInitial>(
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
                child: AddRodNumberLineScreen()),
          )
        } else if (stateOfGame.basicData?.gameData is CountTypeNumber) ...{
          BlocProvider<CountTypeNumberCubit>(
            create: (_) => CountTypeNumberCubit(
              allGameData: gamesData,
              tools:
                  (stateOfGame.basicData!.gameData! as CountTypeNumber).tools,
            ),
            child: BlocListener<CountTypeNumberCubit, CountTypeNumberInitial>(
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
                child: CountTypeNumberScreen()),
          )
        } else if (stateOfGame.basicData?.gameData
            is SubRodsChooseNumberGame) ...{
          BlocProvider<SubRodsChooseNumberCubit>(
            create: (_) => SubRodsChooseNumberCubit(
              allGameData: gamesData,
              tools:
                  (stateOfGame.basicData!.gameData! as SubRodsChooseNumberGame)
                      .tools,
            ),
            child: BlocListener<SubRodsChooseNumberCubit,
                    SubRodsChooseNumberInitial>(
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
                child: SubRodsChooseNumberScreen()),
          )
        } else if (stateOfGame.basicData?.gameData
            is AddBeadNumberLineGame) ...{
          BlocProvider<AddBeadNumberLineCubit>(
            create: (_) => AddBeadNumberLineCubit(
              allGameData: gamesData,
              tools: (stateOfGame.basicData!.gameData! as AddBeadNumberLineGame)
                  .tools,
            ),
            child:
                BlocListener<AddBeadNumberLineCubit, AddBeadNumberLineInitial>(
                    listener: (context, state) {
                      final List<GameFinalModel> gameData = gamesData;
                      context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
                          mainCountOfQuestion: gameData.length);
                      context
                          .read<CurrentGamePhoneticsCubit>()
                          .saveTheStringWillSay(
                              stateOfStringIsWord: StateOfSubWord.stopTalk,
                              stateOfStringWillSay: gameData.first.inst ?? '');
                    },
                    child: AddBeadNumberLineScreen()),
          )
        }
      ],
    );
  }
}
