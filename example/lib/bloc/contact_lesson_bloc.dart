import 'dart:developer';

import 'package:based_of_eng_game/based_of_game.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:games_models/games_models.dart';
import 'package:meta/meta.dart';

import '../domain/use_cases/contact_lesson_use_cases.dart';
import '../domain/use_cases/game_use_cases.dart';
import '../error/failures.dart';
import '../error/failures_messages.dart';

part 'contact_lesson_event.dart';
part 'contact_lesson_state.dart';

class ContactLessonBloc extends Bloc<ContactLessonEvent, ContactLessonState> {
  final ContactLessonUseCases programContactUserUseCases;
  final GetGameUseCases getGameUseCases;

  ContactLessonBloc(
      {required this.programContactUserUseCases, required this.getGameUseCases})
      : super(ContactLessonInitial()) {
    on<ContactLessonEvent>((event, emit) async {
      if (event is GetContactLessonRequest) {
        emit(GetContactLoadingInitial());
        final failureOrDoneMessage = await programContactUserUseCases(
            lessonId: event.lessonId, gameId: event.gameId);
        emit(await _eitherLoadedOrErrorState(
            failureOrDoneMessage, event.gameId));
      } else if (event is CompleteLessonRequest) {
        emit(CompleteGameState());
      } else if (event is ThisTypeNotSupportedRequest) {
        emit(NotSupportTypeState());
      }
    });
  }
}

Future<ContactLessonState> _eitherLoadedOrErrorState(
    Either<Failure, List<GameModel>> failureOrTrivia, int gameId) async {
  ContactLessonState tempState = failureOrTrivia.fold(
    (failure) => GetContactErrorInitial(message: _mapFailureToMessage(failure)),
    (data) => GetContactInitial(data: data),
  );
  return tempState;
}

String _mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return SERVER_FAILURE_MESSAGE;
    case LoginFailure:
      return Login_FAILURE_MESSAGE;
    case CacheFailure:
      return CACHE_FAILURE_MESSAGE;
    default:
      return 'Unexpected error';
  }
}