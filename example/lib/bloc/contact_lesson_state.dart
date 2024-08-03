part of 'contact_lesson_bloc.dart';

@immutable
abstract class ContactLessonState extends Equatable {
  @override
  List<Object> get props => [];
}

class ContactLessonInitial extends ContactLessonState {}

class GetContactInitial extends ContactLessonState {
  final List<GameFinalModel> data;

  GetContactInitial({required this.data});

  MainDataOfChapters? getMainContactData({required int index,required BuildContext context}) {
    String subLetter = data[index].mainLetter ?? '';
    String unitName = data[index].lesson?.unit?.name ?? '';
    String subGame = data[index].gameTypes?.name ?? '';
    String gameName = data[index].name ?? '';
    String programName = data[index].lesson?.unit?.program?.course?.name ?? '';
    String lessonName = data[index].lesson?.name ?? '';
    int audioFlag = data[index].audioFlag ?? 0;
    debugPrint(
        "subLetter:$subLetter ,subGame:$subGame, audioFlag:$audioFlag, unitName:$unitName");
    MainDataOfChapters? x =
        HandlingActionsAndDataOfChapters.getTheChapterDataType(
          parentContext: context,
            subLetter: subLetter,
            subGame: subGame,
            unitName: unitName,
            audioFlag: audioFlag,
            programName: programName,
            lessonName: lessonName,
            gameName: gameName);
    debugPrint(
        "x:$x ,subGame:$subGame, audioFlag:$audioFlag, unitName:$unitName");

    return x;
  }
}

class GetContactLoadingInitial extends ContactLessonState {}

class LogOutLoadingState extends ContactLessonState {}

class NotSupportTypeState extends ContactLessonState {}

class CompleteGameState extends ContactLessonState {}

class GetContactErrorInitial extends ContactLessonState {
  final String message;

  GetContactErrorInitial({required this.message});

  @override
  List<Object> get props => [message];
}
