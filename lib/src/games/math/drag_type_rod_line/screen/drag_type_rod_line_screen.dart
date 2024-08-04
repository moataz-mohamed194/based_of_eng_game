import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/math_weidgt/card_of_Beads.dart';
import '../../../../core/math_weidgt/card_of_blocks.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/math_weidgt/get_the_blocks.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../DDT_change/widget/card_of_number_of_ddt.dart';
import '../../DDT_change/widget/card_of_typing_number.dart';
import '../../choose_from_obj/widget/card_of_number.dart';
import '../manager/drag_type_rod_line_cubit.dart';

class DragTypeNumberLineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height -
            (90.h + 50.h + 5 + 20.h), // < 760
        margin: EdgeInsets.only(left: 40.w, right: 40.w, bottom: 20.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: AppColorPhonetics.darkBlueColor, width: 5)),
        child: BlocConsumer<DragTypeRodLineCubit, DragTypeRodLineInitial>(
            listener: (context, state) {},
            builder: (context, gameState) {
              return Row(
                children: [
                  Expanded(
                      flex: 2,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(
                                      gameState.finalGameLetters?.length ?? 0,
                                      (index) => (gameState
                                                  .finalGameLetters?[index]
                                                  .id ==
                                              null)
                                          ? SizedBox()
                                          : GetTheBlocks(
                                              countOfBoxes: int.parse(
                                                  "${gameState.finalGameLetters?[index].letter}"),
                                            ))),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: 75.h *
                                          (gameState.finalGameLetters?.length ??
                                              0) +
                                      40.w,
                                  child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(
                                          gameState.finalGameLetters?.length ??
                                              0,
                                          (index) => Container(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // if (index != 0) ...{
                                                    //
                                                    // },
                                                    if (gameState
                                                            .finalGameLetters?[
                                                                index]
                                                            .id !=
                                                        null) ...{
                                                      CardOfNumberDDt(
                                                        number: gameState
                                                                .finalGameLetters?[
                                                                    index]
                                                                .letter ??
                                                            '0',
                                                      ),
                                                    } else ...{
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 99.h,
                                                        child: Text(
                                                          gameState
                                                                  .finalGameLetters?[
                                                                      index]
                                                                  .letter ??
                                                              '0',
                                                          style: TextStyle(
                                                            color: AppColorPhonetics
                                                                .darkBlueColor,
                                                            fontSize: 25.sp,
                                                            fontFamily: AppTheme
                                                                .getFontFamily5(),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      )
                                                    }
                                                  ],
                                                ),
                                              ))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 2,
                      child: FittedBox(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          // width: MediaQuery.of(context).size.width / 2,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "=",
                                style: TextStyle(
                                  color: AppColorPhonetics.darkBlueColor,
                                  fontSize: 30.sp,
                                  fontFamily: AppTheme.getFontFamily5(),
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  DragTarget<GameChoicesGameFinalModel>(
                                    builder: (
                                      BuildContext context,
                                      List<dynamic> accepted,
                                      List<dynamic> rejected,
                                    ) {
                                      return CardOfBeads(
                                        newWidget:
                                            gameState.isCorrectDrag != true
                                                ? SizedBox()
                                                : FittedBox(
                                                    child: GetTheBeads(
                                                    countOfBalls: int.parse(
                                                        gameState.correctAnswer
                                                                ?.choice ??
                                                            '0'),
                                                  )),
                                        number: int.parse(
                                            "${gameState.correctAnswer?.choice ?? 0}"),
                                        tools: ToolsOfMath.beads,
                                      );
                                    },
                                    onAcceptWithDetails: (item) async {
                                      if (context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .ableButton() &&
                                          gameState.isCorrect != true) {
                                        bool stateAction = context
                                            .read<DragTypeRodLineCubit>()
                                            .addAnswer(userChoose: item.data);
                                        if (stateAction != true) {
                                          await context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .addWrongAnswer(
                                                  actionOfWrongAnswer:
                                                      () async {});
                                        }
                                      }
                                    },
                                  ),
                                  10.ph,
                                  CardOfTypingNumberDDT(
                                    number: gameState.isCorrect == true
                                        ? (gameState.correctAnswer?.choice ??
                                            '0')
                                        : '',
                                    // number: '0',
                                    onTap: () => (context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .ableButton())
                                        ? _openKeyboard(
                                            context: context,
                                            action: (String answer) async {
                                              if (context
                                                  .read<
                                                      CurrentGamePhoneticsCubit>()
                                                  .ableButton()) {
                                                bool stateOfAnswer = await context
                                                    .read<
                                                        DragTypeRodLineCubit>()
                                                    .addAnswerType(
                                                        userChoose:
                                                            answer ?? '');
                                                Navigator.of(context).pop();
                                                if (stateOfAnswer == true) {
                                                  await context
                                                      .read<
                                                          CurrentGamePhoneticsCubit>()
                                                      .addSuccessAnswer(
                                                          questions: gameState
                                                              .allGameData
                                                              .length,
                                                          correctAnswers:
                                                              ((gameState.correctAnswers ??
                                                                      0) +
                                                                  1))
                                                      .whenComplete(() {
                                                    bool isLastQuestion = context
                                                        .read<
                                                            CurrentGamePhoneticsCubit>()
                                                        .checkIfIsTheLastQuestionOfGame(
                                                            queations: gameState
                                                                .allGameData
                                                                .length);
                                                    print(
                                                        'isLastQuestion:$isLastQuestion');
                                                    if (isLastQuestion !=
                                                        true) {
                                                      Future.delayed(
                                                          const Duration(
                                                              seconds: 2),
                                                          () async {
                                                        await context
                                                            .read<
                                                                CurrentGamePhoneticsCubit>()
                                                            .updateIndexOfCurrentGame();
                                                        context
                                                            .read<
                                                                DragTypeRodLineCubit>()
                                                            .updateTheCurrentGame(
                                                                index: context
                                                                    .read<
                                                                        CurrentGamePhoneticsCubit>()
                                                                    .state
                                                                    .index);
                                                      });
                                                    }
                                                  });
                                                } else {
                                                  await context
                                                      .read<
                                                          CurrentGamePhoneticsCubit>()
                                                      .addWrongAnswer(
                                                          actionOfWrongAnswer:
                                                              () async {});
                                                }
                                              }
                                            },
                                          )
                                        : null,
                                  )
                                ],
                              ),
                              10.pw,
                              SizedBox(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: List.generate(
                                        gameState.gameChoices?.length ?? 0,
                                        (index) => Column(
                                              children: [
                                                Draggable<
                                                        GameChoicesGameFinalModel>(
                                                    feedback: GetTheBeads(
                                                      countOfBalls: int.parse(
                                                          gameState
                                                                  .gameChoices?[
                                                                      index]
                                                                  .choice ??
                                                              '0'),
                                                    ),
                                                    data: gameState
                                                        .gameChoices?[index],
                                                    childWhenDragging:
                                                        GetTheBeads(
                                                      countOfBalls: int.parse(
                                                          gameState
                                                                  .gameChoices?[
                                                                      index]
                                                                  .choice ??
                                                              '0'),
                                                    ),
                                                    maxSimultaneousDrags: 1,
                                                    child: GetTheBeads(
                                                      countOfBalls: int.parse(
                                                          gameState
                                                                  .gameChoices?[
                                                                      index]
                                                                  .choice ??
                                                              '0'),
                                                    )),
                                                5.ph,
                                              ],
                                            ))),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              );
            }));
  }

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  void _openKeyboard({
    required context,
    required void Function(String answer) action,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: _controller,
            autofocus: true,
            focusNode: _focusNode,
            keyboardType: TextInputType.number,
            onSubmitted: (value) async {
              action(value);
            },
            decoration: InputDecoration(
              prefixIcon: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close)),
              border: OutlineInputBorder(),
            ),
          ),
        );
      },
    ).whenComplete(() {
      print('_focusNode:$_focusNode');

      _focusNode.unfocus();
      // Restore the system UI overlays when the modal is closed
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    });
  }
}
