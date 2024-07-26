import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../based_of_eng_game.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../widgets/final_matching_path.dart';
import '../manager/match_cubit.dart';

class ArabicMatch extends StatefulWidget {
  const ArabicMatch({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ArabicMatch();
  }
}

class _ArabicMatch extends State<ArabicMatch> {
  @override
  void initState() {
    final GameFinalModel gameData = context.read<MatchCubit>().state.gameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.gameImages?.length ?? 0);
    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.isLetter,
        stateOfStringWillSay: gameData.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isInteracting =
        context.watch<CurrentGamePhoneticsCubit>().state.stateOfAvatar;

    return BlocConsumer<MatchCubit, MatchInitial>(
      listener: (context, state) {},
      builder: (context, gameState) {
        return Container(
          margin: EdgeInsets.only(right: 50.w, bottom: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
          width: 250.w,
          height: 290.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border:
                  Border.all(color: AppColorPhonetics.boarderColor, width: 5)),
          child: Stack(
            children: [
              CustomPaint(
                size: Size.infinite,
                painter: FinalMatchingPainter(gameState.positions),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLetters(gameState, context),
                    _buildImages(gameState, isInteracting, context),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImages(
      MatchInitial gameState, String? isInteracting, BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
            gameState.imageAnswers.length,
            (index) => Column(
                  children: [
                    _buildCircle(circleColor: AppColorPhonetics.lightPurple),
                    20.ph,
                    _buildImage(gameState, index, context),
                  ],
                )),
      ),
    );
  }

  Widget _buildImage(MatchInitial gameState, int index, BuildContext context) {
    return CachedNetworkImage(
      imageUrl: gameState.imageAnswers[index].image ?? '',
      height: (MediaQuery.of(context).size.height) / 5,
      width: 50.w,
      placeholder: (context, url) => const Center(
        child: CupertinoActivityIndicator(),
      ),
      errorWidget: (context, url, error) => const Icon(
        Icons.error,
        color: Colors.red,
      ),
    );
  }

  Widget _buildLetters(MatchInitial gameState, BuildContext context) {
    return Flexible(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
            gameState.answers.length,
            (index) => Container(
                  height: 120.h,
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      _buildLetter(context, gameState, index),
                      10.ph,
                      _buildCircle(circleColor: AppColorPhonetics.lightBlue)
                    ],
                  ),
                )),
      ),
    );
  }

  Widget _buildCircle({required Color circleColor}) {
    return Container(
      height: 17,
      width: 17,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17), color: circleColor),
    );
  }

  Widget _buildLetter(BuildContext context, MatchInitial gameState, int index) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 10.w, vertical: 0.h), //EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        border:
            Border.all(color: AppColorPhonetics.darkBorderColor, width: 2.w),
      ),
      child: FittedBox(
        child: Text(
          gameState.answers[index].letter ?? '',
          style: TextStyle(
              fontSize: 16.sp,
              fontFamily: AppTheme.getFontFamily5(),
              color: AppColorPhonetics.darkBorderColor),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
