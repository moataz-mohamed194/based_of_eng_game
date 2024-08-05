import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            child: _buildGridViewOfMagicCards(gameState),
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

  Widget _buildGridViewOfMagicCards(MagicCardInitial gameState) {
    final gameLetters = gameState.gameLetters ?? [];
    final answers = gameState.answers ?? [];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: (gameLetters.length / 2).ceil(),
          childAspectRatio: 2, // Adjust this value as needed
          mainAxisSpacing: 10,
          mainAxisExtent: 66,
          crossAxisSpacing: 10),
      itemCount: (gameLetters.length),
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(
              top: (index % 2 == 1) ? 10 : 0,
              bottom: (index % 2 == 1) ? 0 : 10),
          child: (answers.contains(gameLetters[index].id))
              ? CardMagic(
                  text: gameLetters[index].letter ?? '',
                )
              : ((gameState.chooseSecondWord.id == gameLetters[index].id) ||
                      (gameState.chooseFirstWord.id == gameLetters[index].id))
                  ? CardMagic(
                      text: gameLetters[index].letter ?? '',
                    )
                  : HideCard(
                      onTap: () async {
                        if (context
                            .read<CurrentGamePhoneticsCubit>()
                            .ableButton()) {
                          bool? stateOfAnswer = context
                              .read<MagicCardCubit>()
                              .addAnswer(userChoose: gameLetters[index]);
                          print('stateOfAnswer:$stateOfAnswer');
                          if (stateOfAnswer == true) {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addSuccessAnswer(
                                    questions: gameLetters.length,
                                    correctAnswers: answers.length)
                                .whenComplete(() => context
                                    .read<MagicCardCubit>()
                                    .reStartCards());
                          } else if (stateOfAnswer == false) {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addWrongAnswer(actionOfWrongAnswer: () async {
                              context.read<MagicCardCubit>().reStartCards();
                            });
                          }
                        }
                      },
                    ),
        );
      },
    );
  }
}
