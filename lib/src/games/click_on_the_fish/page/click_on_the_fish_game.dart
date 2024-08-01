import 'package:based_of_eng_game/src/core/assets_images_phonetics.dart';
import 'package:based_of_eng_game/src/core/game_types/assets_images_arabic.dart';
import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/cubit/current_game_phonetics_cubit.dart';
import 'package:based_of_eng_game/src/games/click_the_sound/manager/click_the_sound_cubit.dart';
import 'package:based_of_eng_game/src/games/click_the_sound/widgets/stroked_text_widget.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:based_of_eng_game/src_model/model/game_letters_model.dart';
import 'package:based_of_eng_game/src_model/model/game_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClickOnTheFishGame extends StatefulWidget {
  const ClickOnTheFishGame({super.key});

  @override
  State<ClickOnTheFishGame> createState() => _ClickOnTheFishGameState();
}

class _ClickOnTheFishGameState extends State<ClickOnTheFishGame> {
    @override
  void initState() {
    final GameFinalModel gameData =
        context.read<ClickTheSoundCubit>().state.gameData;
    context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
        mainCountOfQuestion: gameData.gameLetters
                ?.where((element) => element.mainQuestion == 1)
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
            final currentLetter = firstLetters[index];
            return Expanded(
              child: _buildBubbleWidget(
                letter: firstLetters[index],
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
                        setState(() {
                          
                        });
                        if (context
                            .read<CurrentGamePhoneticsCubit>()
                            .ableButton()) {
                          print(
                              '###:${(context.read<CurrentGamePhoneticsCubit>().ableButton())}');
                          if (currentAnswer == null
                              ? false
                              : currentLetter.mainQuestion == 1) {
                            await context
                                .read<ClickTheSoundCubit>()
                                .incrementCorrectAnswerCount(
                                    firstLetters[index].id ?? 0 , currentAnswer: currentLetter.letter);
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addSuccessAnswer(
                                    isArabic: stateOfGame.isArabic,
                                    questions: stateOfGame.letters
                                            ?.where((element) =>
                                                element.mainQuestion ==
                                                1)
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
    required GameLettersGameFinalModel letter,
    required VoidCallback? onPress,
    required int index,
    required ClickTheSoundCubit viewModel,
  }) {
    
    return InkWell(
      onTap: onPress,
      child: Container(
        // width: 104.w,
        height: MediaQuery.of(context).size.height > 650 ? 150.h : 104.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                 viewModel.state.correctStrings?.contains(letter.letter) ?? false ?  
                    AppImagesArabic.correctFish : 
                    AppImagesArabic.regularFish
                ),
                fit: BoxFit.contain)),
        child: StrokedText(
          fontSize: MediaQuery.of(context).size.height > 650 ? 35.sp : 25.sp,
          text: letter.letter ?? '',
          isDisabled: viewModel.state.correctStrings?.contains(letter.letter) ?? false ,
          backgroundColor:viewModel.state.correctStrings?.contains(letter.letter) ?? false ?   AppColorPhonetics.greenColor2 :  AppColorPhonetics.darkBlueColor,
          strokeColor: AppColorPhonetics.darkBlueColor,
        ),
      ),
    );
  }
}
