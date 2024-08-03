import 'package:based_of_eng_game/based_of_eng_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/assets_game_sound.dart';
import '../../../core/phonetics_color.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/bingo_arabic_cubit.dart';
import '../widget/arabic_bingo_letter.dart';

class BingoArabicGameScreen extends StatefulWidget {
  const BingoArabicGameScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _BingoArabicGameScreen();
  }
}

class _BingoArabicGameScreen extends State<BingoArabicGameScreen> {
  @override
  void initState() {
    final GameFinalModel gameData =
        context.read<BingoArabicCubit>().state.gameData;
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
    return Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(right: 15.w),
        width: MediaQuery.of(context).size.width - (100.w),
        // height: MediaQuery.of(context).size.height - 150.h,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border:
                Border.all(color: AppColorPhonetics.darkBorderColor, width: 5)),
        child: BlocConsumer<BingoArabicCubit, BingoArabicState>(
            listener: (context, state) {
          context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
              stateOfStringIsWord: StateOfSubWord.isLetter,
              stateOfStringWillSay: state.chooseWord?.letter ?? '');
        }, builder: (context, gameState) {
          return Column(
            children: [
              _buildBingoWord(gameState: gameState),
              _buildGridViewOfLetters(gameState: gameState, context: context),
            ],
          );
        }));
  }

  Widget _buildGridViewOfLetters(
      {required BingoArabicState gameState, required BuildContext context}) {
        print('here');
    final cardsLetters = gameState.cardsLetters ?? [];
    final correctIndexes = gameState.correctAnswersIds;
    final chooseWord = gameState.chooseWord;
    return Center(
      child: Wrap(
        children: List.generate(
          cardsLetters.length,
          (rowIndex) => BlocConsumer<CurrentGamePhoneticsCubit,
              CurrentGamePhoneticsState>(
            listener: (context, state) {},
            builder: (context0, generalStateOfGame) {
              return ArabicBingoLetter(
                body: cardsLetters[rowIndex].letter ?? '',
                maxHeight: MediaQuery.of(context).size.height - 162.h,
                maxWidth: MediaQuery.of(context).size.width - (107.w),
                isCorrect: correctIndexes.contains(cardsLetters[rowIndex].id),
                index: rowIndex,
                onTap: () async {
                  if (context.read<CurrentGamePhoneticsCubit>().ableButton()) {
                    if ((correctIndexes.isEmpty) ||
                        correctIndexes.contains(cardsLetters[rowIndex].id) ==
                            false) {
                      if ((chooseWord?.letter ==
                          cardsLetters[rowIndex].letter)) {
                        context.read<BingoArabicCubit>().addTheCorrectAnswer(
                            idOfUserAnswer: cardsLetters[rowIndex].id ?? 0,
                            index: rowIndex);
                        await context
                            .read<CurrentGamePhoneticsCubit>()
                            .addSuccessAnswer(
                                isArabic: true,
                                specificSoundPath: (cardsLetters
                                            .where(
                                                (element) => element.id != null)
                                            .length) <=
                                        (correctIndexes.length)
                                    ? AppGameSound.bingo
                                    : null,
                                subAction: () async {
                                  await context
                                      .read<BingoArabicCubit>()
                                      .getTheRandomWord();
                                },
                                questions: cardsLetters
                                    .where((element) => element.id != null)
                                    .length,
                                correctAnswers:
                                    gameState.correctAnswersIds.length);
                      } else {
                        await context
                            .read<CurrentGamePhoneticsCubit>()
                            .addWrongAnswer(
                                isArabic: true,
                                actionOfWrongAnswer: () async {
                                  await context
                                      .read<BingoArabicCubit>()
                                      .sayTheLetter();
                                });
                      }
                    }
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBingoWord({required BingoArabicState gameState}) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue.withOpacity(0.5), width: 1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: 'Bingo'.split('').asMap().entries.map((entry) {
          final letter = entry.value;
          int index = entry.key;
          return StrokeText(
              text: letter,
              isDisabled: false,
              color: index + 1 <= gameState.countOfBingoLetters
                  ? Colors.green
                  : null);
        }).toList(),
      ),
    );
  }
}
