import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:based_of_eng_game/src/core/games_structure/basic_of_chapter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../based_of_eng_game.dart';
import '../core/assets_game_sound.dart';
import '../core/assets_images_phonetics.dart';
import '../core/audio_player_game.dart';
import '../core/audio_player_letters.dart';
import '../core/talk_tts.dart';
import '../widgets/widget_of_tries.dart';

part 'current_game_phonetics_state.dart';

class CurrentGamePhoneticsCubit extends Cubit<CurrentGamePhoneticsState> {
  CurrentGamePhoneticsCubit(
      {required MainDataOfChapters basicData,
      required void Function(int) actionOfCompleteGame,
      required void Function() backButton,
      required BuildContext context,
      required List<GameFinalModel> gameData})
      : super(CurrentGamePhoneticsState(
            index: 0,
            backButton: backButton,
            actionWhenTriesBeZero: actionOfCompleteGame,
            context: context)) {
    _checkDataOfCubit();
    updateDataOfCurrentGame(
        basicData: basicData,
        gameData: gameData,
        gameIndex: 0,
        hideLoading: true);
    _getTheBackGround();
    _getTheBackGroundSuccess();
    _getTheBackGroundSad();
  }
  _checkDataOfCubit() {
    if (state.index > (state.gameData?.length ?? 0)) {
      return Exception("check the game data");
    }
  }

  bool ableButton() {
    print(
        'state.stateOfAvatar:${((state.stateOfAvatar == BasicOfGameData.stateOIdle) || (state.stateOfAvatar == null))}');
    // log('state.stateOfAvatar:${state.stateOfAvatar}');
    print('state.stateOfAvatar:${(AudioPlayerLetters.player.state)}');
    print('state.stateOfAvatar:${(TalkTts.data)}');
    return ((state.stateOfAvatar == BasicOfGameData.stateOIdle) ||
            (state.stateOfAvatar == null)) &&
        (AudioPlayerLetters.player.state != PlayerState.playing) &&
        (TalkTts.data == StateOfTalk.stopped);
  }

  _getTheBackGround() {
    rootBundle.load(AppImagesPhonetics.beeIdleRiv).then(
      (data) async {
        try {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          var controller =
              StateMachineController.fromArtboard(artboard, 'State Machine 1');

          if (controller != null) {
            artboard.addController(controller);
          }
          emit(state.copyWith(avatarArtboardIdle: artboard));
          emit(state.copyWith(avatarCurrentArtboard: state.avatarArtboardIdle));
        } catch (e) {
          log(e.toString());
        }
      },
    );
  }

  _getTheBackGroundSuccess() {
    rootBundle.load(AppImagesPhonetics.beeSuccess).then(
      (data) async {
        try {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          var controller =
              StateMachineController.fromArtboard(artboard, 'State Machine 1');

          if (controller != null) {
            artboard.addController(controller);
          }
          emit(state.copyWith(avatarArtboardSuccess: artboard));
        } catch (e) {
          log(e.toString());
        }
      },
    );
  }

  _getTheBackGroundSad() {
    rootBundle.load(AppImagesPhonetics.beeFailureRiv).then(
      (data) async {
        try {
          final file = RiveFile.import(data);
          final artboard = file.mainArtboard;
          var controller =
              StateMachineController.fromArtboard(artboard, 'State Machine 1');

          if (controller != null) {
            artboard.addController(controller);
          }
          emit(state.copyWith(avatarArtboardSad: artboard));
        } catch (e) {
          log(e.toString());
        }
      },
    );
  }

  saveTheStringWillSay(
      {required StateOfSubWord stateOfStringIsWord,
      required String stateOfStringWillSay}) {
    emit(state.copyWith(
        stateOfStringIsWord: stateOfStringIsWord,
        stateOfStringWillSay: stateOfStringWillSay));
  }

  updateIndexOfCurrentGame() async {
    int currentIndex = state.index;
    currentIndex = currentIndex + 1;
    emit(state.copyWith(index: currentIndex));
  }

  updateDataOfCurrentGame(
      {required MainDataOfChapters basicData,
      required List<GameFinalModel> gameData,
      required int gameIndex,
      bool? hideLoading}) async {
    emit(state.clearAllData());
    if (hideLoading != true) {
      await Future.delayed(Duration(milliseconds: 100));
    }
    emit(state.copyWith(
        basicData: basicData,
        // currentAvatar: basicData.basicAvatar,
        index: 0,
        gameData: gameData));
    _getTheBackGround();
    _getTheBackGroundSuccess();
    _getTheBackGroundSad();
    _saveCountOfTries();
  }

