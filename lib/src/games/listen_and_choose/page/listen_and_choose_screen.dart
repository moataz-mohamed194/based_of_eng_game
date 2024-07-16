import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src_model/model/game_model.dart';
import '../../../core/games_structure/basic_of_game_data.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/listen_choose_cubit.dart';

class ListenAndChooseScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ListenAndChooseScreen();
  }
}

class _ListenAndChooseScreen extends State<ListenAndChooseScreen> {
  @override
  void initState() {
    final List<GameFinalModel> gameData =
        context.read<ListenChooseCubit>().state.listGameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.length);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.isWord,
        stateOfStringWillSay: gameData.first.sentence ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isInteracting =
        context.watch<CurrentGamePhoneticsCubit>().state.stateOfAvatar;

    return BlocConsumer<ListenChooseCubit, ListenChooseInitial>(
        listener: (context, state) {
      context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
          stateOfStringIsWord: StateOfSubWord.isWord,
          stateOfStringWillSay: state.gameData.sentence ?? '');
    }, builder: (context, gameState) {
      return Container(
        margin: const EdgeInsets.only(bottom: (15 + 50), top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: MediaQuery.of(context).size.width - (130 + 50 + 130),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: AppColorPhonetics.boarderColor, width: 5)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(gameState.choose.length, (index) {
                return Wrap(
                  children: [
                    if (index == 0) ...{
                      Text(
                        '(',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppTheme.getFontFamily5(),
                            color: AppColorPhonetics.darkBorderColor),
                      )
                    },
                    GestureDetector(
                      onTap: () async {
                        if (context
                                .read<CurrentGamePhoneticsCubit>()
                                .ableButton() &&
                            gameState.isCorrect == false) {
                          bool stateOfAnswer = context
                              .read<ListenChooseCubit>()
                              .addAnswer(
                                  userChoose:
                                      gameState.choose[index].letter ?? '');
                          if (stateOfAnswer == true) {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addSuccessAnswer(
                                    questions: gameState.listGameData.length,
                                    correctAnswers:
                                        gameState.countCorrectAnswers + 1)
                                .whenComplete(() {
                              print(
                                  'listGameData:${gameState.listGameData.length}, countCorrectAnswers:${gameState.countCorrectAnswers}');
                              bool isLastQuestion = context
                                  .read<CurrentGamePhoneticsCubit>()
                                  .checkIfIsTheLastQuestionOfGame(
                                      queations: gameState.listGameData.length);
                              if (isLastQuestion) {
                                Future.delayed(const Duration(seconds: 2),
                                    () async {
                                  Navigator.of(context).pop();
                                });
                              } else {
                                Future.delayed(const Duration(seconds: 2),
                                    () async {
                                  await context
                                      .read<CurrentGamePhoneticsCubit>()
                                      .updateIndexOfCurrentGame();
                                  context
                                      .read<ListenChooseCubit>()
                                      .updateTheCurrentGame(
                                          index: context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .state
                                              .index);
                                });
                              }
                            });
                          } else {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addWrongAnswer(
                                    actionOfWrongAnswer: () async {});
                          }
                        }
                      },
                      child: Text(
                        gameState.choose[index].letter ?? '',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppTheme.getFontFamily5(),
                            color: AppColorPhonetics.darkBorderColor),
                      ),
                    ),
                    if (index == (gameState.choose.length - 1)) ...{
                      Text(
                        ')',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppTheme.getFontFamily5(),
                            color: AppColorPhonetics.darkBorderColor),
                      )
                    } else ...{
                      Text(
                        ' - ',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: AppTheme.getFontFamily5(),
                            color: AppColorPhonetics.darkBorderColor),
                      )
                    }
                  ],
                );
              }),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: gameState.images.first.image ?? '',
                  height: 0.31.sh,
                  placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
                20.w.pw,
                Text(
                  gameState.isCorrect
                      ? (gameState.gameData.sentence ?? '')
                      : gameState.images.first.word ?? '',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: AppTheme.getFontFamily5(),
                      color: AppColorPhonetics.darkBorderColor),
                )
              ],
            )
          ],
        ),
      );
    });
  }
}
