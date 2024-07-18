import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/games_structure/basic_of_game_data.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/bingo_cubit.dart';
import '../widget/item_card_widget.dart';

class BingoGameScreen extends StatefulWidget {
  const BingoGameScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BingoGameScreen();
  }
}

class _BingoGameScreen extends State<BingoGameScreen> {
  @override
  void initState() {
    final GameFinalModel gameData = context.read<BingoCubit>().state.gameData;
    context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
        mainCountOfQuestion: gameData.gameLetters
                ?.where((element) => element.id != null)
                .toList()
                .length ??
            0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isInteracting =
        context.watch<CurrentGamePhoneticsCubit>().state.stateOfAvatar;

    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 15.w),
        width: MediaQuery.of(context).size.width - (100.w),
        // height: MediaQuery.of(context).size.height - 150.h,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: AppColorPhonetics.darkBorderColor, width: 5)),
        child:
            BlocConsumer<BingoCubit, BingoInitial>(listener: (context, state) {
          context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
              stateOfStringIsWord: StateOfSubWord.isLetter,
              stateOfStringWillSay: state.chooseWord?.letter ?? '');
        }, builder: (context, gameState) {
          return Center(
              child: Wrap(
            children: List.generate(
                (gameState.cardsLetters)?.length ?? 0,
                (rowIndex) => (gameState.cardsLetters)?[rowIndex].id == null
                    ? Container(
                        alignment: Alignment.center,
                        color: AppColorPhonetics.darkBorderColor,
                        width:
                            (MediaQuery.of(context).size.width - (106.w)) / 3,
                        height:
                            (MediaQuery.of(context).size.height - 162.h) / 3,
                        child: Text(
                          'Bingo',
                          style: TextStyle(
                              fontSize: 23.sp,
                              fontFamily: AppTheme.getFontFamily5(),
                              color: Colors.white),
                        ))
                    : BlocConsumer<CurrentGamePhoneticsCubit,
                            CurrentGamePhoneticsState>(
                        listener: (context, state) {},
                        builder: (context0, generalStateOfGame) {
                          return ItemCardWidget(
                            body: (gameState.cardsLetters)?[rowIndex].letter ??
                                '',
                            maxHeight:
                                MediaQuery.of(context).size.height - 162.h,
                            maxWidth:
                                MediaQuery.of(context).size.width - (107.w),
                            hide: gameState.correctIndexes.contains(
                                (gameState.cardsLetters)?[rowIndex].id),
                            index: rowIndex,
                            onTap: () async {
                              if (context
                                  .read<CurrentGamePhoneticsCubit>()
                                  .ableButton()) {
                                if ((gameState.correctIndexes.isEmpty) ||
                                    gameState.correctIndexes.contains(
                                            (gameState.cardsLetters)?[rowIndex]
                                                .id) ==
                                        false) {
                                  if ((gameState.chooseWord?.letter ==
                                      (gameState.cardsLetters)?[rowIndex]
                                          .letter)) {
                                    await context
                                        .read<BingoCubit>()
                                        .addTheCorrectAnswer(
                                            idOfUserAnswer:
                                                (gameState.cardsLetters)?[
                                                            rowIndex]
                                                        .id ??
                                                    0);
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addSuccessAnswer(
                                            subAction: () async {
                                              await context
                                                  .read<BingoCubit>()
                                                  .getTheRandomWord();
                                            },
                                            questions: gameState.cardsLetters
                                                    ?.where((element) =>
                                                        element.id != null)
                                                    .length ??
                                                0,
                                            correctAnswers:
                                                gameState.correctIndexes.length)
                                        .whenComplete(() async {
                                      bool isLastQuestion = context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .secondWayToCheckIfIsTheLastQuestionOfGame(
                                              queations: gameState.cardsLetters
                                                      ?.where((element) =>
                                                          element.id != null)
                                                      .length ??
                                                  0);
                                      if (isLastQuestion) {
                                        // Future.delayed(
                                        //     const Duration(seconds: 2),
                                        //     () async {
                                        //   Navigator.of(context).pop();
                                        // });
                                      } else {}
                                    });
                                  } else {
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addWrongAnswer(
                                            actionOfWrongAnswer: () async {
                                      await context
                                          .read<BingoCubit>()
                                          .sayTheLetter();
                                    });
                                  }
                                }
                              }
                            },
                          );
                        })),
          ));
        }));
  }
}