  _saveCountOfTries() {
    int countOfTries = state.gameData?[state.index].numOfTrials ?? 0;
    emit(state.copyWith(countOfTries: countOfTries, countOfStar: 0));
  }

  decreaseCountOfTries() {
    int countOfTries = (state.countOfTries ?? 1) - 1;
    emit(state.copyWith(countOfTries: countOfTries));
    debugPrint(
        'state.countOfTries:${state.countOfTries}, stars:${state.countOfStar}');
    if (state.countOfTries == 0) {
      BuildContext context = state.context;
      emit(state.copyWith(countOfStar: 0, showAlert:true));
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (alertContext) => WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
                backgroundColor: Colors.transparent,
                elevation: 0,
                content: widgetOfTries(
                  context: context,
                  stateOfGame: state,
                  actionOfRetry: () {
                    updateDataOfCurrentGame(
                        basicData: state.basicData!,
                        gameData: state.gameData!,
                        gameIndex: 0);
                    Navigator.of(context).pop();
                  },
                  backButton: () {
                    state.backButton();
                  },
                  countOfStar: 0,
                ))),
      );
      state.actionWhenTriesBeZero(state.countOfStar ?? 0);
    }
  }

  bool checkIfIsTheLastQuestionOfGame(
      {required int queations, bool? showAlert}) {
    int countOfCorrectAnswers = state.index + 1;
    print('countOfCorrectAnswers:$countOfCorrectAnswers , $queations');
    if (queations <= countOfCorrectAnswers) {
      if (showAlert == true) {
        _popUpOfGame();
      }
      return true;
    } else {
      return false;
    }
  }

  bool secondWayToCheckIfIsTheLastQuestionOfGame(
      {required int queations, bool? showAlert}) {
    int countOfCorrectAnswers = state.countOfCorrectAnswers;
    print(
        'secondWayToCheckIfIsTheLastQuestionOfGame:$countOfCorrectAnswers , $queations');

    if (queations <= countOfCorrectAnswers) {
      if (showAlert == true) {
        _popUpOfGame();
      }
      return true;
    } else {
      return false;
    }
  }

  _popUpOfGame() {
    print('_popUpOfGame:{state.theAlertOfShowDialog}');
    state.actionWhenTriesBeZero(state.countOfStar ?? 0);
    // if (state.theAlertOfShowDialog == false) {
    emit(state.copyWith(showAlert:true));

    BuildContext context = state.context;
    // emit(state.copyWith(theAlertOfShowDialog: true));
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (alertContext) => WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              elevation: 0,
              content: widgetOfTries(
                context: context,
                countOfStar: state.countOfStar ?? 0,
                stateOfGame: state,
                actionOfRetry: () {
                  // emit(state.copyWith(theAlertOfShowDialog: false));

                  updateDataOfCurrentGame(
                      basicData: state.basicData!,
                      gameData: state.gameData!,
                      gameIndex: 0);
                  Navigator.of(context).pop();
                },
                actionOfDone: () {
                  state.backButton();
                },
                backButton: () {
                  state.backButton();
                },
              ))),
    );
    // }
  }

  getStateOfStars({required int mainCountOfQuestion}) {
    print('getStateOfStars:$mainCountOfQuestion');
    List<int> stateOfStarsAdd =
        HandlingActionsAndDataOfChapters.getTheStarsAddState(
            mainCountOfQuestion);
    emit(state.copyWith(statesOfAddStars: stateOfStarsAdd));
  }

  addStarToStudent({required int stateOfCountOfCorrectAnswer}) {
    List<int> stateOfStarsAdd = state.statesOfAddStars ?? [];
    print('stateOfStarsAdd:$stateOfStarsAdd');
    int mainCountOfQuestion = stateOfStarsAdd.fold(
        0, (previousValue, element) => previousValue + element);
    emit(state.copyWith(countOfCorrectAnswers: stateOfCountOfCorrectAnswer));
    debugPrint(
        'stateOfCountOfCorrectAnswer:$stateOfCountOfCorrectAnswer, $stateOfStarsAdd');
    if ((mainCountOfQuestion) > 2) {
      if (stateOfStarsAdd[0] <= stateOfCountOfCorrectAnswer) {
        emit(state.copyWith(countOfStar: 1));
      } else {
        emit(state.copyWith(countOfStar: (0)));
      }
      if ((stateOfStarsAdd[1] + stateOfStarsAdd[0]) <=
          stateOfCountOfCorrectAnswer) {
        emit(state.copyWith(countOfStar: 2));
      }
      if ((stateOfStarsAdd[2] + stateOfStarsAdd[0] + stateOfStarsAdd[1]) <=
          stateOfCountOfCorrectAnswer) {
        emit(state.copyWith(countOfStar: 3));
      }
    } else {
      if (mainCountOfQuestion == 1) {
        emit(state.copyWith(countOfStar: 3));
      } else if (mainCountOfQuestion == 2) {
        if (stateOfCountOfCorrectAnswer == 1) {
          emit(state.copyWith(countOfStar: 1));
        } else if (stateOfCountOfCorrectAnswer == 2) {
          emit(state.copyWith(countOfStar: 3));
        }
      }
    }
    checkTheStateOfStar();
  }

  checkTheStateOfStar() {
    int stateOfGameStar = state.basicData?.gameData?.countOfMinimizeStar ?? 0;
    int countOfStar = state.countOfStar ?? 0;
    int countOfWrongAnswers = state.countOfWrongAnswers;
    debugPrint('stateOfGameStar:$stateOfGameStar');
    debugPrint('countOfStar:$countOfStar');
    debugPrint('countOfWrongAnswers:$countOfWrongAnswers');
    debugPrint('countOfWrongAnswers:${countOfWrongAnswers % 2}');
    if (stateOfGameStar == 1) {
      if (countOfStar > 0) {
        countOfStar = countOfStar - countOfWrongAnswers;
        if (countOfStar < 0) {
          emit(state.copyWith(countOfStar: 0));
        } else {
          emit(state.copyWith(countOfStar: countOfStar));
        }
      }
    } else if (stateOfGameStar == 2) {
      if (countOfStar > 0) {
        if (countOfWrongAnswers == 1 || countOfWrongAnswers == 2) {
          countOfStar = countOfStar - 1;
          if (countOfStar < 0) {
            emit(state.copyWith(countOfStar: 0));
          } else {
            emit(state.copyWith(countOfStar: countOfStar));
          }
        } else if (countOfWrongAnswers == 3 || countOfWrongAnswers == 4) {
          countOfStar = countOfStar - 2;
          if (countOfStar < 0) {
            emit(state.copyWith(countOfStar: 0));
          } else {
            emit(state.copyWith(countOfStar: countOfStar));
          }
        }
      }
    }
  }

  increaseDirectlyCountOfStar() {
    int countOfStar = state.countOfStar ?? 0;
    emit(state.copyWith(countOfStar: (countOfStar + 1)));
  }

  Future addSuccessAnswer(
      {required int correctAnswers,
      required int questions,
      String? specificSoundPath,
      bool? supportTheFirstWayOfCheckComplete,
      void Function()? subAction,
      bool? isArabic}) async {
    print('addSuccessAnswer');
    AudioPlayer playerCorrect = AudioPlayer();
    print('correctAnswers:$correctAnswers');
    await _animationOfCorrectAnswer();
    await AudioPlayerGame.startPlaySoundOfCorrect(
        playerCorrect2: playerCorrect,
        soundPath: specificSoundPath ??
            AppGameSound.getRandomSoundOfCorrect(isArabic: isArabic));
    await addStarToStudent(stateOfCountOfCorrectAnswer: correctAnswers);
    bool isLastLesson = supportTheFirstWayOfCheckComplete ?? false;
    if (supportTheFirstWayOfCheckComplete == true) {
      isLastLesson =
          checkIfIsTheLastQuestionOfGame(queations: questions, showAlert: true);
    } else {
      isLastLesson = secondWayToCheckIfIsTheLastQuestionOfGame(
          queations: questions, showAlert: true);
    }
    if (isLastLesson == true) {
      await Future.delayed(const Duration(seconds: 2));
      state.actionWhenTriesBeZero(state.countOfStar ?? 0);
    } else {
      playerCorrect.onPlayerComplete.listen((event) {
        debugPrint('################');
        backToMainAvatar();
        if (subAction != null) {
          subAction();
        }
      });
    }
  }

  Future<void> addWrongAnswer(
      {void Function()? actionOfWrongAnswer, bool? isArabic}) async {
    AudioPlayer playerWrong = AudioPlayer();

    await _animationOfWrongAnswer();
    await _increaseCountOfWrongAnswer();

    await AudioPlayerGame.startPlaySoundOfWrong(
        playerWrong2: playerWrong,
        soundPath: AppGameSound.getRandomSoundOfWrong(isArabic: isArabic));
    if (actionOfWrongAnswer != null) {
      playerWrong.onPlayerComplete.listen((event) {
        actionOfWrongAnswer.call();
      });
    }
    playerWrong.onPlayerComplete.listen((event) {
      backToMainAvatar();
    });
  }

  _increaseCountOfWrongAnswer() {
    int countOfWrongAnswers = state.countOfWrongAnswers;
    countOfWrongAnswers++;
    // countOfCorrectAnswers = countOfCorrectAnswers-countOfWrongAnswers;

    emit(state.copyWith(countOfWrongAnswers: countOfWrongAnswers));
    _checkTheStateOfStarForWrong();
  }

  _checkTheStateOfStarForWrong() {
    int stateOfGameStar = state.basicData?.gameData?.countOfMinimizeStar ?? 0;
    int countOfStar = state.countOfStar ?? 0;
    int countOfWrongAnswers = state.countOfWrongAnswers;
    List<int> stateOfStarsAdd = state.statesOfAddStars ?? [];

    if (stateOfGameStar == 1) {
      if (countOfStar > 0) {
        countOfStar = countOfStar - 1;
        emit(state.copyWith(countOfStar: countOfStar < 0 ? 0 : countOfStar));
      }
    } else if (stateOfGameStar == 2) {
      if (countOfStar > 0) {
        // int mainCountOfStar = _mainCountOfStar();
        if (countOfWrongAnswers == 1) {
          countOfStar = countOfStar - 1;
          emit(state.copyWith(countOfStar: countOfStar < 0 ? 0 : countOfStar));
        } else if (countOfWrongAnswers == 3) {
          countOfStar = countOfStar - 1;
          emit(state.copyWith(countOfStar: countOfStar < 0 ? 0 : countOfStar));
        }
      }
    }
  }

  // int _mainCountOfStar(){
  //   List<int> stateOfStarsAdd = state.statesOfAddStars ?? [];
  //   int countOfCorrectAnswers = state.countOfCorrectAnswers;
  //
  //   if ((mainCountOfQuestion) > 2) {
  //     if (stateOfStarsAdd[0] <= stateOfCountOfCorrectAnswer) {
  //       emit(state.copyWith(countOfStar: 1));
  //     } else {
  //       emit(state.copyWith(countOfStar: (0)));
  //     }
  //     if ((stateOfStarsAdd[1] + stateOfStarsAdd[0]) <=
  //         stateOfCountOfCorrectAnswer) {
  //       emit(state.copyWith(countOfStar: 2));
  //     }
  //     if ((stateOfStarsAdd[2] + stateOfStarsAdd[0] + stateOfStarsAdd[1]) <=
  //         stateOfCountOfCorrectAnswer) {
  //       emit(state.copyWith(countOfStar: 3));
  //     }
  //   } else {
  //     if (mainCountOfQuestion == 1) {
  //       emit(state.copyWith(countOfStar: 3));
  //     } else if (mainCountOfQuestion == 2) {
  //       if (stateOfCountOfCorrectAnswer == 1) {
  //         emit(state.copyWith(countOfStar: 1));
  //       } else if (stateOfCountOfCorrectAnswer == 2) {
  //         emit(state.copyWith(countOfStar: 3));
  //       }
  //     }
  //   }
  // }
  _animationOfWrongAnswer() {
    emit(state.copyWith(
        avatarCurrentArtboard: state.avatarArtboardSad,
        stateOfAvatar: BasicOfGameData.stateOfSad));
    decreaseCountOfTries();
  }

  Future<void> _animationOfCorrectAnswer() async {
    emit(state.copyWith(
        avatarCurrentArtboard: state.avatarArtboardSuccess,
        stateOfAvatar: BasicOfGameData.stateOfWin));
  }

  backToMainAvatar() async {
    // await Future.delayed(const Duration(seconds: 2));
    emit(state.copyWith(
        avatarCurrentArtboard: state.avatarArtboardIdle,
        stateOfAvatar: BasicOfGameData.stateOIdle));
  }

  Map<int, Offset> touchPositions = <int, Offset>{};
  void savePointerPosition(int index, Offset position) {
    touchPositions[index] = position;
    emit(state.copyWith(touchPositions: !(state.touchPositions ?? false)));
  }

  clearPointerPosition(int index) {
    touchPositions.remove(index);
    emit(state.copyWith(touchPositions: !(state.touchPositions ?? false)));
  }

  beeTalkingTrue() {
    emit(state.copyWith(beeTalking: true));
  }

  beeTalkingFalse() {
    emit(state.copyWith(beeTalking: false));
  }

  saveCurrentStringOfDice({required String letter}) {
    emit(state.copyWith(currentStringOfDice: letter));
  }

  clearCurrentStringOfDice() {
    emit(state.clearCurrentStringOfDice());
  }
}
