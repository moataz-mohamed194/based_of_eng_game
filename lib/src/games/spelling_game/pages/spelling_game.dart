import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
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
    final List<GameFinalModel> gameData =
        context.read<SpellingCubit>().state.allGames;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.length);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.isLetter, stateOfStringWillSay: '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SpellingCubit, SpellingInitial>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Padding(
            padding: const EdgeInsets.only(top: 40, left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height * 0.64,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage(gameState.woodenBackground ?? ''),
                        fit: BoxFit.fill,
                      )),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: .05.sh),
                              child: GestureDetector(
                                onTap: TalkTts.data == StateOfTalk.talking
                                    ? null
                                    : () {
                                        TalkTts.startTalk(
                                            text: gameState
                                                    .gameData?.correctAns ??
                                                '',
                                            isArabic: gameState.isArabic);
                                      },
                                child: CachedNetworkImage(
                                  imageUrl: gameState
                                          .gameData?.gameImages?.first.image ??
                                      '',
                                  height: 1,
                                  placeholder: (context, url) => const Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                  errorWidget: (context, url, error) => Center(
                                    child: Text(
                                        '${gameState.gameData?.gameImages?.first.word}'),
                                  ),
                                ),
                              ),
                            ),
                          ),
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
                                              title: gameState
                                                  .correctAnswers[index]);
                                        },
                                        onAcceptWithDetails:
                                            (DragTargetDetails<String>
                                                details) async {
                                          if (context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .ableButton()) {
                                            context
                                                .read<SpellingCubit>()
                                                .addTheCorrectAnswer(
                                                    index: index,
                                                    answer: details.data);
                                            if (context
                                                .read<SpellingCubit>()
                                                .checkCurrentFinished()) {
                                              if (await context
                                                  .read<SpellingCubit>()
                                                  .checkIsCorrectAnswer()) {
                                                await context
                                                    .read<
                                                        CurrentGamePhoneticsCubit>()
                                                    .addSuccessAnswer(
                                                        isArabic:
                                                            gameState.isArabic,
                                                        questions: gameState
                                                            .allGames.length,
                                                        correctAnswers:
                                                            (gameState.index) +
                                                                1)
                                                    .whenComplete(() async {
                                                  bool isLastQuestion = context
                                                      .read<
                                                          CurrentGamePhoneticsCubit>()
                                                      .checkIfIsTheLastQuestionOfGame(
                                                          queations: gameState
                                                              .allGames.length);
                                                  if (!isLastQuestion) {
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
                                                        isArabic:
                                                            gameState.isArabic,
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
                          SizedBox(height: 45.h),
                        ],
                      ),
                    )),
                SizedBox(width: 20),
                Expanded(
                  flex: 4,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 15.w),
                    padding: EdgeInsets.symmetric(
                      vertical:
                          ((gameState.gameData)?.gameLetters?.length ?? 1) == 26
                              ? 0
                              : 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: AppColorPhonetics.darkBorderColor,
                        width: 5,
                      ),
                    ),
                    child: Center(
                      child: Wrap(
                        children: List.generate(
                          (gameState.gameData?.gameLetters?.length ?? 1),
                          (index) {
                            return ItemCardWidget(
                              id: ((gameState.gameData?.gameLetters)
                                      ?.map((e) => e.id)
                                      .toSet()
                                      .toList()[index]) ??
                                  0,
                              body: (gameState.gameData?.gameLetters)
                                      ?.map((e) => e.letter)
                                      .toSet()
                                      .toList()[index] ??
                                  '',
                              maxHeight:
                                  ((gameState.gameData?.gameLetters?.length ??
                                              1) ==
                                          26
                                      ? 40.h
                                      : 60.h),
                              maxWidth:
                                  ((gameState.gameData?.gameLetters?.length ??
                                              1) ==
                                          26
                                      ? 23.w
                                      : 30.w),
                              index: index,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
