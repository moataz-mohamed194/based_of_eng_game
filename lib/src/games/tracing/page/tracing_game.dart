import 'dart:math';
import 'package:based_of_eng_game/src/core/assets_images_phonetics.dart';
import 'package:based_of_eng_game/src/games/tracing/svg_strings/phonetics_paint_widget/phonetics_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/tracing_cubit.dart';

class TracingGame extends StatefulWidget {
  const TracingGame({super.key});

  @override
  State<StatefulWidget> createState() => _TracingGameState();
}

class _TracingGameState extends State<TracingGame> {
  late TracingCubit tracingCubit;
  Size viewSize = Size(200, 200);

  @override
  void initState() {
    super.initState();
    tracingCubit = context.read<TracingCubit>();
    tracingCubit.loadAssets(viewSize);
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: 3);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TracingCubit, TracingState>(
      listener: (context, stateOfGame) async {
        if (stateOfGame.drawingStates == DrawingStates.gameFinished) {
          await Future.delayed(Duration(seconds: 3));
          await context
              .read<CurrentGamePhoneticsCubit>()
              .addSuccessAnswer(
                questions: 3,
                correctAnswers: 3,
                subAction: () {},
              )
              .whenComplete(() async {
            bool isLastQuestion = context
                .read<CurrentGamePhoneticsCubit>()
                .secondWayToCheckIfIsTheLastQuestionOfGame(queations: 3);
            if (!isLastQuestion) {
              Future.delayed(const Duration(seconds: 2), () {
                Navigator.of(context).pop();
              });
            }
          });
        }
      },
      builder: (context, state) {
        if (state.drawingStates == DrawingStates.loading ||
            state.drawingStates == DrawingStates.initial) {
          return Center(child: CircularProgressIndicator());
        }
        final s = state.letterPathsModels.length == 1
            ? MediaQuery.sizeOf(context).width * .0017
            : state.letterPathsModels.length == 2
                ? MediaQuery.sizeOf(context).width * .0013
                : MediaQuery.sizeOf(context).width * .0007;
        return Column(
          children: [
            Transform(
              transform: Matrix4.identity()..scale(s),
              child: Container(
                // color: ,
                height: viewSize.height * s,
                width: viewSize.width * (state.letterPathsModels.length) + 50.w,
                margin: REdgeInsets.only(right: 80),
                // margin: EdgeInsets.only(bottom: 30),
                child: Container(
                  // color: Colors.amber,
                  child: Center(
                    child: Column(
                      children: [
                        // SizedBox(height: 100.h),
                        Container(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                              state.letterPathsModels.length,
                              (index) {
                                return GestureDetector(
                                  onPanStart: (details) {
                                    print('wwww');
                                    if (index == state.activeIndex) {
                                      tracingCubit.handlePanStart(
                                          details.localPosition);
                                    }
                                  },
                                  onPanUpdate: (details) {
                                    print('636363');

                                    if (index == state.activeIndex) {
                                      tracingCubit.handlePanUpdate(
                                          details.localPosition);
                                    }
                                  },
                                  onPanEnd: (details) {},
                                  child: Container(
                                    // height: 1000,

                                    // color: Colors.red,
                                    child: AbsorbPointer(
                                      child: Stack(
                                        children: [
                                          CustomPaint(
                                            size: Size(
                                                state.letterPathsModels[index]
                                                        .viewSize.width +
                                                    20.w,
                                                state.letterPathsModels[index]
                                                    .viewSize.height),
                                            painter: PhoneticsPainter(
                                              indexPath: state
                                                  .letterPathsModels[index]
                                                  .letterIndex,
                                              dottedPath: state
                                                  .letterPathsModels[index]
                                                  .dottedIndex,
                                              letterColor: state
                                                  .letterPathsModels[index]
                                                  .outerPaintColor,
                                              letterImage: state
                                                  .letterPathsModels[index]
                                                  .letterImage!,
                                              paths: state
                                                  .letterPathsModels[index]
                                                  .paths,
                                              currentDrawingPath: state
                                                  .letterPathsModels[index]
                                                  .currentDrawingPath,
                                              pathPoints: state
                                                  .letterPathsModels[index]
                                                  .allStrokePoints
                                                  .expand((p) => p)
                                                  .toList(),
                                              strokeColor: state
                                                  .letterPathsModels[index]
                                                  .innerPaintColor,
                                              viewSize: state
                                                  .letterPathsModels[index]
                                                  .viewSize!,
                                              strokePoints: state
                                                      .letterPathsModels[index]
                                                      .allStrokePoints[
                                                  state.letterPathsModels[index]
                                                      .currentStroke],
                                              strokeWidth: state
                                                  .letterPathsModels[index]
                                                  .strokeWidth,
                                              dottedColor: state
                                                  .letterPathsModels[index]
                                                  .dottedColor,
                                              indexColor: state
                                                  .letterPathsModels[index]
                                                  .indexColor,
                                              indexPathPaintStyle: state
                                                  .letterPathsModels[index]
                                                  .indexPathPaintStyle,
                                              dottedPathPaintStyle: state
                                                  .letterPathsModels[index]
                                                  .dottedPathPaintStyle,
                                            ),
                                          ),
                                          if (state.activeIndex == index)
                                            Positioned(
                                              top: state
                                                  .letterPathsModels[
                                                      state.activeIndex]
                                                  .anchorPos!
                                                  .dy,
                                              left: state
                                                  .letterPathsModels[
                                                      state.activeIndex]
                                                  .anchorPos!
                                                  .dx,
                                              child: Image.asset(
                                                AppImagesPhonetics
                                                    .position2Finger,
                                                height: 60.h,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            )
          ],
        );
      },
    );
  }
}
