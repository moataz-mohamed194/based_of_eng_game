import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/math_weidgt/get_the_beads.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../DDT_change/widget/card_of_typing_number.dart';
import '../manager/count_type_number_cubit.dart';

class CountTypeNumberScreen extends StatelessWidget {
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
        child: BlocConsumer<CountTypeNumberCubit, CountTypeNumberInitial>(
            listener: (context, state) {},
            builder: (context, gameState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          gameState.gameLetters?.length ?? 0,
                          (index) => Column(
                                children: [
                                  GetTheBeads(
                                    countOfBalls: int.parse(
                                        gameState.gameLetters?[index].letter ??
                                            '0'),
                                    hideTheCircle: gameState.gameLetters?[index]
                                                .mainQuestion ==
                                            1
                                        ? false
                                        : true,
                                  ),
                                  10.ph,
                                ],
                              ))),
                  CardOfTypingNumberDDT(
                    number: gameState.isCorrect == true
                        ? (gameState.correctAns ?? '')
                        : '',
                    // number: '0',
                    onTap: () => (context
                            .read<CurrentGamePhoneticsCubit>()
                            .ableButton())
                        ? _openKeyboard(
                            context: context,
                            action: (String answer) async {
                              if (context
                                  .read<CurrentGamePhoneticsCubit>()
                                  .ableButton()) {
                                bool stateOfAnswer = context
                                    .read<CountTypeNumberCubit>()
                                    .addAnswer(userChoose: answer ?? '');
                                Navigator.of(context).pop();
                                if (stateOfAnswer == true) {
                                  await context
                                      .read<CurrentGamePhoneticsCubit>()
                                      .addSuccessAnswer(
                                          questions:
                                              gameState.allGameData.length,
                                          correctAnswers:
                                              ((gameState.correctAnswers ?? 0) +
                                                  1))
                                      .whenComplete(() {
                                    bool isLastQuestion = context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .checkIfIsTheLastQuestionOfGame(
                                            queations:
                                                gameState.allGameData.length);
                                    print('isLastQuestion:$isLastQuestion');
                                    if (isLastQuestion != true) {
                                      Future.delayed(const Duration(seconds: 2),
                                          () async {
                                        await context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .updateIndexOfCurrentGame();
                                        context
                                            .read<CountTypeNumberCubit>()
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
                                      .read<CurrentGamePhoneticsCubit>()
                                      .addWrongAnswer(
                                          actionOfWrongAnswer: () async {});
                                }
                              }
                            },
                          )
                        : null,
                  )
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
