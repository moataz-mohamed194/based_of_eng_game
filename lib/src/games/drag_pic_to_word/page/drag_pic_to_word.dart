import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/drag_pic_to_word_cubit.dart';
import '../widget/image_in_drag.dart';

class DragPicToWordGameScreen extends StatefulWidget {
  const DragPicToWordGameScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DragPicToWordGameScreen();
  }
}

class _DragPicToWordGameScreen extends State<DragPicToWordGameScreen> {
  @override
  void initState() {
    final GameFinalModel gameData =
        context.read<DragPicToWordCubit>().state.gameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.gameImages?.length ?? 0);

    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.stopTalk,
        stateOfStringWillSay: gameData.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DragPicToWordCubit, DragPicToWordInitial>(
        listener: (context, state) {},
        builder: (context, stateOfGameData) {
          return Expanded(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                10.ph,
                10.ph,
                Container(
                    alignment: Alignment.center,
                    width: ((30.w + 14 + 10) *
                        (stateOfGameData.gameImages?.length ?? 0)),
                    padding: const EdgeInsets.all(24),
                    decoration: ShapeDecoration(
                      color: Colors.white.withOpacity(0.8199999928474426),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(4),
                        ),
                      ),
                      shadows: const [
                        BoxShadow(
                          color: Color(0x3F000000),
                          blurRadius: 14,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: List.generate(
                        stateOfGameData.gameImages?.length ?? 0,
                        (index) => stateOfGameData.correctedAnswers.contains(
                                    stateOfGameData.gameImages?[index].id) ==
                                false
                            ? Draggable<GameImagesGameFinalModel>(
                                data: stateOfGameData.gameImages?[index],
                                maxSimultaneousDrags: 1,
                                childWhenDragging: Container(
                                  width: 30.w,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 7),
                                  height: 50.h,
                                  padding: const EdgeInsets.only(
                                      left: 4.40, right: 3.70, bottom: 0.44),
                                ),
                                feedback: ImageInDrag(
                                    image: stateOfGameData.gameImages![index]),
                                child: ImageInDrag(
                                    image: stateOfGameData.gameImages![index]),
                              )
                            : Container(
                                width: 30.w,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                height: 50.h,
                                padding: const EdgeInsets.only(
                                    left: 4.40, right: 3.70, bottom: 0.44),
                                child: CachedNetworkImage(
                                  imageUrl: stateOfGameData
                                          .gameImages?[index].image ??
                                      '',
                                  color: Colors.grey.withOpacity(.7),
                                  placeholder: (context, url) => const Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                      ),
                    )),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(
                    stateOfGameData.gamesLetters?.length ?? 0,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          DottedBorder(
                              // color: Colors.black,
                              strokeWidth: 1,
                              dashPattern: [8, 4],
                              color: AppColorPhonetics.greyColor,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(7),
                              padding: const EdgeInsets.all(6),
                              child: DragTarget<GameImagesGameFinalModel>(
                                  builder: (
                                BuildContext context,
                                List<dynamic> accepted,
                                List<dynamic> rejected,
                              ) {
                                return SizedBox(
                                  height: (MediaQuery.of(context).size.width -
                                          20) /
                                      ((stateOfGameData.gamesLetters?.length ??
                                              0) +
                                          5),
                                  width: (MediaQuery.of(context).size.width -
                                          20) /
                                      ((stateOfGameData.gamesLetters?.length ??
                                              0) +
                                          5),
                                  child: stateOfGameData.correctedAnswers
                                          .contains(stateOfGameData
                                              .gamesLetters?[index].id)
                                      ? CachedNetworkImage(
                                          imageUrl: stateOfGameData
                                                  .gamesLetters?[index].image ??
                                              '',
                                          placeholder: (context, url) =>
                                              const Center(
                                            child: CupertinoActivityIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                        )
                                      : null,
                                );
                              }, onAcceptWithDetails: (item) async {
                                if (context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .ableButton() &&
                                    !stateOfGameData.correctedAnswers.contains(
                                        stateOfGameData
                                            .gamesLetters?[index].id)) {
                                  if (item.data.word?.toLowerCase() ==
                                      (stateOfGameData.gamesLetters?[index].word
                                          ?.toLowerCase())) {
                                    context
                                        .read<DragPicToWordCubit>()
                                        .addCorrectAnswer(
                                            correctAnswerId: item.data.id ?? 0);
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addSuccessAnswer(
                                            questions: stateOfGameData
                                                    .gamesLetters?.length ??
                                                0,
                                            correctAnswers: stateOfGameData
                                                .correctedAnswers.length)
                                        .whenComplete(() async {
                                      bool isLastQuestion = context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .secondWayToCheckIfIsTheLastQuestionOfGame(
                                              queations: stateOfGameData
                                                      .gamesLetters?.length ??
                                                  0);
                                      if (isLastQuestion) {
                                        // Future.delayed(
                                        //     const Duration(seconds: 2),
                                        //     () async {
                                        //   Navigator.of(context).pop();
                                        // });
                                      }
                                    });
                                  } else {
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addWrongAnswer(
                                            actionOfWrongAnswer: () async {});
                                  }
                                }
                              })),
                          8.ph,
                          Container(
                            color: AppColorPhonetics.lightBlueColor,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              stateOfGameData.gamesLetters?[index].word ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: AppColorPhonetics.darkBorderColor,
                                      fontFamily: AppTheme.getFontFamily5()),
                            ),
                          )
                        ],
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
