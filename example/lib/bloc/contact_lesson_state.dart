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

  MainDataOfChapters? getMainContactData({required int index}) {
    String subLetter = data[index].mainLetter ?? '';
    String unitName = data[index].lesson?.unit?.name ?? '';
    String subGame = data[index].gameTypes?.name ?? '';
    int audioFlag = data[index].audioFlag ?? 0;
    debugPrint(
        "subLetter:$subLetter ,subGame:$subGame, audioFlag:$audioFlag, unitName:$unitName");
    log("subLetter:$subLetter ,subGame:$subGame, audioFlag:$audioFlag, unitName:$unitName");
    return BaseOfGames.getGameDataType(
        subLetter: subLetter,
        subGame: subGame,
        unitName: unitName,
        audioFlag: audioFlag);
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
