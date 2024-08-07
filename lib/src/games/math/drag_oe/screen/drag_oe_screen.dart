import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/math_weidgt/domino.dart';
import '../../../../core/math_weidgt/get_the_blocks.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/drag_oe_cubit.dart';

class DragOeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DragOeCubit, DragOeInitial>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Row(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DragTarget<GameChoicesGameFinalModel>(builder: (
                BuildContext context,
                List<dynamic> accepted,
                List<dynamic> rejected,
              ) {
                return Container(
                  height: MediaQuery.of(context).size.height -
                      (90.h + 50.h + 5 + 20.h), // < 760
                  width: (MediaQuery.of(context).size.width - 40.w) / 2,
                  margin: EdgeInsets.only(bottom: 20.h),
                    padding: const EdgeInsets.only(bottom: 5),

                    alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: AppColorPhonetics.darkBorderColor, width: 5)),
                  child:gameState.correctAnswers.isEmpty?SizedBox():FittedBox(
                      child:  SizedBox(
                        width: (MediaQuery.of(context).size.width - 40.w) / 2,
                        height: MediaQuery.of(context).size.height -
                            (90.h + 50.h + 5 + 20.h),
                        child:gameState.tools == ToolsOfMath.domino
                            ? _parentOfDominoResult(gameState: gameState)
                            : _parentOfBlocksResult(gameState: gameState),
                      )

                )
                );
              },
                  onAcceptWithDetails: (item) async {
                if (context.read<CurrentGamePhoneticsCubit>().ableButton()) {
                  bool stateOfAnswer = context
                      .read<DragOeCubit>()
                      .addAnswer(userChoose: item.data);
                  if (stateOfAnswer == true) {
                    await context
                        .read<CurrentGamePhoneticsCubit>()
                        .addSuccessAnswer(
                            questions: context
                                .read<DragOeCubit>()
                                .state
                                .countOfQuestions,
                            correctAnswers: context
                                .read<DragOeCubit>()
                                .state
                                .countOfCorrect)
                        .whenComplete(() async {
                      bool isLastInGame = await context
                          .read<DragOeCubit>()
                          .checkIsNeedToIncreaseIndex();
                      print('isLastInGame:$isLastInGame');
                      if (isLastInGame == true) {
                        bool isLastQuestion = context
                            .read<CurrentGamePhoneticsCubit>()
                            .secondWayToCheckIfIsTheLastQuestionOfGame(
                                queations: gameState.countOfQuestions);
                        print('isLastQuestion:$isLastQuestion');
                        if (isLastQuestion != true) {
                          Future.delayed(const Duration(seconds: 2), () async {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .updateIndexOfCurrentGame();
                            context.read<DragOeCubit>().updateTheCurrentGame(
                                newIndex: context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .state
                                    .index);
                          });
                        }
                      }
                    });
                  } else {
                    await context
                        .read<CurrentGamePhoneticsCubit>()
                        .addWrongAnswer(actionOfWrongAnswer: () async {});
                  }
                }
              }),
              Container(
                height: MediaQuery.of(context).size.height -
                    (90.h + 50.h + 5 + 20.h), // < 760
                width: (MediaQuery.of(context).size.width - 40.w) / 2,
                margin: EdgeInsets.only(bottom: 20.h),
                padding: const EdgeInsets.only(bottom: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: AppColorPhonetics.darkBorderColor, width: 5)),
                child: FittedBox(
                    child: SizedBox(
                  width: (MediaQuery.of(context).size.width - 40.w) / 2,
                      height: MediaQuery.of(context).size.height -
                          (90.h + 50.h + 5 + 20.h),
                  child: gameState.tools == ToolsOfMath.domino
                      ? _parentOfDomino(gameState: gameState)
                      : _parentOfBlocks(gameState: gameState),
                )),
              ),
            ],
          );
        });
  }

  _parentOfDominoResult({required DragOeInitial gameState}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          gameState.correctAnswers.length,
          (index) => _childOfDomino(
              showSpace:true,
              isDisable: false, data: gameState.correctAnswers[index])),
    );
  }

  _parentOfBlocksResult({required DragOeInitial gameState}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
          gameState.correctAnswers.length,
          (index) => _childOfBlocks(
              isDisable: false, data: gameState.correctAnswers[index])),
    );
  }

  _parentOfDomino({required DragOeInitial gameState}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
          gameState.gameChoices?.length ?? 0,
          (index) => Draggable<GameChoicesGameFinalModel>(
              maxSimultaneousDrags: gameState.correctAnswers
                      .where((element) =>
                          element.id == gameState.gameChoices![index].id)
                      .isNotEmpty
                  ? 0
                  : 1,
              feedback: _childOfDomino(
                  isDisable: false, data: gameState.gameChoices![index]),
              // childWhenDragging: ,
              data: gameState.gameChoices![index],
              child: _childOfDomino(
                  isDisable: gameState.correctAnswers
                      .where((element) =>
                          element.id == gameState.gameChoices![index].id)
                      .isNotEmpty,
                  data: gameState.gameChoices![index]))),
    );
  }

  _parentOfBlocks({required DragOeInitial gameState}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
          gameState.gameChoices?.length ?? 0,
          (index) => Transform.scale(
        scale: 1.3,
        child:Draggable<GameChoicesGameFinalModel>(
              maxSimultaneousDrags: gameState.correctAnswers
                      .where((element) =>
                          element.id == gameState.gameChoices![index].id)
                      .isNotEmpty
                  ? 0
                  : 1,
              feedback: _childOfBlocks(
                  isDisable: false, data: gameState.gameChoices![index]),
              // childWhenDragging: ,
              data: gameState.gameChoices![index],
              child: _childOfBlocks(
                  isDisable: gameState.correctAnswers
                      .where((element) =>
                          element.id == gameState.gameChoices![index].id)
                      .isNotEmpty,
                  data: gameState.gameChoices![index])))),
    );
  }

  _childOfDomino(
      {required GameChoicesGameFinalModel data, required bool isDisable, bool? showSpace}) {
    return Opacity(
      opacity: isDisable ? (.1) : 1,
      child: FittedBox(
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.choice ?? '0',
                  style: TextStyle(
                    color: AppColorPhonetics.darkBlueColor,
                    fontSize: 20.sp,
                    fontFamily: AppTheme.getFontFamily5(),
                    fontWeight: FontWeight.w400,
                    height: 0,
                    decoration: TextDecoration.none,
                  ),
                ),
                DominoWidget(
                  count: int.parse(data.choice ?? '0'),
                ),
              ],
            ),
            if(showSpace==true)...{
              10.pw
            }
          ],
        ),
      ),
    );
  }

  _childOfBlocks(
      {required GameChoicesGameFinalModel data, required bool isDisable}) {
    return Opacity(
        opacity: isDisable ? (.1) : 1,
        child: GetTheBlocks(
          countOfBoxes: int.parse(data.choice ?? '0'),
        ));
  }
}
