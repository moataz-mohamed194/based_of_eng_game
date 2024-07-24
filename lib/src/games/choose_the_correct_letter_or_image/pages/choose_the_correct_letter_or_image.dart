import 'package:based_of_eng_game/src/core/theme_text.dart';
import 'package:based_of_eng_game/src/games/choose_the_correct_letter_or_image/manager/choose_the_correct_letter_or_image_cubit.dart';
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
      alignment: Alignment.center,
      // height: MediaQuery.of(context).size.height - (70.h),
      child: BlocConsumer<ChooseTheCorrectLetterOrImageCubit,
          ChooseTheCorrectLetterOrImageState>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              )
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
      top: -5.h,
      left: 0,
      child: Container(
        alignment: (gameState.gameData.mainLetter ?? '') == 's'
            ? Alignment.topCenter
            : Alignment.center,
        height: 100.h,
        width: 40.w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
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
                        height: 45.h,
                        width: 45.w,
                        placeholder: (context, url) => const Center(
                          child: CupertinoActivityIndicator(),
                        ),
                        errorWidget: (context, url, error) => Center(
                          child: Text('${gameState.gameImages?[0].word}'),
                        ),
                        fit: BoxFit.fitHeight,
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
      margin: EdgeInsets.only(bottom: 50, top: 50, right: 50.w),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30.h),
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
    final currentGamePhoneticsCubit = context.read<CurrentGamePhoneticsCubit>();
    final isLetter = gameState.isLetter;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(
        isLetter
            ? gameState.gameImages?.length ?? 0
            : gameState.gameData.gameLetters?.length ?? 0,
        (index) => DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return (stateOfCurrentGamePhoneticsCubit.stateOfAvatar ==
                    BasicOfGameData.stateOfWin)
                ? SizedBox(
                    width:
                        (MediaQuery.of(context).size.width - (130 + 50 + 130)) /
                            4,
                    height: 110.h,
                  )
                : GestureDetector(
                    onTap: () async {
                      if (currentGamePhoneticsCubit.ableButton()) {
                        if (!isLetter
                            ? gameState.gameData.gameLetters![index].id ==
                                gameState.gameImages?.first.gameLetterId
                            : gameState.gameImages?[index].correct == 1) {
                          await _addSuccessAnswer(context, gameState);
                        } else {
                          await _addWrongAnswer(context);
                        }
                      }
                    },
                    child: isLetter
                        ? Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.w),
                            child: CachedNetworkImage(
                              imageUrl:
                                  gameState.gameImages?[index].image ?? '',
                              width: (MediaQuery.of(context).size.width -
                                      (130 + 50 + 130)) /
                                  4,
                              height: 120.h,
                              placeholder: (context, url) => const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                              errorWidget: (context, url, error) => Center(
                                child: Text(
                                    '${gameState.gameImages?[index].word}'),
                              ),
                              fit: BoxFit.contain,
                              // height: ,
                            ),
                          )
                        : Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 20.h, horizontal: 20.w),
                            child: Text(
                              gameState.gameData.gameLetters?[index].letter ??
                                  '',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      fontSize: 45.spMax,
                                      fontWeight: FontWeight.w700,
                                      color: AppColorPhonetics.darkBorderColor,
                                      fontFamily: AppTheme.getFontFamily5()),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  );
          },
        ),
      ),
    );
  }

  Future<void> _addWrongAnswer(BuildContext context) async {
    await context
        .read<CurrentGamePhoneticsCubit>()
        .addWrongAnswer(isArabic: true, actionOfWrongAnswer: () async {});
  }

  Future<void> _addSuccessAnswer(BuildContext context,
      ChooseTheCorrectLetterOrImageState gameState) async {
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
      if (isLastQuestion) {
        // Future.delayed(
        //     const Duration(seconds: 2),
        //     () async {
        //   Navigator.of(context).pop();
        // });
      } else {
        await context
            .read<CurrentGamePhoneticsCubit>()
            .updateIndexOfCurrentGame();
        context.read<ChooseTheCorrectLetterOrImageCubit>().updateTheCurrentGame(
            index: context.read<CurrentGamePhoneticsCubit>().state.index);
      }
    });
  }
}
