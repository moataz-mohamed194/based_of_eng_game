part of 'tracing_cubit.dart';

class TracingInitial extends Equatable {
  final GameFinalModel gameData;
  final CurrentGamePhoneticsState stateOfGame;
  final List<Offset> paths;
  final Offset? currentPosition;
  final int currentDrawingIndex;
  final List<Offset> points;

  const TracingInitial({
    required this.gameData,
    required this.paths,
    this.currentPosition,
    required this.stateOfGame,
    this.currentDrawingIndex = 0,
    this.points = const [],
  });

  TracingInitial copyWith({
    GameFinalModel? gameData,
    List<Color?>? colorsOfPaths,
    List<Offset>? paths,
    CurrentGamePhoneticsState? stateOfGame,
    Offset? currentPosition,
    int? countOfPaths,
    int? currentDrawingIndex,
    List<Offset>? points,
  }) {
    return TracingInitial(
      gameData: gameData ?? this.gameData,
      stateOfGame: stateOfGame ?? this.stateOfGame,
      paths: paths ?? this.paths,
      currentPosition: currentPosition ?? this.currentPosition,
      currentDrawingIndex: currentDrawingIndex ?? this.currentDrawingIndex,
      points: points ?? this.points,
    );
  }

  clearPosition() {
    return TracingInitial(
      gameData: gameData,
      stateOfGame: stateOfGame,
      currentPosition: null,
      paths: paths,
    );
  }

  clearData() {
    return TracingInitial(
      gameData: gameData,
      paths: paths,
      currentPosition: null,
      stateOfGame: stateOfGame,
      points:  [],
      currentDrawingIndex: 0
    );
  }

  @override
  List<Object?> get props => [
        gameData,
        paths,
        currentPosition,
        stateOfGame,
        points,
        currentDrawingIndex
      ];
}
