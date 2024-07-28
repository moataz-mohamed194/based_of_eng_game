import 'package:based_of_eng_game/src/core/game_types/assets_images_arabic.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/assets_images_phonetics.dart';
import '../../../core/games_structure/basic_of_game_data.dart';
import '../../../core/phonetics_color.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/click_the_sound_cubit.dart';
import '../widgets/stroked_text_widget.dart';

class ClickTheSoundGame extends StatefulWidget {
  const ClickTheSoundGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClickTheSoundGame();
  }
}

class _ClickTheSoundGame extends State<ClickTheSoundGame> {
  @override
  void initState() {
    final GameFinalModel gameData =
        context.read<ClickTheSoundCubit>().state.gameData;
    context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
        mainCountOfQuestion: gameData.gameLetters
                ?.where((element) => element.letter == gameData.mainLetter)
                .toList()
                .length ??
            0);

    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.isLetter,
        stateOfStringWillSay: gameData.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isInteracting =
        context.watch<CurrentGamePhoneticsCubit>().state.stateOfAvatar;
    return Container(
      margin: const EdgeInsets.only(bottom: 30, top: 50, left: 70),
      width: MediaQuery.of(context).size.width - 100.w,
      height: MediaQuery.of(context).size.width < 760
          ? MediaQuery.of(context).size.height * 0.7
          : MediaQuery.of(context).size.height * 0.65,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColorPhonetics.darkBorderColor, width: 8),
      ),
      child: FittedBox(
        child: SizedBox(
            // width: MediaQuery.of(context).size.width,
            child: BlocConsumer<ClickTheSoundCubit, ClickTheSoundInitial>(
                listener: (context, state) {},
                builder: (context, stateOfGame) {
                  int count =
                      ((stateOfGame.gameData.gameLetters?.length ?? 0) / 2)
                          .round();
                  List<GameLettersGameFinalModel> firstLetters =
                      stateOfGame.letters?.sublist(0, count) ?? [];
                  List<GameLettersGameFinalModel> secondLetters =
                      stateOfGame.letters?.sublist(count,
                              stateOfGame.gameData.gameLetters?.length) ??
                          [];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _subRow(firstLetters, stateOfGame),
                      MediaQuery.of(context).size.height > 650
                          ? 110.h.ph
                          : 20.ph,
                      _subRow(secondLetters, stateOfGame),
                    ],
                  );
                })),
      ),
    );
  }

  _subRow(List<GameLettersGameFinalModel> firstLetters,
      ClickTheSoundInitial stateOfGame) {
    final currentAnswer = stateOfGame.gameData.mainLetter;
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: List.generate((firstLetters.length), (index) {
            final currentLetter = firstLetters[index].letter ?? '';
            return Expanded(
              child: _buildBubbleWidget(
                letter: firstLetters[index].letter ?? '',
                viewModel: context.read<ClickTheSoundCubit>(),
                index: firstLetters[index].id ?? 0,
                onPress: (context
                            .read<ClickTheSoundCubit>()
                            .state
                            .correctIndexes
                            ?.contains(firstLetters[index].id ?? 0) ??
                        false)
                    ? null
                    : () async {
                        if (context
                            .read<CurrentGamePhoneticsCubit>()
                            .ableButton()) {
                          print(
                              '###:${(context.read<CurrentGamePhoneticsCubit>().ableButton())}');
                          if (currentAnswer == null
                              ? false
                              : currentLetter.contains(currentAnswer)) {
                            await context
                                .read<ClickTheSoundCubit>()
                                .incrementCorrectAnswerCount(
                                    firstLetters[index].id ?? 0);
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addSuccessAnswer(
                                    isArabic: stateOfGame.isArabic,
                                    questions: stateOfGame.letters
                                            ?.where((element) =>
                                                element.letter ==
                                                stateOfGame.gameData.mainLetter)
                                            .length ??
                                        0,
                                    subAction: () {
                                      context
                                          .read<ClickTheSoundCubit>()
                                          .sayTheLetter();
                                    },
                                    correctAnswers:
                                        ((stateOfGame.correctIndexes?.length ??
                                            0)))
                                .whenComplete(() {
                              bool isLastQuestion = context
                                  .read<CurrentGamePhoneticsCubit>()
                                  .secondWayToCheckIfIsTheLastQuestionOfGame(
                                      queations: stateOfGame.letters
                                              ?.where((element) =>
                                                  element.letter ==
                                                  stateOfGame
                                                      .gameData.mainLetter)
                                              .length ??
                                          0);
                              // if (isLastQuestion) {
                              //   Future.delayed(
                              //       const Duration(seconds: 2),
                              //           () async {
                              //         Navigator.of(context).pop();
                              //       });
                              // }
                            });
                          } else {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addWrongAnswer(
                                    isArabic: stateOfGame.isArabic,
                                    actionOfWrongAnswer: () async {
                                      await context
                                          .read<ClickTheSoundCubit>()
                                          .sayTheLetter();
                                    });
                          }
                        }
                      },
              ),
            );
          }),
        ));
  }

  Widget _buildBubbleWidget({
    required String letter,
    required VoidCallback? onPress,
    required int index,
    required ClickTheSoundCubit viewModel,
  }) {
    final isArabic = viewModel.state.isArabic;
    return InkWell(
      onTap: onPress,
      child: Container(
        // width: 104.w,
        height: MediaQuery.of(context).size.height > 650 ? 150.h : 104.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  isArabic
                      ? viewModel.state.correctIndexes?.contains(index) ?? false
                          ? AppImagesArabic.correctBalon
                          : AppImagesArabic.regularBalon
                      : viewModel.state.correctIndexes?.contains(index) ?? false
                          ? AppImagesPhonetics.bubbleDisabled
                          : AppImagesPhonetics.bubble,
                ),
                fit: BoxFit.contain)),
        child: StrokedText(
          fontSize: MediaQuery.of(context).size.height > 650 ? 35.sp : 25.sp,
          text: letter,
          isDisabled: viewModel.state.correctIndexes?.contains(index) ?? false,
          backgroundColor: isArabic
              ? AppColorPhonetics.darkBlueColor
              : AppColorPhonetics.white,
          strokeColor: AppColorPhonetics.darkBlueColor,
        ),
      ),
    );
  }
}
