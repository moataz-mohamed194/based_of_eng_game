import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_models/games_models.dart';
import '../../../core/games_structure/basic_of_game_data.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/talk_tts.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/spelling_cubit.dart';
import '../widget/drag_target_card.dart';
import '../widget/item_card_widget.dart';

class SpellingGameScreen extends StatefulWidget {
  const SpellingGameScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SpellingGameScreen();
  }
}

class _SpellingGameScreen extends State<SpellingGameScreen> {
  @override
  void initState() {
    final List<GameModel> gameData =
        context.read<SpellingCubit>().state.allGames;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.length);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: false, stateOfStringWillSay: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isInteracting =
        context.watch<CurrentGamePhoneticsCubit>().state.stateOfAvatar;

    return BlocConsumer<SpellingCubit, SpellingInitial>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  // height: 0.6.sh,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage(gameState.woodenBackground ?? ''),
                    fit: BoxFit.fill,
                  )),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: TalkTts.data == StateOfTalk.talking
                            ? null
                            : () {
                                TalkTts.startTalk(
                                    text: gameState.gameData?.correctAns ?? '');
                              },
                        child: CachedNetworkImage(
                          imageUrl:
                              gameState.gameData?.gameImages?.first.image ?? '',
                          height: 0.35.sh,
                          placeholder: (context, url) => const Center(
                            child: CupertinoActivityIndicator(),
                          ),
                          errorWidget: (context, url, error) => const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      7.ph,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              gameState.correctAnswers.length,
                              (index) => DragTarget<String>(
                                    builder: (
                                      BuildContext context,
                                      List<dynamic> accepted,
                                      List<dynamic> rejected,
                                    ) {
                                      return DragTargetWidget(
                                          title:
                                              gameState.correctAnswers[index]);
                                    },
                                    onAcceptWithDetails:
                                        (DragTargetDetails<String>
                                            details) async {
                                      if (isInteracting == null ||
                                          isInteracting ==
                                              BasicOfGameData.stateOIdle) {
                                        context
                                            .read<SpellingCubit>()
                                            .addTheCorrectAnswer(
                                                index: index,
                                                answer: details.data);
                                        if (context
                                            .read<SpellingCubit>()
                                            .checkCurrentFinished()) {
                                          if (context
                                              .read<SpellingCubit>()
                                              .checkIsCorrectAnswer()) {
                                            await context
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .addSuccessAnswer(
                                                    questions: gameState
                                                        .allGames.length,
                                                    correctAnswers:
                                                        (gameState.index) + 1)
                                                .whenComplete(() async {
                                              bool isLastQuestion = context
                                                  .read<
                                                      CurrentGamePhoneticsCubit>()
                                                  .checkIfIsTheLastQuestionOfGame(
                                                      queations: gameState
                                                          .allGames.length);
                                              if (isLastQuestion) {
                                                Future.delayed(
                                                    const Duration(seconds: 2),
                                                    () async {
                                                  Navigator.of(context).pop();
                                                });
                                              } else {
                                                await context
                                                    .read<
                                                        CurrentGamePhoneticsCubit>()
                                                    .updateIndexOfCurrentGame();
                                                await context
                                                    .read<SpellingCubit>()
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
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .addWrongAnswer(
                                                    actionOfWrongAnswer:
                                                        () async {});
                                            await context
                                                .read<SpellingCubit>()
                                                .clearAnswers();
                                          }
                                        }
                                      }
                                    },
                                  )),
                        ),
                      ),
                      20.ph,
                    ],
                  ),
                )),
                20.pw,
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      // height: MediaQuery.of(context).size.height - (70.h),
                      margin: EdgeInsets.only(right: 15.w),
                      // width: MediaQuery.of(context).size.width * 0.37,
                      height: MediaQuery.of(context).size.height * 0.64,
                      // padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: AppColorPhonetics.darkBorderColor,
                              width: 5)),
                      child: Center(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: ((gameState.gameData)
                                      ?.gameLetters
                                      ?.map((e) => e.letter)
                                      .toSet()
                                      .toList()
                                      .length ??
                                  1),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4, childAspectRatio: 1.3),
                              itemBuilder: (context, index) {
                                return ItemCardWidget(
                                  id: ((gameState.gameData?.gameLetters)!
                                          .map((e) => e.id)
                                          .toSet()
                                          .toList()[index]) ??
                                      0,
                                  body: (gameState.gameData?.gameLetters)
                                          ?.map((e) => e.letter)
                                          .toSet()
                                          .toList()[index] ??
                                      '',
                                  maxHeight: 0.095.sh,
                                  maxWidth: 0.07.sw,
                                  index: index,
                                );
                              }),
                        ],
                      ))),
                ),
              ],
            ),
          );
        });
  }
}