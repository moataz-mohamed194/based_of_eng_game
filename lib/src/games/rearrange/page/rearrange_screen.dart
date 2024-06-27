import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../based_of_eng_game.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/rearrange_cubit.dart';

class RearrangeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RearrangeScreen();
  }
}

class _RearrangeScreen extends State<RearrangeScreen> {
  @override
  void initState() {
    final List<GameFinalModel> gameData =
        context.read<RearrangeCubit>().state.listGameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.length);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: false,
        stateOfStringWillSay: gameData.first.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stateOfCurrentGamePhoneticsCubit =
        context.watch<CurrentGamePhoneticsCubit>().state;
    return BlocConsumer<RearrangeCubit, RearrangeInitial>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Container(
            margin: const EdgeInsets.only(bottom: (15 + 50), top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            width: MediaQuery.of(context).size.width - (130 + 50 + 130),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: AppColorPhonetics.boarderColor, width: 5)),
            child: Row(
              children: [
                if(gameState.gameData.gameImages?.first.image!=null && gameState.gameData.gameImages?.first.image!='')...{
                  Expanded(
                    child: CachedNetworkImage(
                      imageUrl: gameState.gameData.gameImages?.first.image ??
                          '',
                      height: 0.33.sh,
                      placeholder: (context, url) =>
                      const Center(
                        child: CupertinoActivityIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                      const Icon(
                        Icons.error,
                        color: Colors.red,
                      ),
                    ),
                  ),
                },
                Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            gameState.userAnswers.length,
                            (index) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: DragTarget<String>(builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return DottedBorder(
                                    // color: Colors.black,
                                    strokeWidth: 1,
                                    dashPattern: [8, 4],
                                    color: AppColorPhonetics.darkBorderColor,
                                    radius: const Radius.circular(12),
                                    // padding: const EdgeInsets.all(6),
                                    child: SizedBox(
                                      width: 25.w,
                                      height: 30.h,
                                      child: Text(
                                        gameState.userAnswers[index],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                                AppTheme.getFontFamily5(),
                                            color: AppColorPhonetics
                                                .darkBorderColor),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }, onAcceptWithDetails: (item) async {
                                  bool? answerState = context
                                      .read<RearrangeCubit>()
                                      .addUserAnswer(
                                          index: index, answer: item.data);
                                  if (answerState != null) {
                                    if (answerState == true) {
                                      await context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .addSuccessAnswer(
                                              questions:
                                                  gameState.listGameData.length,
                                              correctAnswers:
                                                  (gameState.index) + 1)
                                          .whenComplete(() async {
                                        bool isLastQuestion = context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .checkIfIsTheLastQuestionOfGame(
                                                queations: gameState
                                                    .listGameData.length);
                                        if (isLastQuestion) {
                                          Future.delayed(
                                              const Duration(seconds: 2),
                                              () async {
                                            Navigator.of(context).pop();
                                          });
                                        } else {
                                          await context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .updateIndexOfCurrentGame();
                                          context
                                              .read<RearrangeCubit>()
                                              .updateTheCurrentGame(
                                                  index: context
                                                      .read<
                                                          CurrentGamePhoneticsCubit>()
                                                      .state
                                                      .index);
                                        }
                                      });
                                    } else {
                                      await context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .addWrongAnswer(
                                              actionOfWrongAnswer: () async {
                                        context
                                            .read<RearrangeCubit>()
                                            .clearUserAnswer();
                                      });
                                    }
                                  }
                                })),
                          ),
                        ),
                        15.ph,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                              gameState.correctAnswers.length,
                              (index) => Draggable<String>(
                                    data: gameState.correctAnswers[index] ?? '',
                                    childWhenDragging: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        gameState.correctAnswers[index],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                                AppTheme.getFontFamily5(),
                                            color: AppColorPhonetics.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    feedback: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                          color:
                                              AppColorPhonetics.darkBorderColor,
                                          borderRadius:
                                              BorderRadius.circular(7)),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Text(
                                        gameState.correctAnswers[index],
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily:
                                                AppTheme.getFontFamily5(),
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor:  AppColorPhonetics.darkBorderColor,
                                            color: AppColorPhonetics.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    child: ((stateOfCurrentGamePhoneticsCubit
                                                .stateOfAvatar ==
                                            BasicOfGameData.stateOfWin))
                                        ? Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              gameState.correctAnswers[index],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily:
                                                      AppTheme.getFontFamily5(),
                                                  color:
                                                      AppColorPhonetics.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          )
                                        : Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            decoration: BoxDecoration(
                                                color: AppColorPhonetics
                                                    .darkBorderColor,
                                                borderRadius:
                                                    BorderRadius.circular(7)),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: Text(
                                              gameState.correctAnswers[index],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily:
                                                      AppTheme.getFontFamily5(),
                                                  color:
                                                      AppColorPhonetics.white),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                  )),
                        ),
                      ],
                    ))
              ],
            ),
          );
        });
  }
}
