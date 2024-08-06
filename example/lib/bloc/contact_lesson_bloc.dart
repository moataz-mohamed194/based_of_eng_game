import 'dart:developer';

import 'package:based_of_eng_game/based_of_eng_game.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/use_cases/contact_lesson_use_cases.dart';
import '../domain/use_cases/game_use_cases.dart';
import '../error/failures.dart';

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
    Either<Failure, List<GameFinalModel>> failureOrTrivia, int gameId) async {
  ContactLessonState tempState = failureOrTrivia.fold(
    (failure) => GetContactErrorInitial(message: _mapFailureToMessage(failure)),
    (data) => GetContactInitial(data: data),
  );
  return tempState;
}

String _mapFailureToMessage(Failure failure) {
  return 'Unexpected error';
}
