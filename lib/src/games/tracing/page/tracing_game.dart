import 'dart:developer';
import 'dart:math';

import 'package:based_of_eng_game/src/games/tracing/svg_strings/phonetics_paint_widget/phonetics_painter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/assets_images_phonetics.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/tracing_cubit.dart';

class TracingGame extends StatefulWidget {
  const TracingGame({super.key});

  @override
  State<StatefulWidget> createState() => _TracingGameState();
}

class _TracingGameState extends State<TracingGame> {
  late TracingCubit tracingCubit;
  Size viewSize = Size(200, 250);

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
          return CircularProgressIndicator();
        }

        // Size of the drawing area
        double baseSize = 200.0; // The base size of your view

        // Calculate the scale factor
        double letterCount = state.letterPathsModels.length.toDouble();
        double maxLetters = 3.0; // Maximum number of letters
        double scaleFactor = baseSize / (letterCount * (baseSize / maxLetters));
        final s =
            min(1.2, scaleFactor * (MediaQuery.sizeOf(context).width * .0005));
        return Transform.scale(
          scale: s,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Colors.red.withOpacity(.2),
                    // padding: REdgeInsets.only(bottom: 40),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(state.letterPathsModels.length,
                          (index) {
                        return GestureDetector(
                          onPanStart: (details) {
                            if (index == state.activeIndex) {
                              tracingCubit
                                  .handlePanStart(details.localPosition);
                              print(details.localPosition);
                              print('/// anchor');
                              print(state.letterPathsModels[index].anchorPos);
                            }
                          },
                          onPanUpdate: (details) {
                            // if (index == state.activeIndex) {
                            print(details.localPosition);
                            print('/// anchor');
                            print(state.letterPathsModels[index].anchorPos);
                            tracingCubit.handlePanUpdate(details.localPosition);
                            // }
                          },
                          onPanEnd: (details) {},
                          child: Stack(
                            children: [
                              CustomPaint(
                                size: viewSize,
                                painter: PhoneticsPainter(
                                    indexPath: state
                                        .letterPathsModels[index].letterIndex,
                                    dottedPath: state
                                        .letterPathsModels[index].dottedIndex,
                                    letterColor: state.letterPathsModels[index]
                                        .outerPaintColor,
                                    letterImage: state
                                        .letterPathsModels[index].letterImage!,
                                    paths: state.letterPathsModels[index].paths,
                                    currentDrawingPath: state
                                        .letterPathsModels[index]
                                        .currentDrawingPath,
                                    pathPoints: state.letterPathsModels[index]
                                        .allStrokePoints
                                        .expand((p) => p)
                                        .toList(),
                                    strokeColor: state.letterPathsModels[index]
                                        .innerPaintColor,
                                    anchorPos: state
                                        .letterPathsModels[index].anchorPos!,
                                    viewSize: state
                                        .letterPathsModels[index].viewSize!,
                                    strokePoints: state.letterPathsModels[index]
                                            .allStrokePoints[
                                        state.letterPathsModels[index]
                                            .currentStroke],
                                    strokeWidth: null,
                                    dottedColor: state
                                        .letterPathsModels[index].dottedColor,
                                    indexColor: state
                                        .letterPathsModels[index].indexColor),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  )
                ],
              ),
              Positioned(
                top: state.letterPathsModels[state.activeIndex].anchorPos!.dy,
                left:
                    (state.letterPathsModels[state.activeIndex].anchorPos!.dx +
                        200 * state.activeIndex),
                child: Image.asset(
                  AppImagesPhonetics.position2Finger,
                  height: 70.h,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
