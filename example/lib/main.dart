import 'package:based_of_eng_game/based_of_eng_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'injection/injection_container.dart' as di;

import 'bloc/contact_lesson_bloc.dart';

Future<void> main() async {
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return BlocProvider<ContactLessonBloc>(
                  create: (_) => di.sl<ContactLessonBloc>()
                    ..add(GetContactLessonRequest(lessonId: 102, gameId: 1259)),
                    // ..add(GetContactLessonRequest(lessonId: 102, gameId: 1252)),
                  child: BlocConsumer<ContactLessonBloc, ContactLessonState>(
                    listener: (context, state) {
                      if (state is GetContactErrorInitial) {
                        final snackBar = SnackBar(
                          content: Text(state.message),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } else if (state is LogOutLoadingState) {
                        Navigator.of(context).pop();
                      } else if (state is GetContactInitial) {
                        try {
                          MainDataOfChapters? dataType =
                              state.getMainContactData(index: 0);

                          debugPrint('dataType:$dataType');
                        } catch (e) {
                          context
                              .read<ContactLessonBloc>()
                              .add(ThisTypeNotSupportedRequest());
                        }
                      }
                    },
                    builder: (context, stateOfGameData) {
                      if (stateOfGameData is GetContactInitial) {
                        return MainScreenOfGames(
                          stateOfGameData: stateOfGameData.data,
                          dataOfBasesGame:
                              stateOfGameData.getMainContactData(index: 0),
                          actionOfCompleteGame: (int countOfStars) {
                            // List<int> listOfIds = stateOfGameData.data;
                            List<int> listOfIds = stateOfGameData.data
                                .map((game) => game.id ?? 0)
                                .toList();
                            debugPrint(
                                '#########################################');
                            debugPrint(
                                'the stars send: $listOfIds , $countOfStars');
                            debugPrint(
                                '#########################################');
                          },
                          showTheEditedGames: false,
                        );
                      } else {
                        return const CircularProgressIndicator();
                      }
                    },
                  ));
            }));
  }
}
