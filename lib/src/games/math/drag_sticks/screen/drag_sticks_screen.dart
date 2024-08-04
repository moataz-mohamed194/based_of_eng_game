import 'package:based_of_eng_game/src/cubit/current_game_phonetics_cubit.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src_model/export_models.dart';
import '../../../../core/math_weidgt/stick.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../manager/drag_sticks_cubit.dart';

class DragSticksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height -
            (90.h + 50.h + 5 + 20.h), // < 760
        width: (MediaQuery.of(context).size.width - 40.w),
        margin: EdgeInsets.only(bottom: 20.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: AppColorPhonetics.darkBorderColor, width: 5)),
        child: BlocConsumer<DragSticksCubit, DragSticksInitial>(
            listener: (context, state) {},
            builder: (context, gameState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  5.ph,
                  Container(
                    width: (25.w) * (gameState.gameLetters?.length ?? 0),
                    height: 100.h,
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: AppColorPhonetics.darkBlueColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadows: [
                        BoxShadow(
                          color: AppColorPhonetics.lightBlack,
                          blurRadius: 14,
                          offset: Offset(0, 4),
                          spreadRadius: 0,
                        )
                      ],
                    ),
                    child: FittedBox(
                      child: Row(
                        children: List.generate(
                            (gameState.gameLetters?.length ?? 0),
                            (index) => _tableOfGame(
                                index: index,
                                gameState: gameState,
                                bloc: context.read<DragSticksCubit>(),
                                mainBloc:
                                    context.read<CurrentGamePhoneticsCubit>())),
                      ),
                    ),
                  ),
                  5.ph,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        (gameState.gameImages?.length ?? 0),
                        (index) => Draggable<GameImagesGameFinalModel>(
                            data: gameState.gameImages?[index],
                            maxSimultaneousDrags:
                                (gameState.gameAnswers?.where((ele) => ele.id == gameState.gameImages?[index].gameLetterId).isNotEmpty ?? false)
                                    ? 0
                                    : 1,
                            feedback: _bodyOfGame(
                                count: int.parse(
                                    "${gameState.gameImages?[index].word ?? 0}"),
                                isDisable: false),
                            child: _bodyOfGame(
                                count: int.parse(
                                    "${gameState.gameImages?[index].word ?? 0}"),
                                isDisable: (gameState.gameAnswers
                                        ?.where((ele) =>
                                            ele.id ==
                                            gameState.gameImages?[index].gameLetterId)
                                        .isNotEmpty ??
                                    false)))),
                  )
                ],
              );
            }));
  }

  _tableOfGame(
      {required DragSticksInitial gameState,
      required int index,
      required DragSticksCubit bloc,
      required mainBloc}) {
    return DragTarget<GameImagesGameFinalModel>(builder: (
      BuildContext context,
      List<dynamic> accepted,
      List<dynamic> rejected,
    ) {
      return Container(
          width: (25.w),
          height: 100.h,
          decoration: BoxDecoration(
              border: ((gameState.gameLetters?.length ?? 0) - 1) == index
                  ? null
                  : const Border(
                      right: BorderSide(
                        color: AppColorPhonetics.darkBlueColor,
                        width: 1.0,
                      ),
                    )),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: FittedBox(
                  child: Text(
                    gameState.gameLetters?[index].letter ?? '0',
                    style: TextStyle(
                      color: AppColorPhonetics.darkBlueColor,
                      // fontSize: 20.sp,
                      fontFamily: AppTheme.getFontFamily5(),
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ),
              const Divider(color: AppColorPhonetics.darkBlueColor),
              Expanded(
                  child: SizedBox(
                width: (25.w),
                height: 45.h,
                child: ((gameState.gameAnswers != null) &&
                            (gameState.gameAnswers?.isNotEmpty ?? false) &&
                            gameState.gameAnswers!
                                .where((ele) =>
                                    ele.id == gameState.gameLetters?[index].id)
                                .isNotEmpty ??
                        false)
                    ? FittedBox(
                        child: Slick(
                            count: int.parse(
                                gameState.gameLetters?[index].letter ?? '0'),
                            mainAxisAlignment: MainAxisAlignment.center),
                      )
                    : null,
              ))
            ],
          ));
    }, onAcceptWithDetails: (item) async {
      print('onAcceptWithDetails');
      if (mainBloc.ableButton()) {
        bool stateOfAnswer = bloc.addAnswer(
            userChoose: item.data, subAnswer: gameState.gameLetters![index]);
        if (stateOfAnswer == true) {
          await mainBloc
              .addSuccessAnswer(
                  questions: bloc.state.countOfQuestions,
                  correctAnswers: bloc.state.countOfAnswers ?? 0)
              .whenComplete(() async {
            bool isLastInGame = await bloc.checkIsNeedToIncreaseIndex();
            if (isLastInGame == true) {
              bool isLastQuestion =
                  mainBloc.secondWayToCheckIfIsTheLastQuestionOfGame(
                      queations: gameState.countOfQuestions);
              print('isLastQuestion:$isLastQuestion');
              if (isLastQuestion != true) {
                Future.delayed(const Duration(seconds: 2), () async {
                  await mainBloc.updateIndexOfCurrentGame();
                  bloc.updateTheCurrentGame(newIndex: mainBloc.state.index);
                });
              }
            }
          });
        } else {
          await mainBloc.addWrongAnswer(actionOfWrongAnswer: () async {});
        }
      }
    });
  }

  _bodyOfGame({required int count, required bool isDisable}) {
    return Container(
      width: 50.w,
      // height: 66.h,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: [
          BoxShadow(
            color: AppColorPhonetics.lightBlack2,
            blurRadius: 14,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      padding: const EdgeInsets.all(5),
      child: Container(
        padding: EdgeInsets.all(5),
        width: 50.w,
        height: 60.h,
        alignment: Alignment.center,
        decoration: ShapeDecoration(
          color: isDisable
              ? Colors.grey.shade100
              : AppColorPhonetics.lightYellowColor3,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color: isDisable
                    ? Colors.grey
                    : AppColorPhonetics.lightYellowColor2),
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        child: count == 0
            ? const SizedBox()
            : FittedBox(
                child: Slick(
                    count: count,
                    mainAxisAlignment: MainAxisAlignment.center,
                    isDisable: isDisable ? Colors.grey : null),
              ),
      ),
    );
  }
}
