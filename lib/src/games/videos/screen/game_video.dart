import 'package:based_of_eng_game/src/games/videos/cubit/video_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../src_model/export_models.dart';
import 'package:video_player/video_player.dart';

import '../../../core/assets_images_phonetics.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';

class GameVideo extends StatefulWidget {
  const GameVideo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _GameVideo();
  }
}

class _GameVideo extends State<GameVideo> {
  late VideoPlayerController _controller;
  GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  int currentStateOfGame = 0;
  double currentStateOfGameSec = 0;
  double currentStateOfGameSec1 = 0;
  @override
  void initState() {
    super.initState();
    final GameFinalModel gameData = context.read<VideoCubit>().state.gameData;

    try {
      _controller =
          VideoPlayerController.networkUrl(Uri.parse(gameData.video ?? ''))
            ..initialize().then((_) {
              _controller.play();
              setState(() {});
              context
                  .read<CurrentGamePhoneticsCubit>()
                  .getStateOfStars(mainCountOfQuestion: 3);

              Duration countOfSuc = _controller.value.duration;
              currentStateOfGameSec = countOfSuc.inSeconds / 3;
              setState(() {});
              _controller.addListener(() {
                if ((_controller.value.position.inSeconds) >=
                    (currentStateOfGameSec * (currentStateOfGame + 1))) {
                  setState(() {
                    currentStateOfGame = currentStateOfGame + 1;
                  });
                }
                if ((context
                            .read<CurrentGamePhoneticsCubit>()
                            .state
                            .countOfStar ??
                        0) <
                    currentStateOfGame) {
                  debugPrint('currentStateOfGame:$currentStateOfGame');
                  context.read<CurrentGamePhoneticsCubit>().addStarToStudent(
                        stateOfCountOfCorrectAnswer: currentStateOfGame,
                      );
                }
                if (currentStateOfGame == 3) {
                  // if (context
                  //         .read<CurrentGamePhoneticsCubit>()
                  //         .state
                  //         .actionWhenTriesBeZero !=
                  //     null) {
                  context
                      .read<CurrentGamePhoneticsCubit>()
                      .state
                      .actionWhenTriesBeZero(currentStateOfGame);
                  Future.delayed(const Duration(seconds: 2), () async {
                    Navigator.of(context).pop();
                  });
                  // }
                  //   context.read<JourneyBarCubit>().sendStars(
                  //       gamesId: [widget.currentDataGame.id ?? 0],
                  //       countOfStar: currentStateOfGame);
                  //   Navigator.of(context).pop();
                }
              });
            });
    } catch (e) {
      debugPrint('error:$e');
    }
  }

  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.paused) {
      await _controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      await _controller.dispose();
    } else {
      debugPrint('state:$state');
    }
  }

  @override
  void deactivate() {
    _controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        onPopInvoked: (x) async {
          await _controller.dispose();
        },
        canPop: true,
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImagesPhonetics.loadingVideo),
                        fit: BoxFit.fill)),
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(
                    _controller,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
