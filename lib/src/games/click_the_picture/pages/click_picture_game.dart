import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/assets_images_phonetics.dart';
import '../../../core/games_structure/basic_of_game_data.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/click_picture_cubit.dart';
import '../widgets/single_row.dart';

class ClickPictureGame extends StatefulWidget {
  const ClickPictureGame({super.key});
  @override
  State<StatefulWidget> createState() {
    return _ClickPictureGame();
  }
}

class _ClickPictureGame extends State<ClickPictureGame> {
  @override
  void initState() {
    final GameFinalModel gameData =
        context.read<ClickPictureCubit>().state.gameData;
    context.read<CurrentGamePhoneticsCubit>().getStateOfStars(
        mainCountOfQuestion: gameData.gameImages
                ?.where((element) => element.correct == 1)
                .toList()
                .length ??
            0);

    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.isLetter,
        stateOfStringWillSay: gameData.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isInteracting =
        context.watch<CurrentGamePhoneticsCubit>().state.stateOfAvatar;

    return BlocConsumer<ClickPictureCubit, ClickPictureInitial>(
        listener: (context, state) {},
        builder: (context, stateOfGameData) {
          return Container(
            alignment: Alignment.center,
            child: Container(
              width: MediaQuery.of(context).size.width - 100.w,
              height: MediaQuery.of(context).size.width < 760
                  ? MediaQuery.of(context).size.height * 0.7
                  : MediaQuery.of(context).size.height * 0.65,
              margin: EdgeInsets.only(
                  bottom: (30),
                  top: 10,
                  left: stateOfGameData.isArabic == true ? 0 : 20,
                  right: stateOfGameData.isArabic == true ? 20 : 0),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              // width: MediaQuery.of(context).size.width - (130 + 50),
              // height: MediaQuery.of(context).size.height - (50.h + 55),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: AppColorPhonetics.boarderColor, width: 5)),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Wrap(
                    spacing: 15,
                    alignment: WrapAlignment.center,
                    children: List.generate(
                        stateOfGameData.gameData.gameImages?.length ?? 0,
                        (index) => FittedBox(
                              child: SingleElement(
                                index: index,
                                background: stateOfGameData.backGround[index],
                                image: stateOfGameData
                                        .gameData.gameImages?[index].image ??
                                    '',
                                selected: context
                                    .read<ClickPictureCubit>()
                                    .state
                                    .correctIndexes
                                    .contains(index),
                                width: (MediaQuery.of(context).size.width -
                                        110.w) /
                                    (((stateOfGameData.gameImages?.length ??
                                                    0) /
                                                2) +
                                            1)
                                        .round(),
                                height: ((MediaQuery.of(context).size.width <
                                            760
                                        ? MediaQuery.of(context).size.height *
                                            0.7
                                        : MediaQuery.of(context).size.height *
                                            0.65)) /
                                    2.5,
                                onTap: () async {
                                  if (context
                                      .read<CurrentGamePhoneticsCubit>()
                                      .ableButton()) {
                                    if (!stateOfGameData.correctIndexes
                                        .contains(index)) {
                                      if (stateOfGameData.gameData
                                              .gameImages?[index].correct ==
                                          1) {
                                        context
                                            .read<ClickPictureCubit>()
                                            .addAnswer(index);
                                        await context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .addSuccessAnswer(
                                                // supportTheFirstWayOfCheckComplete:true,

                                                questions: stateOfGameData
                                                        .gameImages
                                                        ?.where((element) =>
                                                            element.correct ==
                                                            1)
                                                        .length ??
                                                    0,
                                                correctAnswers: stateOfGameData
                                                    .correctIndexes.length)
                                            .whenComplete(() {
                                          bool isLastQuestion = context
                                              .read<CurrentGamePhoneticsCubit>()
                                              .secondWayToCheckIfIsTheLastQuestionOfGame(
                                                  queations: stateOfGameData
                                                          .gameImages
                                                          ?.where((element) =>
                                                              element.correct ==
                                                              1)
                                                          .length ??
                                                      0);
                                          print(
                                              'isLastQuestion:$isLastQuestion');
                                          if (isLastQuestion) {
                                            // Future.delayed(
                                            //     const Duration(seconds: 2),
                                            //     () async {
                                            //   Navigator.of(context).pop();
                                            // });
                                          }
                                        });
                                      } else {
                                        await context
                                            .read<CurrentGamePhoneticsCubit>()
                                            .addWrongAnswer(
                                                actionOfWrongAnswer: () async {
                                          await context
                                              .read<ClickPictureCubit>()
                                              .sayTheLetter();
                                        });
                                      }
                                    }
                                  }
                                },
                                word: stateOfGameData
                                        .gameData.gameImages?[index].word ??
                                    '',
                              ),
                            )),
                  ),
                  Positioned(
                      bottom: MediaQuery.of(context).size.height * 0.4,
                      right: MediaQuery.of(context).size.height < 760
                          ? (-80).h
                          : (-150).h,
                      child: Container(
                          alignment:Alignment.center,
                          // height: .2.sh,
                          // width: 100.w,
                          padding: EdgeInsets.all(.1.sh),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      AppImagesPhonetics.letterOfClickPic))),
                          child: Text(
                            stateOfGameData.gameData.mainLetter ?? '',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                                    fontSize: 25.spMax,
                                    fontWeight: FontWeight.w700,
                                    color: AppColorPhonetics.darkBorderColor,
                                    fontFamily: AppTheme.getFontFamily5()),
                            textAlign: TextAlign.center,
                          )))
                ],
              ),
            ),
          );
        });
  }
}
