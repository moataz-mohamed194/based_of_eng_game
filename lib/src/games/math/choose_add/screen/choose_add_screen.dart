import 'package:based_of_eng_game/src/core/theme_text.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../../src_model/model/game_letters_model.dart';
import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/games_structure/basic_of_game_data.dart';
import '../../../../core/math_weidgt/domino.dart';
import '../../../../core/math_weidgt/get_the_blocks.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/choose_sticks_cubit.dart';
import '../widget/card_of_number.dart';
import '../widget/card_of_selected.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/math_weidgt/stick.dart';

class ChooseAddScreen extends StatelessWidget {
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
                Border.all(color: AppColorPhonetics.boarderColor, width: 5)),
        child: BlocConsumer<ChooseAddCubit, ChooseAddInitial>(
            listener: (context, state) {},
            builder: (context, gameState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  10.pw,
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _question(question: gameState.mainQuestion),
                      10.ph,
                      _question(question: gameState.subQuestion),
                    ],
                  )),
                  Expanded(
                      child: FittedBox(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: List.generate(
                            gameState.gameChoices?.length ?? 0,
                            (index) => _answer(
                                gameState: gameState,
                                question: gameState.gameChoices![index],
                                mainBloc:
                                    context.read<CurrentGamePhoneticsCubit>(),
                                bloc: context.read<ChooseAddCubit>()))),
                  )),
                  10.pw,
                ],
              );
            }));
  }

  _question({required GameLettersGameFinalModel? question}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 20.w,
          height: 20.w,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(AppImagesMath.woodBgNumber))),
          child: FittedBox(
            child: Text(
              "${question?.letter ?? 0}",
              style: TextStyle(
                color: AppColorPhonetics.darkBlueColor,
                fontSize: 20.sp,
                fontFamily: AppTheme.getFontFamily5(),
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ),
        5.ph,
        GetTheBlocks(
          countOfBoxes: int.parse("${question?.letter ?? 0}"),
        )
      ],
    );
  }

  _answer({
    required GameChoicesGameFinalModel? question,
    required ChooseAddInitial gameState,
    required CurrentGamePhoneticsCubit mainBloc,
    required ChooseAddCubit bloc,
  }) {
    return Row(
      children: [
        CardOfSelected(
          onTap: () async {
            if (mainBloc.ableButton()) {
              bool stateOfAnswer = bloc.addAnswer(userChoose: question);
              if (stateOfAnswer == true) {
                await mainBloc
                    .addSuccessAnswer(
                        questions: gameState.allGameData.length,
                        correctAnswers: gameState.correctAnswers + 1)
                    .whenComplete(() {
                  bool isLastQuestion = mainBloc.checkIfIsTheLastQuestionOfGame(
                      queations: gameState.allGameData.length);

                  if (isLastQuestion) {
                    // Future.delayed(const Duration(seconds: 2),
                    //     () async {
                    //   Navigator.of(context).pop();
                    // });
                  } else {
                    Future.delayed(const Duration(seconds: 2), () async {
                      await mainBloc.updateIndexOfCurrentGame();
                      bloc.updateTheCurrentGame(index: mainBloc.state.index);
                    });
                  }
                });
              } else {
                await mainBloc.addWrongAnswer(actionOfWrongAnswer: () async {});
              }
            }
          },
          itsId: question?.id ?? 0,
          isCorrect: (gameState.isCorrect == true) &&
              (question?.isCorrect).toString() == '1',
        ),
        10.pw,
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            GetTheBlocks(
              countOfBoxes: int.parse("${question?.choice ?? 0}"),
            ),
            5.ph,
            Container(
              width: 20.w,
              height: 20.w,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImagesMath.woodBgNumber))),
              child: FittedBox(
                child: Text(
                  "${question?.choice ?? 0}",
                  style: TextStyle(
                    color: AppColorPhonetics.darkBlueColor,
                    fontSize: 20.sp,
                    fontFamily: AppTheme.getFontFamily5(),
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
