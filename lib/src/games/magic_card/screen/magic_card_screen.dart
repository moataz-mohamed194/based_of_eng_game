import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/phonetics_color.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manger/magic_card_cubit.dart';
import '../widget/card_magic.dart';
import '../widget/hide_card.dart';

class MagicCardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MagicCardCubit, MagicCardInitial>(
        listener: (context, state) {
      context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
          stateOfStringIsWord: StateOfSubWord.isWord,
          stateOfStringWillSay: state.gameData.sentence ?? '');
    }, builder: (context, gameState) {
      return Container(
        margin: const EdgeInsets.only(top: 50),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        width: MediaQuery.of(context).size.width - (130),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border:
                Border.all(color: AppColorPhonetics.boarderColor, width: 5)),
        child: SizedBox(
          height: MediaQuery.of(context).size.height - 180,
          child: Center(
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      ((gameState.gameLetters?.length ?? 0) / 2).ceil(),
                  childAspectRatio: 2, // Adjust this value as needed
                  mainAxisSpacing: 10,
                  mainAxisExtent: 66,
                  crossAxisSpacing: 10),
              itemCount: (gameState.gameLetters?.length ?? 0),
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(
                      top: (index % 2 == 1) ? 10 : 0,
                      bottom: (index % 2 == 1) ? 0 : 10),
                  child: (gameState.answers
                              ?.contains(gameState.gameLetters?[index].id) ??
                          false)
                      ? CardMagic(
                          text: gameState.gameLetters?[index].letter ?? '',
                        )
                      : ((gameState.chooseSecondWord.id ==
                                  gameState.gameLetters?[index].id) ||
                              (gameState.chooseFirstWord.id ==
                                  gameState.gameLetters?[index].id))
                          ? CardMagic(
                              text: gameState.gameLetters?[index].letter ?? '',
                            )
                          : HideCard(
                              onTap: () async {
                                if (context
                                    .read<CurrentGamePhoneticsCubit>()
                                    .ableButton()) {
                                  bool? stateOfAnswer = context
                                      .read<MagicCardCubit>()
                                      .addAnswer(
                                          userChoose:
                                              gameState.gameLetters?[index]);
                                  print('stateOfAnswer:$stateOfAnswer');
                                  if (stateOfAnswer == true) {
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addSuccessAnswer(
                                            questions:
                                                gameState.gameLetters?.length ??
                                                    0,
                                            correctAnswers:
                                                gameState.answers?.length ?? 0)
                                        .whenComplete(() {
                                      bool isLastQuestion = context
                                          .read<CurrentGamePhoneticsCubit>()
                                          .checkIfIsTheLastQuestionOfGame(
                                              queations: gameState
                                                      .gameLetters?.length ??
                                                  0);
                                      context
                                          .read<MagicCardCubit>()
                                          .reStartCards();
                                    });
                                  } else if (stateOfAnswer == false) {
                                    await context
                                        .read<CurrentGamePhoneticsCubit>()
                                        .addWrongAnswer(
                                            actionOfWrongAnswer: () async {
                                      context
                                          .read<MagicCardCubit>()
                                          .reStartCards();
                                    });
                                  }
                                }
                              },
                            ),
                );
              },
            ),
          ),
        ),
        // Wrap(
        //   children:
        //       List.generate((gameState.gameLetters?.length ?? 0) ~/ 2, (index) {
        //     int x = index + 1;
        //     int y = index + 2;
        //     return Container(
        //       // margin: EdgeInsets.only(top: ),
        //       child: Column(
        //         children: [
        //           Text("${x}"),
        //           Text("${y}"),
        //           // HideCard(),
        //         ],
        //       ),
        //     );
        //   }),
        // ),
      );
    });
  }
}
