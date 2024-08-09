part of 'tracing_cubit.dart';

enum DrawingStates { error, initial, loading, loaded, gameFinished }

// ignore: must_be_immutable
class TracingState extends Equatable {
  final GameFinalModel gameData;
  final CurrentGamePhoneticsState stateOfGame;
  final List<TraceModel> traceLetter;
  final DrawingStates drawingStates;
  final List<LetterPathsModel> letterPathsModels;
  final int activeIndex; // Track the active letter index
  final bool isArabic; // Track the active letter index

  final Size viewSize;

  TracingState({
    this.viewSize = const Size(0, 0),
    required this.letterPathsModels,
    required this.traceLetter,
    this.drawingStates = DrawingStates.initial,
    required this.gameData,
    required this.isArabic,
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
    List<TraceModel>? traceLetter,
    int? activeIndex,
  }) {
    return TracingState(
      gameData: gameData ?? this.gameData,
      stateOfGame: stateOfGame ?? this.stateOfGame,
      letterPathsModels: letterPathsModels ?? this.letterPathsModels,
      traceLetter: traceLetter ?? this.traceLetter,
      isArabic: isArabic,
      activeIndex: activeIndex ?? this.activeIndex,
      drawingStates: drawingStates ?? this.drawingStates,
    );
  }

  TracingState clearPosition() {
    return TracingState(
      letterPathsModels: letterPathsModels,
      drawingStates: DrawingStates.initial,
      gameData: gameData,
      isArabic: isArabic,
      stateOfGame: stateOfGame,
      traceLetter: traceLetter,
    );
  }

  TracingState clearData() {
    return TracingState(
      letterPathsModels: letterPathsModels,
      drawingStates: DrawingStates.initial,
      gameData: gameData,
      isArabic: isArabic,
      stateOfGame: stateOfGame,
      traceLetter: traceLetter,
    );
  }

  @override
  List<Object?> get props => [
        drawingStates,
        viewSize,
        gameData,
        stateOfGame,
        isArabic,
        traceLetter,
        letterPathsModels.map((model) => model.copyWith()).toList(),
        activeIndex
      ];
}
