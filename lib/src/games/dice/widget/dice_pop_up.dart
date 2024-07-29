import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../manager/dice_cubit.dart';
import 'dice_widget3.dart';

class DicePopUp extends StatelessWidget {
  const DicePopUp({super.key, required this.functionOfSaveWords});
  final void Function(String currentAlphabet) functionOfSaveWords;

  @override
  Widget build(BuildContext context) {
    final diceLetters = context.watch<DiceCubit>().state.letterDices;
    int countOfPlayed =
        context.select((DiceCubit value) => value.state.correctIndexes.length);

    return WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          content: Container(
            margin: EdgeInsets.only(left: (70.w), top: 50.h),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: DiceWidget3(
                diceLetters: diceLetters ?? [],
                countOfPlayed: countOfPlayed,
                functionOfSaveWords: functionOfSaveWords),
          ),
        ));
  }
}
