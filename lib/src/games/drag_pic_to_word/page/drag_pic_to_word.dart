import 'package:based_of_eng_game/src/core/phonetics_color.dart';
import 'package:based_of_eng_game/src/widgets/empty_space.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../../../src_model/export_models.dart';
import '../../../core/theme_text.dart';
import '../../../cubit/current_game_phonetics_cubit.dart';
import '../manager/drag_pic_to_word_cubit.dart';
import '../widget/image_in_drag.dart';

class DragPicToWordGameScreen extends StatefulWidget {
  const DragPicToWordGameScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DragPicToWordGameScreen();
  }
}

class _DragPicToWordGameScreen extends State<DragPicToWordGameScreen> {
  @override
  void initState() {
    final GameFinalModel gameData =
        context.read<DragPicToWordCubit>().state.gameData;
    context
        .read<CurrentGamePhoneticsCubit>()
        .getStateOfStars(mainCountOfQuestion: gameData.gameImages?.length ?? 0);

    context.read<CurrentGamePhoneticsCubit>().saveTheStringWillSay(
        stateOfStringIsWord: StateOfSubWord.stopTalk,
        stateOfStringWillSay: gameData.mainLetter ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DragPicToWordCubit, DragPicToWordInitial>(
        listener: (context, state) {},
        builder: (context, stateOfGameData) {
          return Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              10.ph,
              10.ph,
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(24),
                  decoration: ShapeDecoration(
                    color: Colors.white.withOpacity(0.8199999928474426),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(4),
                      ),
                    ),
                    shadows: const [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 14,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: _buildListOfImages(stateOfGameData: stateOfGameData)),
              _buildListOfLetters(
                  stateOfGameData: stateOfGameData, context: context),
            ],
          );
        });
  }

  Widget _buildListOfLetters(
      {required DragPicToWordInitial stateOfGameData,
      required BuildContext context}) {
    final gameLetters = stateOfGameData.gamesLetters ?? [];
    final correctedAnswers = stateOfGameData.correctedAnswers;
    final isArabic = stateOfGameData.isArabic;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        gameLetters.length,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              DottedBorder(
                  strokeWidth: 1,
                  dashPattern: const [8, 4],
                  color: AppColorPhonetics.greyColor,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(7),
                  padding: const EdgeInsets.all(6),
                  child: DragTarget<GameImagesGameFinalModel>(builder: (
                    BuildContext context,
                    List<dynamic> accepted,
                    List<dynamic> rejected,
                  ) {
                    return SizedBox(
                      height: (MediaQuery.of(context).size.width - 20) /
                          (gameLetters.length + 5),
                      width: (MediaQuery.of(context).size.width - 20) /
                          (gameLetters.length + 5),
                      child: correctedAnswers.contains(gameLetters[index].id)
                          ? CachedNetworkImage(
                              imageUrl: gameLetters[index].image ?? '',
                              placeholder: (context, url) => const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            )
                          : null,
                    );
                  }, onAcceptWithDetails: (item) async {
                    if (context
                            .read<CurrentGamePhoneticsCubit>()
                            .ableButton() &&
                        !correctedAnswers.contains(gameLetters[index].id)) {
                      if (item.data.word?.toLowerCase() ==
                          (gameLetters[index].word?.toLowerCase())) {
                        context.read<DragPicToWordCubit>().addCorrectAnswer(
                            correctAnswerId: item.data.id ?? 0);
                        await context
                            .read<CurrentGamePhoneticsCubit>()
                            .addSuccessAnswer(
                                questions: gameLetters.length,
                                isArabic: isArabic,
                                correctAnswers: correctedAnswers.length)
                            .whenComplete(() async {});
                      } else {
                        await context
                            .read<CurrentGamePhoneticsCubit>()
                            .addWrongAnswer(
                                isArabic: isArabic,
                                actionOfWrongAnswer: () async {});
                      }
                    }
                  })),
              8.ph,
              Container(
                color: AppColorPhonetics.lightBlueColor,
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  gameLetters[index].word ?? '',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColorPhonetics.darkBorderColor,
                      fontFamily: AppTheme.getFontFamily5()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListOfImages({required DragPicToWordInitial stateOfGameData}) {
    final gameImages = stateOfGameData.gameImages ?? [];
    final correctedAnswers = stateOfGameData.correctedAnswers;
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: List.generate(
        gameImages.length,
        (index) => correctedAnswers.contains(gameImages[index].id) == false
            ? Draggable<GameImagesGameFinalModel>(
                data: gameImages[index],
                maxSimultaneousDrags: 1,
                childWhenDragging: Container(
                  width: 30.w,
                  margin: const EdgeInsets.symmetric(horizontal: 7),
                  height: 50.h,
                  padding: const EdgeInsets.only(
                      left: 4.40, right: 3.70, bottom: 0.44),
                ),
                feedback: ImageInDrag(image: gameImages[index]),
                child: ImageInDrag(image: gameImages[index]),
              )
            : Container(
                width: 30.w,
                margin: const EdgeInsets.symmetric(horizontal: 7),
                height: 50.h,
                padding: const EdgeInsets.only(
                    left: 4.40, right: 3.70, bottom: 0.44),
                child: CachedNetworkImage(
                  imageUrl: gameImages[index].image ?? '',
                  color: Colors.grey.withOpacity(.7),
                  placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    color: Colors.red,
                  ),
                ),
              ),
      ),
    );
  }
}
