import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../src_model/export_models.dart';
import '../../../core/phonetics_color.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/drag_word_to_pic_cubit.dart';

class RowImage extends StatelessWidget {
  final List<GameImagesGameFinalModel> gameImages;
  final List<GameImagesGameFinalModel> mainGameImages;

  const RowImage(
      {super.key, required this.gameImages, required this.mainGameImages});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
          (gameImages.length) ?? 0,
          (index) => Column(
                children: [
                  CachedNetworkImage(
                    height: 70.h,
                    // width: 50.w,
                    imageUrl: gameImages[index].image ?? '',
                    placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                  ),
                  8.ph,
                  BlocConsumer<DragWordToPicCubit, DragWordToPicInitial>(
                      listener: (context, state) {},
                      builder: (context, stateOfGameData) {
                        return DragTarget<GameImagesGameFinalModel>(builder: (
                          BuildContext context,
                          List<dynamic> accepted,
                          List<dynamic> rejected,
                        ) {
                          return Container(
                            alignment: Alignment.center,
                            color: AppColorPhonetics.lightBlueColor,
                            width: 25.w,
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Text(
                              gameImages[index].word ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge
                                  ?.copyWith(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: stateOfGameData.correctedAnswers
                                              .contains(gameImages[index].id)
                                          ? AppColorPhonetics.darkBorderColor
                                          : AppColorPhonetics.lightBlueColor,
                                      fontFamily: AppTheme.getFontFamily5()),
                            ),
                          );
                        }, onAcceptWithDetails: (item) async {
                          debugPrint(
                              "+++++++++++:${item.data.word?.toLowerCase()}, ${gameImages[index].word?.toLowerCase()}");
                          if (context
                              .read<CurrentGamePhoneticsCubit>()
                              .ableButton() && !stateOfGameData.correctedAnswers
                              .contains(gameImages[index].id)) {
                          if (item.data.word?.toLowerCase() ==
                              (gameImages[index].word?.toLowerCase())) {
                            context.read<DragWordToPicCubit>().addCorrectAnswer(
                                correctAnswerId: item.data.id ?? 0);
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addSuccessAnswer(
                                    questions: mainGameImages.length,
                                    correctAnswers:
                                        stateOfGameData.correctedAnswers.length)
                                .whenComplete(() async {
                              bool isLastQuestion = context
                                  .read<CurrentGamePhoneticsCubit>()
                                  .secondWayToCheckIfIsTheLastQuestionOfGame(
                                      queations: mainGameImages.length);
                              if (isLastQuestion) {
                                Future.delayed(const Duration(seconds: 2),
                                    () async {
                                  Navigator.of(context).pop();
                                });
                              }
                            });
                          } else {
                            await context
                                .read<CurrentGamePhoneticsCubit>()
                                .addWrongAnswer(
                                    actionOfWrongAnswer: () async {});
                          }
                          }
                        });
                      })
                ],
              )),
    );
  }
}
