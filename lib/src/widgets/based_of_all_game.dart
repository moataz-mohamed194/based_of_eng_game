import 'package:based_of_eng_game/src/widgets/based_of_culture_games.dart';
import 'package:based_of_eng_game/src/widgets/based_of_full_board_games_ar.dart';
import 'package:based_of_eng_game/src/widgets/based_of_game_arabic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../based_of_eng_game.dart';
import '../cubit/current_game_phonetics_cubit.dart';
import 'based_of_game_connect.dart';
import 'based_of_game_connect_sorting_cups.dart';
import 'based_of_game_phonetics.dart';
import 'based_of_game_short_vowels_text_rive.dart';
import 'based_of_game_up_and_short_vowels.dart';
import 'based_of_math.dart';
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
        if (stateOfGame.countOfTries == 0 || stateOfGame.showAlert == true)
          ...{}
        else ...{
          SizedBox(
            height: (MediaQuery.of(context).size.height - (50.h + 5)),
            child: Column(
              children: [
                if (stateOfGame.basicData is Culture) ...{
                  BasedOfCultureGames(
                    stateOfGame: stateOfGame,
                    gamesData: gamesData,
                  )
                } else if (stateOfGame.basicData is ShortVowels) ...{
                  if (stateOfGame.basicData?.gameData?.isConnect == true) ...{
                    BasedOfGameShortVowelsTextNextRive(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  } else ...{
                    BasedOfGameUpAndShortVowels(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  }
                } else if (stateOfGame.basicData is ConsonantVowels) ...{
                  if (stateOfGame.basicData?.gameData?.isConnect == true) ...{
                    BasedOfGameShortVowelsTextNextRive(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  } else ...{
                    BasedOfGameUpAndShortVowels(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  }
                } else if (stateOfGame.basicData is RUnitPhonics) ...{
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
                    BasedOfGameUpAndShortVowels(
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
                    BasedOfGameUpAndShortVowels(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  }
                } else if (stateOfGame.basicData is MathProgram) ...{
                  BasedOfMath(
                    stateOfGame: stateOfGame,
                    gamesData: gamesData,
                  )
                } else if (stateOfGame.basicData?.gameData?.isConnect ==
                    true) ...{
                  if (stateOfGame.basicData is ConnectionSortingCups) ...{
                    BasedOfGameConnectSortingCups(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                      isArabic: stateOfGame.basicData?.isArabic ?? false,
                    ),
                  } else if (stateOfGame.basicData is FirstUnitArabic) ...{
                    BasedOfFullBoardGamesAr(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    )
                  } else ...{
                    BasedOfGameConnect(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                      isArabic: stateOfGame.basicData?.isArabic ?? false,
                    ),
                  }
                } else if (HandlingActionsAndDataOfChapters.isPhonetics(
                    chapter: stateOfGame.basicData.runtimeType)) ...{
                  BasedOfGamePhonetics(
                    stateOfGame: stateOfGame,
                    gamesData: gamesData,
                  ),
                } else if (HandlingActionsAndDataOfChapters.isArabic(
                    chapter: stateOfGame.basicData.runtimeType)) ...{
                  if (stateOfGame.basicData?.gameData is CompleteTheWord ||
                      stateOfGame.basicData?.gameData is ClickOnTheFish ||
                      stateOfGame.basicData?.gameData
                          is ChooseTheStretchedLetter ||
                      stateOfGame.basicData?.gameData
                          is ChooseTheStretchedWord ||
                      stateOfGame.basicData?.gameData
                          is CompleteTheStretchedLetter) ...{
                    BasedOfFullBoardGamesAr(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    )
                  } else ...{
                    BasedOfGameArabic(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  }
                } else if (stateOfGame.basicData is MathProgram) ...{
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
                    BasedOfGameUpAndShortVowels(
                      stateOfGame: stateOfGame,
                      gamesData: gamesData,
                    ),
                  }
                } else if (stateOfGame.basicData is RUnitArabic ||
                    stateOfGame.basicData is FirstUnitArabic) ...{
                  BasedOfFullBoardGamesAr(
                    stateOfGame: stateOfGame,
                    gamesData: gamesData,
                  )
                }
              ],
            ),
          ),
        }
      ],
    );
  }
}
