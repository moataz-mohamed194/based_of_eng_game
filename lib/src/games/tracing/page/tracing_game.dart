import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/assets_images_phonetics.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/tracing_cubit.dart';

class TracingGame extends StatefulWidget {
  const TracingGame({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TracingGame();
  }
}

class _TracingGame extends State<TracingGame> {
  @override
  void initState() {
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: 3);

    // context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
    //     stateOfStringIsWord: StateOfSubWord.isLetter,
    //     stateOfStringWillSay: gameData.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      height: MediaQuery.of(context).size.height - (70.h),
      alignment: Alignment.center,
      child: BlocConsumer<TracingCubit, TracingInitial>(
          listener: (context, state) {},
          builder: (context, stateOfGame) {
            return Stack(
              children: [
                if (stateOfGame.stateOfGame.basicData!.tracingOfLetter !=
                    null) ...{
                  GestureDetector(
                      onPanDown: (details) {
                        final renderBox =
                            context.findRenderObject() as RenderBox;
                        final localPosition =
                            renderBox.globalToLocal(details.globalPosition);
                        context.read<TracingCubit>().saveCurrentPosition(
                              position: localPosition,
                              point: localPosition,
                              size: Size(MediaQuery.of(context).size.width / 3,
                                  MediaQuery.of(context).size.height - (70.h)),
                            );

                        context.read<TracingCubit>().checkTheLocationOfPoint(
                              point: localPosition,
                              size: Size(MediaQuery.of(context).size.width / 3,
                                  MediaQuery.of(context).size.height - (70.h)),
                            );
                      },
                      onPanUpdate: (details) {
                        final renderBox =
                            context.findRenderObject() as RenderBox;
                        final localPosition =
                            renderBox.globalToLocal(details.globalPosition);

                        context.read<TracingCubit>().saveCurrentPosition(
                              position: localPosition,
                              point: localPosition,
                              size: Size(MediaQuery.of(context).size.width / 3,
                                  MediaQuery.of(context).size.height - (70.h)),
                            );
                        context.read<TracingCubit>().checkTheLocationOfPoint(
                              point: localPosition,
                              size: Size(MediaQuery.of(context).size.width / 3,
                                  MediaQuery.of(context).size.height - (70.h)),
                            );
                      },
                      onPanEnd: (details) async {
                        if (stateOfGame.colorsOfPaths
                            .where((element) => element == null)
                            .isEmpty) {
                          await context
                              .read<CurrentGamePhoneticsCubit>()
                              .addSuccessAnswer(questions: 3, correctAnswers: 3)
                              .whenComplete(() async {
                            bool isLastQuestion = context
                                .read<CurrentGamePhoneticsCubit>()
                                .secondWayToCheckIfIsTheLastQuestionOfGame(
                                    queations: 3);
                            print('isLastQuestion:$isLastQuestion');
                            if (isLastQuestion) {
                              // Future.delayed(const Duration(seconds: 2),
                              //     () async {
                              //   Navigator.of(context).pop();
                              // });
                            } else {}
                          });
                        }
                      },
                      child: CustomPaint(
                          size: Size(MediaQuery.of(context).size.width / 3,
                              MediaQuery.of(context).size.height - (70.h)),
                          painter: stateOfGame
                                  .stateOfGame.basicData!.tracingOfLetter!(
                              stateOfGame.colorsOfPaths, stateOfGame.paths))),
                },
                if (stateOfGame.currentPosition != null) ...{
                  Positioned(
                      top: stateOfGame.currentPosition?.dy,
                      left: stateOfGame.currentPosition?.dx,
                      child: Image.asset(
                        AppImagesPhonetics.position2Finger,
                        height: 70.h,
                        // width: 50.w,
                      ))
                }
              ],
            );
          }),
    );
  }
}
