import 'package:based_of_eng_game/src/core/theme_text.dart';
import 'package:based_of_eng_game/src/games/choose_the_correct_letter_or_image/manager/choose_the_correct_letter_or_image_cubit.dart';
import 'package:based_of_eng_game/src/games/choose_the_correct_letter_or_image/widgets/image_item.dart';
import 'package:based_of_eng_game/src/games/choose_the_correct_letter_or_image/widgets/letter_item.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/assets_images_phonetics.dart';
import '../../../core/games_structure/basic_of_game_data.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/talk_tts.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';

class ChooseTheCorrectLetterOrImageGame extends StatefulWidget {
  const ChooseTheCorrectLetterOrImageGame({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ChooseTheCorrectLetterOrImageGame();
  }
}

class _ChooseTheCorrectLetterOrImageGame
    extends State<ChooseTheCorrectLetterOrImageGame> {
  @override
  void initState() {
    final List<GameFinalModel> gameData =
        context.read<ChooseTheCorrectLetterOrImageCubit>().state.allGameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.length);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.isLetter,
        stateOfStringWillSay: gameData.first.mainLetter ?? '');
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stateOfCurrentGamePhoneticsCubit =
        context.watch<CurrentGamePhoneticsCubit>().state;
    return Container(
      height: MediaQuery.of(context).size.height - (70.h),
      alignment: Alignment.center,
      child: BlocConsumer<ChooseTheCorrectLetterOrImageCubit,
          ChooseTheCorrectLetterOrImageState>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  _buildBoard(
                      context: context,
                      gameState: gameState,
                      stateOfCurrentGamePhoneticsCubit:
                          stateOfCurrentGamePhoneticsCubit),
                  _buildTitleImageOrLetter(gameState, context),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTitleImageOrLetter(
      ChooseTheCorrectLetterOrImageState gameState, BuildContext context) {
    final chooseTheCorrectLetterOrImageCubit =
        context.read<ChooseTheCorrectLetterOrImageCubit>();
    final isLetter = gameState.isLetter;
    return Positioned(
      top: 0.w,
      left: -2.5.w,
      child: Container(
        alignment: (gameState.gameData.mainLetter ?? '') == 's'
            ? Alignment.center
            : Alignment.center,
        height: isLetter ? 100.h : 130.h,
        width: isLetter ? 50.w : 65.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              AppImagesPhonetics.letterOfClickPic,
            ),
          ),
        ),
        child: GestureDetector(
            onTap: () async {
              chooseTheCorrectLetterOrImageCubit.sayLetter();
            },
            child: isLetter
                ? Text(
                    gameState.gameData.mainLetter ?? '',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontSize: 25.spMax,
                        fontWeight: FontWeight.w700,
                        color: AppColorPhonetics.darkBorderColor,
                        fontFamily: AppTheme.getFontFamily5()),
                    textAlign: TextAlign.center,
                  )
                : Padding(
                    padding: EdgeInsets.only(right: 5.w, left: 5.w),
                    child: Align(
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: gameState.gameImages?[0].image ?? '',
                        width: 35.w,
                        placeholder: (context, url) => const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Text('${gameState.gameImages?[0].word}'),
                        ),
                        fit: BoxFit.fill,
                        // height: ,
                      ),
                    ),
                  )),
      ),
    );
  }

  Widget _buildBoard(
      {required BuildContext context,
      required ChooseTheCorrectLetterOrImageState gameState,
      required CurrentGamePhoneticsState stateOfCurrentGamePhoneticsCubit}) {
    return Container(
      margin: EdgeInsets.only(bottom: 50, top: 50, right: 30.w),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      height: 300.h,
      width: MediaQuery.of(context).size.width - 100.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: AppColorPhonetics.boarderColor, width: 5)),
      child: _buildImagesOrLetters(
          gameState: gameState,
          stateOfCurrentGamePhoneticsCubit: stateOfCurrentGamePhoneticsCubit,
          context: context),
    );
  }

  Widget _buildImagesOrLetters(
      {required ChooseTheCorrectLetterOrImageState gameState,
      required CurrentGamePhoneticsState stateOfCurrentGamePhoneticsCubit,
      required BuildContext context}) {
    final chooseTheCorrectLetterOrImageCubit =
        context.read<ChooseTheCorrectLetterOrImageCubit>();
    final currentGamePhoneticsCubit = context.read<CurrentGamePhoneticsCubit>();
    final isLetter = gameState.isLetter;
    final gameImages = gameState.gameImages ?? [];
    final gameLetters = gameState.gameData.gameLetters ?? [];
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        isLetter ? gameImages.length : gameLetters.length,
        (index) => DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return GestureDetector(
              onTap: () async {
                if (currentGamePhoneticsCubit.ableButton() &&
                    gameState.isCorrect == false) {
                  if (!isLetter
                      ? gameState.gameData.gameLetters![index].id ==
                          gameState.gameImages?.first.gameLetterId
                      : gameState.gameImages?[index].correct == 1) {
                    await chooseTheCorrectLetterOrImageCubit.addSuccess();
                    await context
                        .read<CurrentGamePhoneticsCubit>()
                        .addSuccessAnswer(
                            isArabic: true,
                            questions: gameState.allGameData.length,
                            correctAnswers: (gameState.index) + 1)
                        .whenComplete(() async {
                      bool isLastQuestion = context
                          .read<CurrentGamePhoneticsCubit>()
                          .checkIfIsTheLastQuestionOfGame(
                              queations: gameState.allGameData.length);
                      if (!isLastQuestion) {
                        await context
                            .read<CurrentGamePhoneticsCubit>()
                            .updateIndexOfCurrentGame();
                        context
                            .read<ChooseTheCorrectLetterOrImageCubit>()
                            .updateTheCurrentGame(
                                index: context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .state
                                    .index);
                      }
                    });
                  } else {
                    await context
                        .read<CurrentGamePhoneticsCubit>()
                        .addWrongAnswer(
                            isArabic: true, actionOfWrongAnswer: () async {});
                  }
                }
              },
              child: isLetter
                  ? Row(
                      children: [
                        ImageItem(
                            imageUrl: gameState.gameImages?[index].image ?? '',
                            letterOfImage:
                                gameState.gameImages?[index].word ?? '',
                            isCorrect: gameState.isCorrect == true &&
                                gameState.gameImages?[index].correct == 1),
                        40.pw,
                      ],
                    )
                  : Row(
                      children: [
                        LetterItem(
                          letter:
                              gameState.gameData.gameLetters?[index].letter ??
                                  '',
                          isCorrect: gameState.isCorrect == true &&
                              gameState.gameData.gameLetters?[index].id ==
                                  gameState.gameImages?.first.gameLetterId,
                        ),
                        40.pw
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }
}
