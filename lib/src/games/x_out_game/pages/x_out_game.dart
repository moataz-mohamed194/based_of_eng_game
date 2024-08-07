import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';

import '../../../core/assets_images_phonetics.dart';
import '../../../core/games_structure/basic_of_game_data.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/talk_tts.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/x_out_cubit.dart';
import '../widget/item_of_x_out.dart';

class XOutGameScreen extends StatefulWidget {
  const XOutGameScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _XOutGameScreen();
  }
}

class _XOutGameScreen extends State<XOutGameScreen> {
  @override
  void initState() {
    final List<GameFinalModel> gameData =
        context.read<XOutCubit>().state.listGameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.length);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.isLetter,
        stateOfStringWillSay: gameData.first.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stateOfCurrentGamePhoneticsCubit =
        context.watch<CurrentGamePhoneticsCubit>().state;

    final screenHeight = MediaQuery.of(context).size.height - 90.h;
    final screenWidth = MediaQuery.of(context).size.width - 120.w;
    final gridItemHeight = (screenHeight - (10.h) - (20.sp) - 2 * 15) /
        2; // 4 for padding, 40 for text height, 2 * 15 for border radius
    final gridItemWidth = (screenWidth - (10.h) - 3 * 2) /
        2; // 4 for padding, 3 * 2 for border width
    return BlocConsumer<XOutCubit, XOutInitial>(
      listener: (context, state) {
        context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
            stateOfStringIsWord: StateOfSubWord.isLetter,
            stateOfStringWillSay: state.gameData?.mainLetter ?? '');
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(),
            Container(
                margin: const EdgeInsets.only(bottom: 15),
                child: Draggable<String>(
                  maxSimultaneousDrags: 1,
                  data: state.gameData?.mainLetter ?? '',
                  childWhenDragging: SizedBox(
                    // height: 50.h,//(MediaQuery.of(context).size.height / 2.8).h,
                    width: 40.w,
                  ),
                  feedback: Image.asset(
                    AppImagesPhonetics.outX,
                    // height: (MediaQuery.of(context).size.height / 2.8).h,
                    width: 40.w,
                  ),
                  child: ((stateOfCurrentGamePhoneticsCubit.stateOfAvatar ==
                          BasicOfGameData.stateOfWin))
                      ? SizedBox(
                          width: 40.w,
                        )
                      : Image.asset(
                          AppImagesPhonetics.X,
                          width: 40.w,
                        ),
                )),
            const SizedBox(),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                  right: state.isArabic == true ? 0.w : 15.w,
                  left: state.isArabic == false ? 0.w : 15.w),
              width: screenWidth,
              height: screenHeight,
              decoration: BoxDecoration(
                color: AppColorPhonetics.darkBorderColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                    color: AppColorPhonetics.darkBorderColor, width: 1.w),
              ),
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: FittedBox(
                      child: Text(
                        state.gameData?.mainLetter ?? '',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: AppTheme.getFontFamily5(),
                              color: Colors.white,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  if (state.gameImages?.isNotEmpty ?? false) ...{
                    Expanded(
                      flex: MediaQuery.of(context).size.height > 750 ? 7 : 4,
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Number of columns in the grid
                          childAspectRatio: gridItemWidth /
                              gridItemHeight, // Aspect ratio of each item
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          final isSelected =
                              state.selectedItems?.contains(index) == true;
                          final isCorrect =
                              state.gameImages?[index].correct == 0;
                          final bool gameHasData =
                              state.gameImages?.isEmpty ?? false;
                          return gameHasData
                              ? const SizedBox()
                              : XOutItemWidget(
                                  index: index,
                                  imageId: state.gameImages?[index].id ?? 0,
                                  imageName:
                                      state.gameImages?[index].image ?? "",
                                  isSelected: isSelected,
                                  isCorrect: isCorrect,
                                  isWrong: state.isWrong,
                                  onDrag: (item) async {
                                    if (context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .ableButton() &&
                                        state.currentGameIndex ==
                                            context
                                                .read<
                                                    CurrentGamePhoneticsCubit>()
                                                .state
                                                .index) {
                                      if (state.gameImages?[index].correct ==
                                          0) {
                                        await context
                                            .read<XOutCubit>()
                                            .selectItem(index);
                                        await context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .addSuccessAnswer(
                                                isArabic: state.isArabic,
                                                questions:
                                                    state.listGameData.length,
                                                correctAnswers:
                                                    (state.currentGameIndex) +
                                                        1)
                                            .whenComplete(() async {
                                          bool isLastQuestion = context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .checkIfIsTheLastQuestionOfGame(
                                                  queations: state
                                                      .listGameData.length);
                                          if (isLastQuestion) {
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
                                            await context
                                                .read<XOutCubit>()
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
                                            .read<XOutCubit>()
                                            .addWrongAnswer(
                                                isWrong: state
                                                        .gameData
                                                        ?.gameImages?[index]
                                                        .id ??
                                                    0);
                                        await context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .addWrongAnswer(
                                                isArabic: state.isArabic,
                                                actionOfWrongAnswer: () async {
                                                  await context
                                                      .read<XOutCubit>()
                                                      .clearWrongAnswer();
                                                });
                                      }
                                    }
                                  },
                                  word: state.gameImages?[index].word ?? '',
                                  onTap: () async {
                                    await TalkTts.startTalk(
                                        text:
                                            state.gameImages?[index].word ?? '',
                                        isArabic: state.isArabic);
                                  },
                                );
                        },
                      ),
                    ),
                  }
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
