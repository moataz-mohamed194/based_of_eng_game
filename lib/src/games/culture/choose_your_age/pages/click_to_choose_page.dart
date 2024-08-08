// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:based_of_eng_game/based_of_eng_game.dart';
import 'package:based_of_eng_game/src/core/assets_images_phonetics.dart';
import 'package:based_of_eng_game/src/core/phonetics_color.dart';

import 'package:based_of_eng_game/src/cubit/current_game_phonetics_cubit.dart';
import 'package:based_of_eng_game/src/games/culture/choose_your_age/manager/click_to_choose_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:based_of_eng_game/src/widgets/empty_space.dart';

class ClickToChoosePage extends StatefulWidget {
  const ClickToChoosePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ClickToChoosePage();
  }
}

class _ClickToChoosePage extends State<ClickToChoosePage> {
  @override
  void initState() {
    final List<GameFinalModel> gameData =
        context.read<ClickToChooseCubit>().state.listGameData;
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
    return BlocConsumer<ClickToChooseCubit, ClickToChooseState>(
        listener: (context, state) {
      context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
          stateOfStringIsWord: StateOfSubWord.stopTalk,
          stateOfStringWillSay: state.gameData.inst ?? '');
    }, builder: (context, gameState) {
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
                  _buildImage(context: context),
                  50.pw,
                  _buildChoices(context: context),
                ],
              ),
            )
          ],
        ),
      );
    });
  }

  Widget _buildImage({required BuildContext context}) {
    final clickToChooseCubit = context.read<ClickToChooseCubit>();
    final gameState = clickToChooseCubit.state;
    final imageUrl = gameState.mainImage.first.image ?? '';

    return InkWell(
      onTap: gameState.mainImage.first.letter != null
          ? () {
              clickToChooseCubit.makeSoundOfImage();
            }
          : null,
      child: Flexible(
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
      ),
    );
  }

  Widget _buildChoices({required BuildContext context}) {
    final gameState = context.read<ClickToChooseCubit>().state;
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(gameState.choices.length, (index) {
          final isCorrect = gameState.choices[index].correct == 1;
          return Flexible(
            child: ChoicesItem(
              onClick: () async {
                if (context.read<CurrentGamePhoneticsCubit>().ableButton() &&
                    gameState.isCorrect == false) {
                  bool stateOfAnswer = context
                      .read<ClickToChooseCubit>()
                      .addAnswer(image: gameState.choices[index]);
                  if (stateOfAnswer == true) {
                    await context
                        .read<CurrentGamePhoneticsCubit>()
                        .addSuccessAnswer(
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
                              .read<ClickToChooseCubit>()
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
                        .addWrongAnswer(actionOfWrongAnswer: () async {});
                  }
                }
              },
              imageUrl: gameState.choices[index].image ?? '',
              isCorrect: gameState.isCorrect == true && isCorrect,
            ),
          );
        }),
      ),
    );
  }
}

class ChoicesItem extends StatelessWidget {
  final String imageUrl;
  final bool isCorrect;
  final void Function() onClick;
  const ChoicesItem({
    Key? key,
    required this.imageUrl,
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
          10.pw,
          Flexible(
            child: FittedBox(
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
