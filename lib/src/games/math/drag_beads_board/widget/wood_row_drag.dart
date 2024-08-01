import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../src_model/model/game_choices_model.dart';
import '../../../../core/game_types/assets_images_math.dart';
import '../../../../core/phonetics_color.dart';
import '../../../../core/theme_text.dart';
import '../../../../cubit/current_game_phonetics_cubit.dart';
import '../../choose_number_oe/manager/choose_number_oe_cubit.dart';
import '../manager/drag_beads_board_cubit.dart';

class WoodRowDrag extends StatelessWidget {
  final DragBeadsBoardInitial gameState;

  const WoodRowDrag({super.key, required this.gameState});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: Column(
          children: List.generate(
              gameState.gameLetters?.length ?? 0,
              (index) => Container(
                    width: 70.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: index == 0
                                ? const AssetImage(AppImagesMath.woodBox)
                                : index ==
                                        ((gameState.gameImages?.length ?? 0) -
                                            1)
                                    ? const AssetImage(
                                        AppImagesMath.woodBoxLast)
                                    : const AssetImage(
                                        AppImagesMath.woodBoxMid),
                            fit: BoxFit.fill)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          gameState.gameImages?[index].word?.split('').first ??
                              '',
                          style: TextStyle(
                            color: AppColorPhonetics.darkBlueColor,
                            fontSize: 20.sp,
                            fontFamily: AppTheme.getFontFamily5(),
                            fontWeight: FontWeight.w400,
                            // height: 0,
                          ),
                        ),
                        10.pw,
                        Container(
                          width: 20.w,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      AppImagesMath.woodBoxForNumber),
                                  fit: BoxFit.fill)),
                          alignment: Alignment.center,
                          child: Text(
                            gameState.gameImages?[index].word?.split('').last ??
                                '',
                            style: TextStyle(
                              color: AppColorPhonetics.darkBlueColor,
                              fontSize: 20.sp,
                              fontFamily: AppTheme.getFontFamily5(),
                              fontWeight: FontWeight.w400,
                              // height: 0,
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
        ),
      ),
    );
  }
}
