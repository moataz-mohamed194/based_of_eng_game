
part of 'tracing_cubit.dart';


enum DrawingStates{
  initial,
  loading,
  loaded,
  gameFinished
}

class TracingState extends Equatable {
  final GameFinalModel gameData;
  final CurrentGamePhoneticsState stateOfGame;
 
final DrawingStates drawingStates;
 final List<Path> paths;
  final Path currentDrawingPath;
final  List<List<Offset>> allStrokePoints; // List of all stroke points
 final Offset? anchorPos;

 final bool letterTracingFinished;
 final bool hasFinishedOneStroke;
 final int currentStroke;
 final int currentStrokeProgress;

 final   Path? letterImage;
 final      ui.Image? traceImage;
 final      ui.Image? anchorImage;
  final Size? viewSize;

  TracingState( {
     this.viewSize,
    this.drawingStates=DrawingStates.initial,
    required this.gameData,
    required this.stateOfGame,
    List<Path>? paths,
    Path? currentDrawingPath,
    List<List<Offset>>? allStrokePoints,
   
    this.anchorPos,
    this.letterTracingFinished = false,
    this.hasFinishedOneStroke = false,
    this.currentStroke = 0,
    this.currentStrokeProgress = -1,
    this.letterImage,
    this.traceImage,
    this.anchorImage,
  }) : paths = paths ?? [],
        currentDrawingPath = currentDrawingPath ?? Path(),
        allStrokePoints = allStrokePoints ?? [];

  TracingState copyWith({
    Size? viewSize,
    DrawingStates? drawingStates,
    GameFinalModel? gameData,
    CurrentGamePhoneticsState? stateOfGame,
    List<Path>? paths,
    Path? currentDrawingPath,
    List<List<Offset>>? allStrokePoints,
    Offset? anchorPos,
    bool? letterTracingFinished,
    bool? hasFinishedOneStroke,
    int? currentStroke,
    int? currentStrokeProgress,
    Path? letterImage,
      ui.Image? traceImage,   // Updated to ui.Image
    ui.Image? anchorImage,  // Updated to ui.Image

  }) {
    return TracingState(
      viewSize: viewSize?? this.viewSize,
            drawingStates: drawingStates ?? this.drawingStates,

      gameData: gameData ?? this.gameData,
      stateOfGame: stateOfGame ?? this.stateOfGame,
      paths: paths ?? this.paths,
      currentDrawingPath: currentDrawingPath ?? this.currentDrawingPath,
      allStrokePoints: allStrokePoints ?? this.allStrokePoints,
      anchorPos: anchorPos ?? this.anchorPos,
      letterTracingFinished: letterTracingFinished ?? this.letterTracingFinished,
      hasFinishedOneStroke: hasFinishedOneStroke ?? this.hasFinishedOneStroke,
      currentStroke: currentStroke ?? this.currentStroke,
      currentStrokeProgress: currentStrokeProgress ?? this.currentStrokeProgress,
      letterImage: letterImage ?? this.letterImage,
      traceImage: traceImage ?? this.traceImage,
      anchorImage: anchorImage ?? this.anchorImage,
    );
  }

  TracingState clearPosition() {
    return TracingState(
      viewSize:viewSize ,
      drawingStates: DrawingStates.initial,
      gameData: gameData,
      stateOfGame: stateOfGame,
      paths: paths,
      allStrokePoints: const [],
      anchorPos: Offset.zero,
    );
  }

  TracingState clearData() {
    return TracingState( 
            viewSize:viewSize ,

           drawingStates: DrawingStates.initial,

      gameData: gameData,
      stateOfGame: stateOfGame,
      paths: paths,
      allStrokePoints: const [],
      anchorPos: Offset.zero,
      letterTracingFinished: false,
      hasFinishedOneStroke: false,
      currentStroke: 0,
      currentStrokeProgress: -1,
    );
  }

  @override
  List<Object?> get props => [
    drawingStates,
        gameData,
        stateOfGame,
        paths,
        allStrokePoints,
        anchorPos,
        letterTracingFinished,
        hasFinishedOneStroke,
        currentStroke,
        currentStrokeProgress,
      ];
}
