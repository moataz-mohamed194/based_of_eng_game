import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../based_of_eng_game.dart';
import '../../../core/assets_images_phonetics.dart';
import '../../../core/phonetics_color.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';

class XOutItemWidget extends StatelessWidget {
  const XOutItemWidget({
    super.key,
    required this.index,
    required this.imageName,
    required this.isSelected,
    required this.isCorrect,
    required this.imageId,
    this.isWrong,
    required this.word,
    required this.onDrag,
    required this.onTap,
  });
  final int index;
  final String imageName;
  final String word;
  final bool isSelected;
  final int? isWrong;
  final int imageId;
  final bool isCorrect;
  final Function(DragTargetDetails<String>) onDrag;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            bool isLtr = Directionality.of(context) == TextDirection.ltr;
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: index == 3
                    ? BorderRadius.only(
                        bottomLeft: isLtr
                            ? Radius.circular(0.r)
                            : Radius.circular(15.r),
                        bottomRight: isLtr
                            ? Radius.circular(15.r)
                            : Radius.circular(0.r))
                    : index == 2
                        ? BorderRadius.only(
                            bottomRight: isLtr
                                ? Radius.circular(0.r)
                                : Radius.circular(15.r),
                            bottomLeft: isLtr
                                ? Radius.circular(15.r)
                                : Radius.circular(0.r))
                        : null,
                border: (index == 0 || index == 2)
                    ? Border(
                        top: BorderSide(
                            color: AppColorPhonetics.skyBlueColor,
                            width: 1.5.w),
                        left: isLtr
                            ? BorderSide.none
                            : BorderSide(
                                color: AppColorPhonetics.skyBlueColor,
                                width: 0.75.w),
                        right: isLtr
                            ? BorderSide(
                                color: AppColorPhonetics.skyBlueColor,
                                width: 0.75.w)
                            : BorderSide.none,
                      )
                    : Border(
                        top: BorderSide(
                            color: AppColorPhonetics.skyBlueColor,
                            width: 1.5.w),
                        left: isLtr
                            ? BorderSide(
                                color: AppColorPhonetics.skyBlueColor,
                                width: 1.5.w)
                            : BorderSide.none,
                        right: isLtr
                            ? BorderSide.none
                            : BorderSide(
                                color: AppColorPhonetics.skyBlueColor,
                                width: 1.5.w),
                      ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CachedNetworkImage(
                    imageUrl: imageName,
                    // fit: BoxFit.fill,
                    // height: 70.h,
                    // width: 50.w,
                    errorWidget: (context, url, error) {
                      return Center(
                        child: Text(word),
                      );
                    },
                  ),
                  if (isCorrect && isSelected) ...{
                    Image.asset(
                      AppImagesPhonetics.X,
                      width: 40.w,
                    )
                  }
                ],
              ),
            );
          },
          onAcceptWithDetails: (item) async => onDrag(item)),
    );
  }
}
