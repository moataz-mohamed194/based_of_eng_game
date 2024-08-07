import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../src_model/export_models.dart';

import '../../based_of_eng_game.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import '../games/videos/cubit/video_cubit.dart';
import '../games/videos/screen/game_video.dart';
import 'game_bar.dart';

class BasedOfVideoGame extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  const BasedOfVideoGame(
      {super.key, required this.stateOfGame, required this.gamesData});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: BlocProvider<VideoCubit>(
              create: (_) => VideoCubit(
                gameData: gamesData[stateOfGame.index],
              ),
              child: const GameVideo(),
            ),
          ),
          GameBar(stateOfGame: stateOfGame),
        ],
      ),
    );
  }
}
