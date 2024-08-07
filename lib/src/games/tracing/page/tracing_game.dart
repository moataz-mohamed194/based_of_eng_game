import 'dart:developer';

import 'package:based_of_eng_game/src/games/tracing/svg_strings/phonetics_paint_widget/phonetics_painter.dart';
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
  late TracingCubit tracingCubit;
  late Size viewSize;
  @override
  void initState() {
    super.initState();
    tracingCubit = context.read<TracingCubit>();
    // tracingCubit.loadAssets(
    //     viewSize: Size(200, 200)); // Dummy size to trigger asset loading early
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: 3);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Trigger asset loading only if viewSize is not yet set
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (viewSize != null) {
        tracingCubit.loadAssets(viewSize: viewSize);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: (1) * (MediaQuery.sizeOf(context).width / 700),
      child: Container(
        // color: Colors.red.withOpacity(.2),
        height: 200,
        width: 200,
        child: LayoutBuilder(builder: (context, constraints) {
          viewSize = Size(constraints.maxWidth, constraints.maxHeight);

          return GestureDetector(
            onPanStart: (details) {
              tracingCubit.handlePanStart(details.localPosition);
            },
            onPanUpdate: (details) {
              tracingCubit.handlePanUpdate(details.localPosition);
            },
            onPanEnd: (details) {
            },
            child: AbsorbPointer(
              child: BlocConsumer<TracingCubit, TracingState>(
                listener: (context, state) async {
                  if (state.drawingStates == DrawingStates.gameFinished) {
                    await context
                        .read<CurrentGamePhoneticsCubit>()
                        .addSuccessAnswer(questions: 3, correctAnswers: 3)
                        .whenComplete(() async {
                      bool isLastQuestion = context
                          .read<CurrentGamePhoneticsCubit>()
                          .secondWayToCheckIfIsTheLastQuestionOfGame(
                              queations: 3);
                      if (!isLastQuestion) {
                        Future.delayed(const Duration(seconds: 2), () async {
                          Navigator.of(context).pop();
                        });
                      }
                    });
                  }
                },
                builder: (context, stateOfGame) {
                  print(stateOfGame.drawingStates.toString());
                  if (stateOfGame.drawingStates == DrawingStates.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (stateOfGame.drawingStates == DrawingStates.loaded) {
                    return Stack(
                      children: [
                        CustomPaint(
                          size: Size.infinite,
                          painter: PhoneticsPainter(
                            letterColor: Colors.blue.withOpacity(.4),
                            letterImage: stateOfGame.letterImage!,
                            paths: stateOfGame.paths,
                            currentDrawingPath: stateOfGame.currentDrawingPath,
                            pathPoints: stateOfGame.allStrokePoints
                                .expand((p) => p)
                                .toList(),
                            strokeColor: Colors.blue,
                            pointColor: Colors.black,
                            anchorPos: stateOfGame.anchorPos!,
                            viewSize: stateOfGame.viewSize!,
                            strokePoints: stateOfGame
                                .allStrokePoints[stateOfGame.currentStroke],
                            strokeWidth: null,
                          ),
                        ),
                        if (stateOfGame.anchorPos != null)
                          Positioned(
                            top: stateOfGame.anchorPos!.dy,
                            left: stateOfGame.anchorPos!.dx,
                            child: Image.asset(
                              AppImagesPhonetics.position2Finger,
                              height: 70.h,
                            ),
                          ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
