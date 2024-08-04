import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/drag_word_to_pic_cubit.dart';
import '../widget/text_in_drag.dart';
import '../widget/row_image.dart';

class DragWordToPicGameScreen extends StatefulWidget {
  const DragWordToPicGameScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DragWordToPicGameScreen();
  }
}

class _DragWordToPicGameScreen extends State<DragWordToPicGameScreen> {
  @override
  void initState() {
    final GameFinalModel gameData =
        context.read<DragWordToPicCubit>().state.gameData;
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
    return BlocConsumer<DragWordToPicCubit, DragWordToPicInitial>(
        listener: (context, state) {
      // int success = state.correctIndexes.length;
      // if (success ==
      //     (gameData.gameImages?.where((e) => e.correct == 1).toList().length ??
      //         1)) {
      //   Future.delayed(Duration(seconds: 2), () {
      //     // context.read<CurrentGamePhoneticsCubit>().sendStars(
      //     //     gamesId: [state.gameData.id ?? 0],
      //     //     actionOfStars: (int countOfStars, List<int> listOfIds) {
      //     //       context
      //     //           .read<JourneyBarCubit>()
      //     //           .sendStars(gamesId: listOfIds, countOfStar: countOfStars);
      //     //     });
      //
      //     Navigator.pop(context);
      //   });
      // }
      // if (success == 2 || success == 4 || success ==5) {
      //   context.read<CurrentGamePhoneticsCubit>().increaseDirectlyCountOfStar();
      // }
    }, builder: (context, stateOfGameData) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                10.pw,
                // 10.ph,
                Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.center,
                      height: MediaQuery.of(context).size.height - 0.4.sh,
                      padding: const EdgeInsets.all(15),
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
                      child: Wrap(
                        direction: Axis.vertical,
                        // mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 8,
                        runSpacing: 7,
                        children: List.generate(
                          stateOfGameData.mainGameImages?.length ?? 0,
                          (index) => stateOfGameData.correctedAnswers.contains(
                                      stateOfGameData
                                          .mainGameImages?[index].id) ==
                                  false
                              ? Draggable<GameImagesGameFinalModel>(
                                  data: stateOfGameData.mainGameImages?[index],
                                  maxSimultaneousDrags: 1,
                                  childWhenDragging: SizedBox(
                                    height: 29.h,
                                    width: 25.w,
                                  ),
                                  feedback: TextInDrag(
                                      isHide: false,
                                      image: stateOfGameData
                                          .mainGameImages![index]),
                                  child: TextInDrag(
                                      isHide: false,
                                      image: stateOfGameData
                                          .mainGameImages![index]),
                                )
                              : Opacity(
                                  opacity: .7,
                                  child: SizedBox(
                                    height: 29.h,
                                    width: 25.w,
                                    child: TextInDrag(
                                        isHide: true,
                                        image: stateOfGameData
                                            .mainGameImages![index]),
                                  )),
                        ),
                      )),
                ),

                Expanded(
                  flex: 4,
                  child: SizedBox(
                    // height: MediaQuery.of(context).size.height - 0.4.sh,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RowImage(
                          gameImages: stateOfGameData.gameImages ?? [],
                          mainGameImages: stateOfGameData.mainGameImages ?? [],
                        ),
                        RowImage(
                          gameImages: stateOfGameData.gameImages2 ?? [],
                          mainGameImages: stateOfGameData.mainGameImages ?? [],
                        )
                      ],
                    ),
                  ),
                ),
                10.pw,
              ],
            ),
            10.ph,
          ],
        ),
      );
    });
  }
}
