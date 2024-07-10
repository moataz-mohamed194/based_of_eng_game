import 'package:based_of_eng_game/src/core/talk_tts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../src_model/export_models.dart';

import '../core/games_structure/basic_of_chapter.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import '../widgets/based_of_games.dart';

class MainScreenOfGames extends StatefulWidget {
  final List<GameFinalModel> stateOfGameData;
  final MainDataOfChapters? dataOfBasesGame;
  final bool showTheEditedGames;
  final void Function(int countOfStars) actionOfCompleteGame;
  final void Function() backButton;

  const MainScreenOfGames(
      {super.key,
      required this.stateOfGameData,
      required this.dataOfBasesGame,
      required this.backButton,
      required this.actionOfCompleteGame,
      required this.showTheEditedGames});
  @override
  State<StatefulWidget> createState() {
    return _MainScreenOfGames();
  }
}

class _MainScreenOfGames extends State<MainScreenOfGames> {
  @override
  void initState() {
    super.initState();
    // context.read<CurrentGameCubit>().getTheBackGround();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    TalkTts.reBackTheDefaultValue();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider<CurrentGamePhoneticsCubit>(
            create: (_) => CurrentGamePhoneticsCubit(
                basicData: widget.dataOfBasesGame!,
                gameData: widget.stateOfGameData,
                backButton: widget.backButton,
                actionOfCompleteGame: widget.actionOfCompleteGame,
                context: context),
            child: BlocConsumer<CurrentGamePhoneticsCubit,
                    CurrentGamePhoneticsState>(
                listener: (context, state) {},
                builder: (context, stateOfGame) {
                  return Listener(
                    onPointerDown: (opm) {
                      context
                          .read<CurrentGamePhoneticsCubit>()
                          .savePointerPosition(opm.pointer, opm.position);
                    },
                    onPointerMove: (opm) {
                      context
                          .read<CurrentGamePhoneticsCubit>()
                          .savePointerPosition(opm.pointer, opm.position);
                    },
                    onPointerCancel: (opm) {
                      context
                          .read<CurrentGamePhoneticsCubit>()
                          .clearPointerPosition(opm.pointer);
                    },
                    onPointerUp: (opm) {
                      context
                          .read<CurrentGamePhoneticsCubit>()
                          .clearPointerPosition(opm.pointer);
                    },
                    child: BasedOfGames(
                      stateOfGame: stateOfGame,
                      gamesData: widget.showTheEditedGames
                          ? widget.stateOfGameData
                          : widget.stateOfGameData
                              .where((element) => element.isEdited == 0)
                              .toList(),
                    ),
                  );
                })));
  }
}
