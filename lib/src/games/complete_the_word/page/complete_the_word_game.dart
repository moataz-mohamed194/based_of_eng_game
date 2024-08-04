// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:based_of_eng_game/based_of_eng_game.dart';
import 'package:based_of_eng_game/src/games/complete_the_word/manager/complete_the_word_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:based_of_eng_game/src/games/choose_the_sentence/manager/listen_choose_cubit.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';

import '../../../../src_model/model/game_model.dart';
import '../../../core/assets_images_phonetics.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';

class CompleteTheWordGame extends StatefulWidget {
  const CompleteTheWordGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CompleteTheWordGame();
  }
}

class _CompleteTheWordGame extends State<CompleteTheWordGame> {
  @override
  void initState() {
    final List<GameFinalModel> gameData =
        context.read<CompleteTheWordCubit>().state.listGameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.length);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.stopTalk,
        stateOfStringWillSay: gameData.first.inst ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteTheWordCubit, CompleteTheWordState>(
        listener: (context, state) {
      context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
          stateOfStringIsWord: StateOfSubWord.stopTalk,
          stateOfStringWillSay: state.gameData.inst ?? '');
    }, builder: (context, gameState) {
      final currentGamePhoneticsCubit =
          context.read<CurrentGamePhoneticsCubit>();
      final isChooseTheStretchedWord = currentGamePhoneticsCubit
          .state.basicData?.gameData is ChooseTheStretchedWord;
      final isCompletedLetter = currentGamePhoneticsCubit
              .state.basicData?.gameData is CompleteTheWord ||
          currentGamePhoneticsCubit.state.basicData?.gameData
              is CompleteTheStretchedLetter;
      return Container(
        margin: EdgeInsets.symmetric(vertical: 30.h),
        padding: EdgeInsets.all(20.w),
        width: MediaQuery.of(context).size.width - 60.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
            border:
                Border.all(color: AppColorPhonetics.boarderColor, width: 2.w)),
        child: Column(
          children: [
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildChoices(gameState, context),
                  if (gameState.images.first.word != null &&
                      !isChooseTheStretchedWord) ...[
                    50.pw,
                    _buildGuessingWord(
                        gameState: gameState,
                        isCompletedLetter: isCompletedLetter),
                  ],
                  if (gameState.images.first.image != null) ...[
                    50.pw,
                    _buildImage(imageUrl: gameState.images.first.image!),
                  ]
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildGuessingWord(
      {required CompleteTheWordState gameState,
      required bool isCompletedLetter}) {
    final word = isCompletedLetter
        ? gameState.isCorrect == true
            ? gameState.correctAnswer
            : gameState.images.first.word
        : gameState.images.first.word;
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border:
              Border.all(color: AppColorPhonetics.boarderColor, width: 0.5.w),
        ),
        child: Text(
          word ?? '',
          style: TextStyle(
              fontSize: 20.sp,
              fontFamily: AppTheme.getFontFamily5(),
              color: AppColorPhonetics.darkBorderColor),
        ),
      ),
    );
  }

  Widget _buildImage({required String imageUrl}) {
    return Flexible(
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        height: 0.31.sh,
        placeholder: (context, url) => const Center(
          child: CupertinoActivityIndicator(),
        ),
        errorWidget: (context, url, error) => const Icon(
          Icons.error,
          color: Colors.red,
        ),
      ),
    );
  }

  Widget _buildChoices(CompleteTheWordState gameState, BuildContext context) {
    final correctAnswerId = gameState.images.first.gameLetterId;

    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(gameState.choose.length, (index) {
          final currentLetterId = gameState.choose[index].id;
          return Flexible(
            child: ChoicesItem(
              onClick: () async {
                if (context.read<CurrentGamePhoneticsCubit>().ableButton() &&
                    gameState.isCorrect == false) {
                  bool stateOfAnswer = context
                      .read<CompleteTheWordCubit>()
                      .addAnswer(letter: gameState.choose[index]);
                  if (stateOfAnswer == true) {
                    await context
                        .read<CurrentGamePhoneticsCubit>()
                        .addSuccessAnswer(
                            isArabic: gameState.isArabic,
                            questions: gameState.listGameData.length,
                            correctAnswers: gameState.countCorrectAnswers + 1)
                        .whenComplete(() {
                      bool isLastQuestion = context
                          .read<CurrentGamePhoneticsCubit>()
                          .checkIfIsTheLastQuestionOfGame(
                              queations: gameState.listGameData.length);
                      if (!isLastQuestion) {
                        Future.delayed(const Duration(seconds: 2), () async {
                          await context
                              .read<CurrentGamePhoneticsCubit>()
                              .updateIndexOfCurrentGame();
                          context
                              .read<CompleteTheWordCubit>()
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
                            isArabic: gameState.isArabic,
                            actionOfWrongAnswer: () async {});
                  }
                }
              },
              letter: gameState.choose[index].letter ?? '',
              isCorrect: gameState.isCorrect == true &&
                  correctAnswerId == currentLetterId,
            ),
          );
        }),
      ),
    );
  }
}

class ChoicesItem extends StatelessWidget {
  final String letter;
  final bool isCorrect;
  final void Function() onClick;
  const ChoicesItem({
    Key? key,
    required this.letter,
    required this.isCorrect,
    required this.onClick,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width / 8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              child: Text(
                letter,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontFamily: AppTheme.getFontFamily5(),
                    color: AppColorPhonetics.darkBorderColor),
              ),
            ),
          ),
          10.pw,
          Flexible(
            child: FittedBox(
              child: InkWell(
                onTap: onClick,
                child: Image.asset(
                  isCorrect
                      ? AppImagesPhonetics.iconSelectedCheckBox
                      : AppImagesPhonetics.iconUnselectedCheckBox,
                  height: 30.h,
                  width: 20.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
