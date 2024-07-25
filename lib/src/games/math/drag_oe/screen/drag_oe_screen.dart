import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/math_weidgt/domino.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/drag_oe_cubit.dart';

class DragOeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                          color: AppColorPhonetics.boarderColor, width: 5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        gameState.correctAnswers.length,
                        (index) => _childOfDomino(
                            data: gameState.correctAnswers[index])),
                  ),
                );
              }, onAcceptWithDetails: (item) async {
                if (context.read<CurrentGamePhoneticsCubit>().ableButton()) {
                  bool stateOfAnswer = context
                      .read<DragOeCubit>()
                      .addAnswer(userChoose: item.data);
                  if (stateOfAnswer == true) {
                    await context
                        .read<CurrentGamePhoneticsCubit>()
                        .addSuccessAnswer(
                            subAction: () {
                              // context
                              //     .read<DragOeCubit>()
                              //     .checkIsNeedToIncreaseIndex(action: () {
                              //   context
                              //       .read<CurrentGamePhoneticsCubit>()
                              //       .updateIndexOfCurrentGame();
                              // });
                            },
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
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                        color: AppColorPhonetics.boarderColor, width: 5)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      gameState.gameChoices?.length ?? 0,
                      (index) => Draggable<GameChoicesGameFinalModel>(
                          maxSimultaneousDrags: 1,
                          feedback: _childOfDomino(
                              data: gameState.gameChoices![index]),
                          // childWhenDragging: ,
                          data: gameState.gameChoices![index],
                          child: _childOfDomino(
                              data: gameState.gameChoices![index]))),
                ),
              ),
            ],
          );
        });
  }

  _childOfDomino({required GameChoicesGameFinalModel data}) {
    return Column(
      children: [
        Text(
          data.choice ?? '0',
          style: TextStyle(
            color: AppColorPhonetics.darkBlueColor,
            fontSize: 20.sp,
            fontFamily: AppTheme.getFontFamily5(),
            fontWeight: FontWeight.w400,
            height: 0,
          ),
        ),
        DominoWidget(
          count: int.parse(data.choice ?? '0'),
        ),
      ],
    );
  }
}
