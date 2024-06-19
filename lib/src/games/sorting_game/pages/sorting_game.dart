import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:games_models/games_models.dart';
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
    final List<GameModel> gameData =
        context.read<SortingCubit>().state.listGameData;
    context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
        mainCountOfQuestion:
            context.read<SortingCubit>().state.countOfQuestion);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: true,
        stateOfStringWillSay: gameData.first.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocConsumer<SortingCubit, SortingInitial>(
          listener: (context, state) {},
          builder: (context, gameState) {
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
                          return Container(
                              height: 0.8.sw,
                              width: 0.12.sw,
                              padding: const EdgeInsets.only(top: 30),
                              child: DragTarget<GameImagesModel>(
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
                                              itemCount: gameState
                                                  .correctAnswersData.length,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                      crossAxisCount: 2,
                                                      crossAxisSpacing: 2,
                                                      mainAxisSpacing: 5),
                                              itemBuilder: (context, i) {
                                                try {
                                                  String image = gameState
                                                          .correctAnswersData
                                                          .where((element) =>
                                                              element
                                                                  .gameLetterId ==
                                                              gameState
                                                                  .gameData
                                                                  .gameLetters![
                                                                      index]
                                                                  .id)
                                                          .toList()[i]
                                                          .image ??
                                                      '';

                                                  return CachedNetworkImage(
                                                    imageUrl: image,
                                                    placeholder:
                                                        (context, url) =>
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
                                                    // height: ,
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
                                    (DragTargetDetails<GameImagesModel>
                                        details) async {
                                  GameImagesModel image = details.data;
                                  if ((gameState.gameData.gameLetters![index]
                                              .letter)
                                          ?.toLowerCase() ==
                                      image.word
                                          ?.split('')
                                          .first
                                          .toLowerCase()) {
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
                                      if (isLastQuestion) {
                                        bool isLastGame = context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .checkIfIsTheLastQuestionOfGame(
                                                queations: gameState
                                                    .listGameData.length);
                                        if (isLastGame) {
                                          Future.delayed(
                                              const Duration(seconds: 2),
                                              () async {
                                            Navigator.of(context).pop();
                                          });
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
                                            actionOfWrongAnswer: () async {});
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