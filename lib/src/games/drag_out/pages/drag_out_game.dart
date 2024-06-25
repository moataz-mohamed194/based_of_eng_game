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
import '../manager/drag_out_cubit.dart';

class DragOutGame extends StatefulWidget {
  const DragOutGame({super.key});
  @override
  State<StatefulWidget> createState() {
    return _DragOutGame();
  }
}

class _DragOutGame extends State<DragOutGame> {
  @override
  void initState() {
    final List<GameFinalModel> gameData =
        context.read<DragOutCubit>().state.allGameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.length);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: true,
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
        child: BlocConsumer<DragOutCubit, DragOutInitial>(
            listener: (context, state) {},
            builder: (context, gameState) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 15, left: 10),
                      child: Draggable<String>(
                        data: gameState.gameData.mainLetter ?? '',
                        childWhenDragging: SizedBox(
                          height: (MediaQuery.of(context).size.height / 2.8).h,
                          width: 130,
                        ),
                        feedback: Image.asset(
                          AppImagesPhonetics.outX,
                          height: (MediaQuery.of(context).size.height / 2.8).h,
                          width: 130,
                        ),
                        child: ((stateOfCurrentGamePhoneticsCubit
                                    .stateOfAvatar ==
                                BasicOfGameData.stateOfWin))
                            ? SizedBox(
                                height:
                                    (MediaQuery.of(context).size.height / 2.8)
                                        .h,
                                width: 130,
                              )
                            : Image.asset(
                                AppImagesPhonetics.X,
                                height:
                                    (MediaQuery.of(context).size.height / 2.8)
                                        .h,
                                width: 130,
                              ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(bottom: (15 + 50), top: 50),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    width: MediaQuery.of(context).size.width - (130 + 50 + 130),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: AppColorPhonetics.boarderColor, width: 5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                          gameState.gameData.gameImages?.length ?? 0,
                          (index) => DragTarget<String>(builder: (
                                BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected,
                              ) {
                                return (stateOfCurrentGamePhoneticsCubit
                                            .stateOfAvatar ==
                                        BasicOfGameData.stateOfWin)
                                    ? SizedBox(
                                        width:
                                            (MediaQuery.of(context).size.width -
                                                    (130 + 50 + 130)) /
                                                4,
                                        height: 110.h,
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          TalkTts.startTalk(
                                              text: gameState
                                                      .gameData
                                                      .gameImages?[index]
                                                      .word ??
                                                  '');
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl: gameState.gameData
                                                  .gameImages?[index].image ??
                                              '',
                                          width: (MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  (130 + 50 + 130)) /
                                              4,
                                          height: 110.h,
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CupertinoActivityIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Center(
                                            child: Text(
                                                '${gameState.gameData.gameImages?[index].word}'),
                                          ),
                                          fit: BoxFit.contain,
                                          // height: ,
                                        ),
                                      );
                              }, onAcceptWithDetails: (item) async {
                                debugPrint(
                                    '####:${gameState.gameData.gameImages?[index].word}');
                                debugPrint('####:${(item.data.toLowerCase())}');
                                if (gameState.gameData.gameImages?[index].word
                                        .toString()
                                        .split('')
                                        .first
                                        .toLowerCase() !=
                                    (item.data.toLowerCase())) {
                                  await context
                                      .read<CurrentGamePhoneticsCubit>()
                                      .addSuccessAnswer(
                                          questions:
                                              gameState.allGameData.length,
                                          correctAnswers: (gameState.index) + 1)
                                      .whenComplete(() async {
                                    bool isLastQuestion = context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .checkIfIsTheLastQuestionOfGame(
                                            queations:
                                                gameState.allGameData.length);
                                    if (isLastQuestion) {
                                      Future.delayed(const Duration(seconds: 2),
                                          () async {
                                        Navigator.of(context).pop();
                                      });
                                    } else {
                                      await context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .updateIndexOfCurrentGame();
                                      context
                                          .read<DragOutCubit>()
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
                                      .read<CurrentGamePhoneticsCubit>()
                                      .addWrongAnswer(
                                          actionOfWrongAnswer: () async {});
                                }
                              })),
                    ),
                  )
                ],
              );
            }));
  }
}
