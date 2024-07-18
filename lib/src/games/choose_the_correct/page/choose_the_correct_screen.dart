import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../based_of_eng_game.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/choose_the_correct_cubit.dart';

class ChooseTheCorrectScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChooseTheCorrectScreen();
  }
}

class _ChooseTheCorrectScreen extends State<ChooseTheCorrectScreen> {
  @override
  void initState() {
    final List<GameFinalModel> gamesData =
        context.read<ChooseTheCorrectCubit>().state.listGameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gamesData.length);
    print(
        '@@@:${"${gamesData.first.inst ?? ''} ${gamesData.first.sentence ?? ''}"}');
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.isWord,
        stateOfStringWillSay: gamesData.first.sentence ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isInteracting =
        context.watch<CurrentGamePhoneticsCubit>().state.stateOfAvatar;

    return BlocConsumer<ChooseTheCorrectCubit, ChooseTheCorrectInitial>(
        listener: (context, state) {
      context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
          stateOfStringIsWord: StateOfSubWord.isWord,
          stateOfStringWillSay: state.gameData.sentence ?? '');
    }, builder: (context, gameState) {
      return Container(
        margin: const EdgeInsets.only(bottom: (40), top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        width: MediaQuery.of(context).size.width - (130 + 50 + 130),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: AppColorPhonetics.boarderColor, width: 5)),
        child: Column(
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
            10.ph,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  gameState.isCorrect
                      ? (gameState.gameData.sentence ?? '')
                      : gameState.images.first.word ?? '',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: AppTheme.getFontFamily5(),
                      color: AppColorPhonetics.darkBorderColor),
                ),
                10.ph,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      gameState.choose.length,
                      (index) => Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  if (context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .ableButton() &&
                                      gameState.isCorrect == false) {
                                    bool stateOfAnswer = context
                                        .read<ChooseTheCorrectCubit>()
                                        .addAnswer(
                                            userChoose: gameState
                                                    .choose[index].letter ??
                                                '');
                                    if (stateOfAnswer == true) {
                                      await context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .addSuccessAnswer(
                                              questions:
                                                  gameState.listGameData.length,
                                              correctAnswers: gameState
                                                      .countCorrectAnswers +
                                                  1)
                                          .whenComplete(() {
                                        print(
                                            'listGameData:${gameState.listGameData.length}, countCorrectAnswers:${gameState.countCorrectAnswers}');
                                        bool isLastQuestion = context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .checkIfIsTheLastQuestionOfGame(
                                                queations: gameState
                                                    .listGameData.length);
                                        if (isLastQuestion) {
                                          // Future.delayed(
                                          //     const Duration(seconds: 2),
                                          //     () async {
                                          //   Navigator.of(context).pop();
                                          // });
                                        } else {
                                          Future.delayed(
                                              const Duration(seconds: 2),
                                              () async {
                                            await context
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .updateIndexOfCurrentGame();
                                            context
                                                .read<ChooseTheCorrectCubit>()
                                                .updateTheCurrentGame(
                                                    index: context
                                                        .read<
                                                            CurrentGamePhoneticsCubit>()
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
                                child: DottedBorder(
                                  strokeWidth: 1,
                                  dashPattern: [4, 4],
                                  // strokeCap : StrokeCap.round,

                                  borderType: BorderType.RRect,
                                  radius: const Radius.circular(7),
                                  color: AppColorPhonetics.darkBorderColor,
                                  padding: EdgeInsets.all(4),

                                  // stackFit : StackFit.passthrough,
                                  child: Text(
                                    gameState.choose[index].letter ?? '',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontFamily: AppTheme.getFontFamily5(),
                                        color:
                                            AppColorPhonetics.darkBorderColor),
                                  ),
                                ),
                              ),
                              10.pw,
                            ],
                          )),
                ),
                // 10.ph
              ],
            )
          ],
        ),
        // child:
      );
    });
  }
}
