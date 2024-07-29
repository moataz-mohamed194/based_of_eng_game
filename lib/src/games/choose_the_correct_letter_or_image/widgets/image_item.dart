import 'package:based_of_eng_game/src/core/game_types/assets_images_arabic.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({
    super.key,
    required this.imageUrl,
    required this.letterOfImage,
    this.isCorrect = false,
  });
  final String imageUrl;
  final String letterOfImage;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          width: 60.w,
          height: 120.h,
          placeholder: (context, url) => const Center(
            child: CupertinoActivityIndicator(),
          ),
          errorWidget: (context, url, error) => Center(
            child: Text(letterOfImage),
          ),
          fit: BoxFit.contain,
          // height: ,
        ),
        if (isCorrect)
          Image(
            image: const AssetImage(AppImagesArabic.correctImage),
            width: 60.w,
            height: 120.h,
          ),
      ],
    );
  }
}
