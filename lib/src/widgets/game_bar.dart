import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../core/assets_images_main.dart';
import '../cubit/current_game_phonetics_cubit.dart';

class GameBar extends StatelessWidget {
  final CurrentGamePhoneticsState stateOfGame;

  const GameBar({super.key, required this.stateOfGame});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h + 5,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: stateOfGame.basicData?.backGroundOfStarBar,
        boxShadow: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 24,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
              flex: 4,
              child: SizedBox(
                height: 40,
                child: Row(
                  children: [
                    30.pw,
                    GestureDetector(
                      onTap: () {
                        // context
                        //     .read<CurrentGamePhoneticsCubit>()
                        //     .state
                        //     .actionWhenTriesBeZero(
                        //     stateOfGame.countOfStar ?? 0);
                        Navigator.of(context).pop();
                      },
                      child: Image.asset(
                        AppImagesMain.backButtonIcon,
                        height: 40.h,
                        // width: 40.w,
                      ),
                    ),
                    10.pw,
                    GestureDetector(
                      child: Image.asset(
                        AppImagesMain.settingButtonIcon,
                        height: 45.h,
                        // width: 40.w,
                      ),
                    )
                  ],
                ),
              )),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  AppImagesMain.stayOfStarBar,
                  width: 65.w,
                  fit: BoxFit.contain,
                ),
                Container(
                    width: 65.w,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ((stateOfGame.countOfStar ?? 0) == 0)
                        ? Image.asset(
                            AppImagesMain.barZeroStar,
                            width: 40.w,
                            fit: BoxFit.contain,
                          )
                        : ((stateOfGame.countOfStar ?? 0) == 1)
                            ? Image.asset(AppImagesMain.barOneStar, width: 40.w)
                            : ((stateOfGame.countOfStar ?? 0) == 2)
                                ? Image.asset(AppImagesMain.barTwoStar,
                                    width: 40.w)
                                : Image.asset(AppImagesMain.barThreeStar,
                                    width: 40.w))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
