import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../../../widgets/stroke_text.dart';
import '../../sorting_game/manager/sorting_cubit.dart';
import '../widget/item_card_word_widget.dart';

class FamilyWordGameScreen extends StatefulWidget {
  const FamilyWordGameScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FamilyWordGameScreen();
  }
}

class _FamilyWordGameScreen extends State<FamilyWordGameScreen> {
  @override
  void initState() {
    final List<GameFinalModel> gameData =
        context.read<SortingCubit>().state.listGameData;
    context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
        mainCountOfQuestion:
            context.read<SortingCubit>().state.countOfQuestion);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.stopTalk,
        stateOfStringWillSay: gameData.first.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<SortingCubit, SortingInitial>(
          listener: (context, state) {},
          builder: (gameContext, gameState) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 15.w),
                      width: MediaQuery.of(context).size.width * 0.37,
                      height: MediaQuery.of(context).size.height * 0.61,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: AppColorPhonetics.darkBorderColor,
                              width: 5)),
                      child: Center(
                        child: GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 4,
                            padding: EdgeInsets.all(10),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisSpacing: 20,
                              crossAxisCount: 2,
                              childAspectRatio: 1.5,
                              crossAxisSpacing: 35,
                            ),
                            itemBuilder: (context, index) {
                              try {
                                return ItemCardWordWidget(
                                  data: gameState.currentImages[index],
                                  body: gameState.currentImages[index],
                                  index: gameState.currentImages[index].id ?? 0,
                                );
                              } catch (e) {
                                return const SizedBox();
                              }
                            }),
                      )),
                  Expanded(
                      child: Container(
                    height: 0.8.sh,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(gameState.woodenBackground!),
                            fit: BoxFit.fill)),
                    alignment: Alignment.center,
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: MediaQuery.of(context).size.height < 760
                            ? EdgeInsets.only(top: .001.sh)
                            : EdgeInsets.only(top: .04.sh),
                        itemCount: gameState.gameData.gameLetters?.length ?? 1,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, i) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.12.sh),
                              child: Container(
                                height: 0.2.sw,
                                width: 2,
                                color: AppColorPhonetics.strokeColor,
                              ),
                            ),
                        itemBuilder: (context, index) {
                          return Container(
                              height: 0.8.sw,
                              width: MediaQuery.of(context).size.longestSide /
                                  ((gameState.gameData.gameLetters?.length ??
                                          1) *
                                      2),
                              padding: const EdgeInsets.only(top: 30),
                              child: DragTarget<GameImagesGameFinalModel>(
                                builder: (
                                  BuildContext context,
                                  List<dynamic> accepted,
                                  List<dynamic> rejected,
                                ) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      StrokeText(
                                        text: gameState.gameData
                                                .gameLetters![index].letter ??
                                            '',
                                        isDisabled: false,
                                        fontSize: 0.04.sw,
                                      ),
                                      7.ph,
                                      SizedBox(
                                          child: GridView.builder(
                                              shrinkWrap: true,
                                              padding: EdgeInsets.zero,
                                              itemCount: gameState
                                                  .correctAnswersData
                                                  .where((element) =>
                                                      element.gameLetterId ==
                                                      gameState
                                                          .gameData
                                                          .gameLetters![index]
                                                          .id)
                                                  .toList()
                                                  .length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 2,
                                                      mainAxisSpacing: 2),
                                              itemBuilder: (context, i) {
                                                try {
                                                  GameImagesGameFinalModel
                                                      image = gameState
                                                          .correctAnswersData
                                                          .where((element) =>
                                                              element
                                                                  .gameLetterId ==
                                                              gameState
                                                                  .gameData
                                                                  .gameLetters![
                                                                      index]
                                                                  .id)
                                                          .toList()[i];

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: FittedBox(
                                                      child: Text(
                                                        image.word ?? '',
                                                        style: TextStyle(
                                                            fontSize: 10.sp,
                                                            fontFamily: AppTheme
                                                                .getFontFamily5(),
                                                            color: AppColorPhonetics
                                                                .darkBorderColor),
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                  );
                                                } catch (e) {
                                                  return const SizedBox();
                                                }
                                              })),
                                      20.ph,
                                    ],
                                  );
                                },
                                onAcceptWithDetails:
                                    (DragTargetDetails<GameImagesGameFinalModel>
                                        details) async {
                                  if (context
                                      .read<CurrentGamePhoneticsCubit>()
                                      .ableButton()) {
                                    GameImagesGameFinalModel image =
                                        details.data;
                                    print(
                                        '###:${(gameState.gameData.gameLetters![index].letter)?.toLowerCase()}');
                                    print('##:${image.word}');
                                    if (image.word?.toLowerCase().contains(
                                            gameState.gameData
                                                    .gameLetters![index].letter
                                                    ?.toLowerCase() ??
                                                "") ??
                                        false) {
                                      context
                                          .read<SortingCubit>()
                                          .addTheCorrectAnswer(answer: image);
                                      await context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .addSuccessAnswer(
                                              questions:
                                                  gameState.countOfQuestion,
                                              correctAnswers: gameState
                                                  .correctAnswersIds.length)
                                          .whenComplete(() async {
                                        bool isLastQuestion = context
                                            .read<SortingCubit>()
                                            .checkIfIsTheLastQuestionOfGame();
                                        print('isLastQuestion:$isLastQuestion');

                                        if (isLastQuestion) {
                                          bool isLastGame = context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .checkIfIsTheLastQuestionOfGame(
                                                  queations: gameState
                                                      .listGameData.length);
                                          print('isLastGame:$isLastGame');

                                          if (isLastGame) {
                                            // Future.delayed(
                                            //     const Duration(seconds: 2),
                                            //     () async {
                                            //   Navigator.of(context).pop();
                                            // });
                                          } else {
                                            await context
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .updateIndexOfCurrentGame();
                                            gameContext
                                                .read<SortingCubit>()
                                                .updateTheCurrentGame(
                                                    index: context
                                                        .read<
                                                            CurrentGamePhoneticsCubit>()
                                                        .state
                                                        .index);
                                          }
                                        }
                                      });
                                    } else {
                                      await context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .addWrongAnswer(
                                              actionOfWrongAnswer: () async {});
                                    }
                                  }
                                },
                              ));
                        }),
                  )),
                  10.pw
                ],
              ),
            );
          }),
    );
  }
}
