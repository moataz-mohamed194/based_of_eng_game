import 'dart:async';
import 'dart:math';
import 'package:cubixd/cubixd.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../manager/dice_cubit.dart';
import 'wave_dice.dart';

class DiceWidget3 extends StatefulWidget {
  final List<String> diceLetters;
  int countOfPlayed;
  final void Function(String currentAlphabet) functionOfSaveWords;

  DiceWidget3(
      {super.key,
      required this.diceLetters,
      required this.countOfPlayed,
      required this.functionOfSaveWords});
  @override
  State<DiceWidget3> createState() => _DiceWidget();
}

class _DiceWidget extends State<DiceWidget3> with TickerProviderStateMixin {
  late AnimationController _xcontroller;
  late AnimationController _ycontroller;
  late Tween<double> _animation;
  late Timer timer;
  double widthAndHeight = 100;

  bool? getTheResult;
  List<String> alphabet = [];
  @override
  void initState() {
    alphabet = widget.diceLetters;
    currentAlphabet = alphabet[5];

    super.initState();
    reActiveAnimation();
  }

  String getRandomAlphabet() {
    // int countOfPlayed =
    //     context.read<DiceCubit>().state.correctIndexes?.length ?? 0;
    // if (widget.countOfPlayed % 3 == 0 && widget.countOfPlayed != 0) {
    //   return '';
    // }
    List<String> tmpList = alphabet;
    tmpList.removeWhere((element) => element == '');
    int randomIndex = Random().nextInt(tmpList.length);
    return alphabet[randomIndex];
  }

  String? currentAlphabet;

  int animationCount = 0;
  final int maxAnimationCount = 5;
  Future<void> startAnimation() async {
    _xcontroller
      ..reset()
      ..repeat();

    _ycontroller
      ..reset()
      ..repeat();
    timer = Timer.periodic(const Duration(milliseconds: 500), (Timer t) async {
      String tmpCurrentAlphabet = getRandomAlphabet();
      animationCount++;
      if (animationCount >= maxAnimationCount) {
        setState(() {
          getTheResult = true;

          currentAlphabet = tmpCurrentAlphabet;
        });
        _xcontroller.stop();

        _ycontroller.stop();
        timer.cancel();
        if (currentAlphabet != '') {
          context
              .read<DiceCubit>()
              .updateSelectedLetter(newSelectedLetter: currentAlphabet ?? '');
          widget.functionOfSaveWords.call(currentAlphabet ?? '');
          await Future.delayed(const Duration(seconds: 2));
          //
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        } else {
          setState(() {
            widget.countOfPlayed = widget.countOfPlayed + 1;
          });
        }
      }
    });
  }

  reActiveAnimation() {
    setState(() {
      animationCount = 0;

      getTheResult = false;

      _xcontroller = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 3,
        ),
      );
      _ycontroller = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 3,
        ),
      );
      _animation = Tween<double>(
        begin: 0,
        end: pi * 5,
      );
    });
    startAnimation();
  }

  @override
  void dispose() {
    _xcontroller.dispose();
    _ycontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (timer.isActive == true) ...{
          AnimatedCubixD(
            size: widthAndHeight.h,
            advancedXYposAnim: AnimRequirements(
              controller: _xcontroller,
              xAnimation: _animation.animate(_xcontroller),
              yAnimation: _animation.animate(_ycontroller),
            ),
            stars: false,
            shadow: false,
            onSelected: (SelectedSide opt) {
              switch (opt) {
                case SelectedSide.back:
                  return true;
                case SelectedSide.top:
                  return true;
                case SelectedSide.front:
                  return true;
                case SelectedSide.bottom:
                  return false; // out of service
                case SelectedSide.right:
                  return true;
                case SelectedSide.left:
                  return true;
                case SelectedSide.none:
                  return false;
                default:
                  throw Exception("Unimplemented option");
              }
            },
            top: WaveDice(
              currentAlphabet: alphabet[0],
            ),
            bottom: WaveDice(
              currentAlphabet: alphabet[1],
            ),
            left: WaveDice(
              currentAlphabet: alphabet[2],
            ),
            right: WaveDice(
              currentAlphabet: alphabet[3],
            ),
            front: WaveDice(
              currentAlphabet: alphabet[4],
            ),
            back: WaveDice(
              currentAlphabet: alphabet[5],
            ),
          ),
        } else ...{
          WaveDice(
            currentAlphabet: currentAlphabet ?? '',
          )
        },
        const SizedBox(height: 20),
        if (timer.isActive == false)
          if (currentAlphabet == '') ...{
            GestureDetector(
              onTap: () {
                reActiveAnimation();
              },
              child: const Text(
                'Try again',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            )
          },
      ],
    );
  }
}
