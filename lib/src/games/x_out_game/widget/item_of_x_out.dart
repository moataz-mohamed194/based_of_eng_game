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
    required this.imageName,
    required this.isSelected,
    required this.isCorrect,
    required this.imageId,
    this.isWrong,
    required this.word,
    required this.onDrag,
  });

  final String imageName;
  final String word;
  final bool isSelected;
  final int? isWrong;
  final int imageId;
  final bool isCorrect;
  final Function(DragTargetDetails<String>) onDrag;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // onTap: onTap,
      child: DragTarget<String>(
          builder: (
            BuildContext context,
            List<dynamic> accepted,
            List<dynamic> rejected,
          ) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: AppColorPhonetics.skyBlueColor, width: 3),
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
