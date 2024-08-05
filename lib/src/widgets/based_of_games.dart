import 'package:based_of_eng_game/src/core/talk_tts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../based_of_eng_game.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import 'based_of_all_game.dart';
import 'based_of_video_game.dart';

class BasedOfGames extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  const BasedOfGames(
      {super.key, required this.stateOfGame, required this.gamesData});
  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (x) async {
          if ((stateOfGame.basicData?.gameData is Video)) {
            context
                .read<CurrentGamePhoneticsCubit>()
                .state
                .actionWhenTriesBeZero(stateOfGame.countOfStar ?? 0);
          }
          await TalkTts.stopTalk();
        },
        canPop: false,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(stateOfGame.basicData?.background ?? ''),
                  fit: BoxFit.fill)),
          child: Column(
            // alignment: Alignment.center,
            children: [
              if (stateOfGame.basicData?.gameData is Video) ...{
                BasedOfVideoGame(
                  stateOfGame: stateOfGame,
                  gamesData: gamesData,
                )
              } else ...{
                BasedOfAllGame(
                  stateOfGame: stateOfGame,
                  gamesData: gamesData,
                )
              }
            ],
          ),
        ));
  }
}
