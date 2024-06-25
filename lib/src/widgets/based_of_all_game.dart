import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';

import '../../based_of_eng_game.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import 'based_of_game_connect.dart';
import 'based_of_game_connect_sorting_cups.dart';
import 'based_of_game_phonetics.dart';
import 'game_bar.dart';
import 'widget_of_tries.dart';

class BasedOfAllGame extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;
  final List<GameFinalModel> gamesData;

  const BasedOfAllGame(
      {super.key, required this.stateOfGame, required this.gamesData});

  @override
  Widget build(BuildContext context) {
    return Column(
      // alignment: Alignment.center,
      children: [
        GameBar(stateOfGame: stateOfGame),
        if (stateOfGame.countOfTries == 0) ...{
          widgetOfTries(
            context: context,
            stateOfGame: stateOfGame,
            actionOfDone: () {
              context
                  .read<CurrentGamePhoneticsCubit>()
                  .state
                  .actionWhenTriesBeZero(context
                          .read<CurrentGamePhoneticsCubit>()
                          .state
                          .countOfStar ??
                      0);
              Navigator.of(context).pop();
            },
            backButton: () {
              context
                  .read<CurrentGamePhoneticsCubit>()
                  .state
                  .actionWhenTriesBeZero(context
                          .read<CurrentGamePhoneticsCubit>()
                          .state
                          .countOfStar ??
                      0);
              Navigator.of(context).pop();
            },
          )
        } else ...{
          SizedBox(
            height: (MediaQuery.of(context).size.height - (50.h + 5)),
            child: Column(
              children: [
                if (stateOfGame.basicData?.gameData?.isConnect == true) ...{
                  if (stateOfGame.basicData is ConnectionSortingCups) ...{
                    BasedOfGameConnectSortingCups(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  } else ...{
                    BasedOfGameConnect(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  }
                } else if (BaseOfGames.isPhonetics(
                    chapter: stateOfGame.basicData.runtimeType)) ...{
                  BasedOfGamePhonetics(
                    stateOfGame: stateOfGame,
                    gamesData: gamesData,
                  ),
                } else ...{
                  const SizedBox()
                }
              ],
            ),
          ),
        }
      ],
    );
  }
}