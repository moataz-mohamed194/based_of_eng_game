part of 'tracing_cubit.dart';

enum DrawingStates { error, initial, loading, loaded, gameFinished }

// ignore: must_be_immutable
class TracingState extends Equatable {
  final GameFinalModel gameData;
  final CurrentGamePhoneticsState stateOfGame;
  final TracePhonetics tracePhontics;
  final DrawingStates drawingStates;
  final List<LetterPathsModel> letterPathsModels;
  final int activeIndex; // Track the active letter index

 final Size viewSize;


  TracingState({
    this.viewSize= const Size(0,0), 
    required this.letterPathsModels,
    required this.tracePhontics,
    this.drawingStates = DrawingStates.initial,
    required this.gameData,
    required this.stateOfGame,
    this.activeIndex = 0,
  });

  TracingState copyWith({
    Size? viewSize,
    DrawingStates? drawingStates,
    GameFinalModel? gameData,
    CurrentGamePhoneticsState? stateOfGame,
    // Updated to ui.Image
    List<LetterPathsModel>? letterPathsModels,
    TracePhonetics? tracePhontics,
    int? activeIndex,
  }) {
    return TracingState(
      gameData: gameData ?? this.gameData,
      stateOfGame: stateOfGame ?? this.stateOfGame,
      letterPathsModels: letterPathsModels ?? this.letterPathsModels,
      tracePhontics: tracePhontics ?? this.tracePhontics,
      activeIndex: activeIndex ?? this.activeIndex,
      drawingStates: drawingStates ?? this.drawingStates,
    );
  }

  TracingState clearPosition() {
    return TracingState(
      letterPathsModels: letterPathsModels,
      drawingStates: DrawingStates.initial,
      gameData: gameData,
      stateOfGame: stateOfGame,
      tracePhontics: tracePhontics,
    );
  }

  TracingState clearData() {
    return TracingState(
      letterPathsModels: letterPathsModels,
      drawingStates: DrawingStates.initial,
      gameData: gameData,
      stateOfGame: stateOfGame,
      tracePhontics: tracePhontics,
    );
  }

  @override
  List<Object?> get props => [
        drawingStates,
        viewSize,
        gameData,
        stateOfGame,
        tracePhontics,
        letterPathsModels.map((model) => model.copyWith()).toList(),
        activeIndex
      ];
}
