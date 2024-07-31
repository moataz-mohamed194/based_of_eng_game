import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/game_types/game_phonatics_types.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../choose_from_obj/widget/card_of_number.dart';
import '../manager/ddt_number_cubit.dart';
import '../widget/card_of_number_of_ddt.dart';
import '../widget/card_of_typing_number.dart';

class DDtNumberScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DDTChangeCubit, DDTChangeInitial>(
        listener: (context, state) {},
        builder: (context, gameState) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5.h),
            // height: MediaQuery.of(context).size.height -
            //     (90.h + 50.h + 5 + 20.h), // < 760
            // height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(
              left: 20.w,
              right: 20.w,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                    color: AppColorPhonetics.darkBlueColor, width: 5)),
            child: FittedBox(
              child: SizedBox(
                // margin: EdgeInsets.only(
                //   left: 20.w,
                //   right: 20.w,
                // ),
                // height: (105.h) * 2,
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CardOfNumberDDt(
                                    number:
                                        "${gameState.headOfQuestions?.first.word ?? 0}",
                                  ),
                                  Text(
                                    "+",
                                    style: TextStyle(
                                      color: AppColorPhonetics.darkBlueColor,
                                      fontSize: 30.sp,
                                      fontFamily: AppTheme.getFontFamily5(),
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  CardOfNumberDDt(
                                    number:
                                        "${gameState.headOfQuestions?.last.word ?? 0}",
                                  ),
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
                                  CardOfTypingNumber(
                                    number: '',
                                    // number: '0',
                                    onTap: () => (context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .ableButton())
                                        ? _openKeyboard(
                                            context: context,
                                            gameState: gameState,
                                            bloc:
                                                context.read<DDTChangeCubit>(),
                                            mainBloc: context.read<
                                                CurrentGamePhoneticsCubit>())
                                        : null,
                                  )
                                ],
                              ),
                              5.ph,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CardOfNumberDDt(
                                    number:
                                        "${gameState.headOfQuestions?.first.correct ?? 0}",
                                  ),
                                  Text(
                                    "+",
                                    style: TextStyle(
                                      color: AppColorPhonetics.darkBlueColor,
                                      fontSize: 30.sp,
                                      fontFamily: AppTheme.getFontFamily5(),
                                      fontWeight: FontWeight.w400,
                                      height: 0,
                                    ),
                                  ),
                                  CardOfNumberDDt(
                                    number:
                                        "${gameState.headOfQuestions?.last.correct ?? 0}",
                                  ),
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
                                  CardOfTypingNumber(
                                    number: '',
                                    // number: '0',
                                    onTap: () => (context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .ableButton())
                                        ? _openKeyboard(
                                            context: context,
                                            gameState: gameState,
                                            bloc:
                                                context.read<DDTChangeCubit>(),
                                            mainBloc: context.read<
                                                CurrentGamePhoneticsCubit>())
                                        : null,
                                  )
                                ],
                              ),
                            ],
                          ),
                          15.pw,
                          Row(
                            children: [
                              Image.asset(
                                AppImagesMath.arrowOfDragDrop,
                                height: 50.h,
                              ),
                              Text(
                                "+${gameState.numberWillAddToAnswerFirstBox}",
                                style: TextStyle(
                                  color: AppColorPhonetics.darkBlueColor,
                                  fontSize: 15.sp,
                                  fontFamily: AppTheme.getFontFamily5(),
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: List.generate(
                            gameState.chooseOfQuestions?.length ?? 0,
                            (index) => Row(
                                  children: [
                                    CardOfNumberDDt(
                                      number:
                                          "${gameState.chooseOfQuestions?[index].choice ?? 0}",
                                    ),
                                    5.pw,
                                  ],
                                )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  void _openKeyboard({
    required context,
    required DDTChangeCubit bloc,
    required DDTChangeInitial gameState,
    required CurrentGamePhoneticsCubit mainBloc,
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
              // if (mainBloc.ableButton()) {
              //   bool stateOfAnswer = bloc.addAnswer(userChoose: value ?? '');
              //   Navigator.of(context).pop();
              //   if (stateOfAnswer == true) {
              //     await mainBloc
              //         .addSuccessAnswer(
              //             questions: gameState.allGameData.length,
              //             correctAnswers:
              //                 ((gameState.countOfCorrectAnswers ?? 0) + 1))
              //         .whenComplete(() {
              //       bool isLastQuestion =
              //           mainBloc.checkIfIsTheLastQuestionOfGame(
              //               queations: gameState.allGameData.length);
              //       print('isLastQuestion:$isLastQuestion');
              //       if (isLastQuestion != true) {
              //         Future.delayed(const Duration(seconds: 2), () async {
              //           await mainBloc.updateIndexOfCurrentGame();
              //           bloc.updateTheCurrentGame(
              //               newIndex: mainBloc.state.index);
              //         });
              //       }
              //     });
              //   } else {
              //     await mainBloc.addWrongAnswer(
              //         actionOfWrongAnswer: () async {});
              //   }
              // }
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
