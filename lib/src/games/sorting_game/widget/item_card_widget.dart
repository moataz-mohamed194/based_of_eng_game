import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../src_model/export_models.dart';
import '../manager/sorting_cubit.dart';

class ItemCardWidget extends StatelessWidget {
  final void Function()? onTap;
  final GameImagesGameFinalModel body;
  final int index;
  final GameImagesGameFinalModel data;

  const ItemCardWidget(
      {super.key,
      required this.body,
      this.onTap,
      required this.index,
      required this.data});
  @override
  Widget build(BuildContext context) {
    return Draggable<GameImagesGameFinalModel>(
      // Data is the value this Draggable stores.
      data: data,
      maxSimultaneousDrags: 1,
      //     context.read<SortingCubit>().hasAccessToDrag(index) ? 1 : 0,
      feedback: Transform.translate(
          offset:
              const Offset(30, 0), // Adjust the offset to center the feedback
          child: Material(
            color: Colors.transparent,
            child: Container(
              height: (MediaQuery.of(context).size.height ) / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: CachedNetworkImage(
                imageUrl: body.image!,
                placeholder: (context, url) => const Center(
                  child: CupertinoActivityIndicator(),
                ),
                errorWidget: (context, url, error) => Text(body.word ?? ''),
                // height: ,
              ),
            ),
          )),
      childWhenDragging: const SizedBox(),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          height: (MediaQuery.of(context).size.height * 0.6) / 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: CachedNetworkImage(
              imageUrl: body.image!,
              placeholder: (context, url) => const Center(
                child: CupertinoActivityIndicator(),
              ),
              errorWidget: (context, url, error) => Center(
                child: Text('${body.word}'),
              ),
              // height: ,
            ),
          ),
        ),
      ),
    );
  }
}
