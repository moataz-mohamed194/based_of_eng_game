import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/phonetics_color.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../../../widgets/stroke_text.dart';
import '../manager/sorting_cubit.dart';
import '../widget/item_card_widget.dart';

class SortingGameScreen extends StatefulWidget {
  const SortingGameScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SortingGameScreen();
  }
}

class _SortingGameScreen extends State<SortingGameScreen> {
  @override
  void initState() {
    context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
        mainCountOfQuestion:
            context.read<SortingCubit>().state.countOfQuestion);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SortingCubit, SortingInitial>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 15.w),
                      height: MediaQuery.of(context).size.height -
                          (MediaQuery.of(context).size.height > 750
                              ? 220.h
                              : 130.h),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: AppColorPhonetics.darkBorderColor,
                              width: 5)),
                      child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: 4,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1.5),
                          itemBuilder: (context, index) {
                            try {
                              return ItemCardWidget(
                                data: gameState.currentImages[index],
                                body: gameState.currentImages[index],
                                index: gameState.currentImages[index].id ?? 0,
                              );
                            } catch (e) {
                              return const SizedBox();
                            }
                          })),
                ),
                20.pw,
                Expanded(
                    child: Container(
                  height: 0.8.sh,
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(gameState.woodenBackground!),
                          fit: BoxFit.fill)),
                  alignment: Alignment.center,
                  child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
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
                        final letterLength =
                            gameState.gameData.gameLetters?.length ?? 1;
                        return Container(
                            height: 0.8.sw,
                            width: MediaQuery.of(context).size.longestSide /
                                ((gameState.gameData.gameLetters?.length ?? 1) *
                                    2.5),
                            padding: EdgeInsets.only(top: .07.sh),
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
                                      color: gameState.isArabic
                                          ? AppColorPhonetics.darkBlueColor
                                          : null,
                                      strokeColor: gameState.isArabic
                                          ? AppColorPhonetics.darkBlueColor
                                          : null,
                                      text: gameState.gameData
                                              .gameLetters![index].letter ??
                                          '',
                                      isDisabled: false,
                                      fontSize: 0.04.sw,
                                    ),
                                    const SizedBox(height: 7),
                                    Expanded(
                                      child: GridView.builder(
                                        shrinkWrap: true,
                                        itemCount: gameState.correctAnswersData
                                            .where((element) =>
                                                element.gameLetterId ==
                                                gameState.gameData
                                                    .gameLetters![index].id)
                                            .toList()
                                            .length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.zero,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              letterLength > 2 ? 2 : 3,
                                          crossAxisSpacing: 1,
                                          mainAxisSpacing: 1,
                                          childAspectRatio:
                                              1.0, // Adjust aspect ratio if needed
                                        ),
                                        itemBuilder: (context, i) {
                                          try {
                                            String image = gameState
                                                    .correctAnswersData
                                                    .where((element) =>
                                                        element.gameLetterId ==
                                                        gameState
                                                            .gameData
                                                            .gameLetters![index]
                                                            .id)
                                                    .toList()[i]
                                                    .image ??
                                                '';

                                            return CachedNetworkImage(
                                              imageUrl: image,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CupertinoActivityIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(
                                                Icons.error,
                                                color: Colors.red,
                                              ),
                                            );
                                          } catch (e) {
                                            return const SizedBox();
                                          }
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                );
                              },
                              onAcceptWithDetails:
                                  (DragTargetDetails<GameImagesGameFinalModel>
                                      details) async {
                                if (context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .ableButton()) {
                                  GameImagesGameFinalModel image = details.data;
                                  if ((gameState
                                          .gameData.gameLetters?[index].id) ==
                                      image.gameLetterId) {
                                    context
                                        .read<SortingCubit>()
                                        .addTheCorrectAnswer(answer: image);
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addSuccessAnswer(
                                            isArabic: gameState.isArabic,
                                            questions:
                                                gameState.countOfQuestion,
                                            correctAnswers: gameState
                                                .correctAnswersIds.length)
                                        .whenComplete(() async {
                                      bool isLastQuestion = context
                                          .read<SortingCubit>()
                                          .checkIfIsTheLastQuestionOfGame();
                                      if (isLastQuestion) {
                                        bool isLastGame = context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .checkIfIsTheLastQuestionOfGame(
                                                queations: gameState
                                                    .listGameData.length);
                                        if (isLastGame) {
                                          // Future.delayed(
                                          //     const Duration(seconds: 2),
                                          //     () async {
                                          //   Navigator.of(context).pop();
                                          // });
                                        } else {
                                          await context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .updateIndexOfCurrentGame();
                                          context
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
                                            isArabic: gameState.isArabic,
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
        });
  }
}
