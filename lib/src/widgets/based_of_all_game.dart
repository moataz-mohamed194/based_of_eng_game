import 'package:based_of_eng_game/src/widgets/based_of_connect_games_ar.dart';
import 'package:based_of_eng_game/src/widgets/based_of_game_arabic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../based_of_eng_game.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import 'based_of_game_connect.dart';
import 'based_of_game_connect_sorting_cups.dart';
import 'based_of_game_phonetics.dart';
import 'based_of_game_short_vowels.dart';
import 'based_of_game_short_vowels_text_rive.dart';
import 'based_of_game_up_vowels.dart';
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
        if (stateOfGame.countOfTries == 0)
          ...{}
        else ...{
          SizedBox(
            height: (MediaQuery.of(context).size.height - (50.h + 5)),
            child: Column(
              children: [
                if (stateOfGame.basicData is ShortVowels) ...{
                  if (stateOfGame.basicData?.gameData?.isConnect == true) ...{
                    BasedOfGameShortVowelsTextNextRive(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  } else ...{
                    BasedOfGameShortVowels(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  }
                } else if (stateOfGame.basicData is UpVowels) ...{
                  if (stateOfGame.basicData?.gameData?.isConnect == true) ...{
                    if (stateOfGame.basicData?.gameData is SortingCupsGame) ...{
                      BasedOfGameConnectSortingCups(
                        stateOfGame: stateOfGame,
                        gamesData: gamesData,
                      ),
                    } else ...{
                      BasedOfGameShortVowelsTextNextRive(
                        stateOfGame: stateOfGame,
                        gamesData: gamesData,
                      ),
                    }
                  } else ...{
                    BasedOfGameUpVowels(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  }
                } else if (stateOfGame.basicData?.gameData?.isConnect ==
                    true) ...{
                  if (stateOfGame.basicData is ConnectionSortingCups) ...{
                    if (BaseOfGames.isArabic(
                        chapter: stateOfGame.basicData?.gameData.runtimeType ??
                            Type)) ...{
                      BasedOfGameConnectSortingCupsAr(
                        stateOfGame: stateOfGame,
                        gamesData: gamesData,
                      ),
                    } else ...{
                      BasedOfGameConnectSortingCups(
                        stateOfGame: stateOfGame,
                        gamesData: gamesData,
                      ),
                    }
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
                } else if (BaseOfGames.isArabic(
                    chapter: stateOfGame.basicData.runtimeType)) ...{
                  BasedOfGameArabic(
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
