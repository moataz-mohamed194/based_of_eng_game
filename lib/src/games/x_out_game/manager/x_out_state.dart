part of 'x_out_cubit.dart';

@immutable
class XOutInitial extends Equatable {
  final List<GameFinalModel> listGameData;
  final GameFinalModel? gameData;
  final int? correctAnswers;
  final int currentGameIndex;
  final int? isWrong;
  final List<int>? selectedItems;
  final List<GameImagesGameFinalModel>? gameImages;
  final bool isArabic;
  const XOutInitial({
    required this.listGameData,
    this.gameData,
    this.gameImages,
    this.correctAnswers = 0,
    this.isWrong,
    required this.currentGameIndex,
    this.selectedItems = const [],
    this.isArabic = false,
  });

  XOutInitial copyWith({
    List<GameFinalModel>? listGameData,
    int? correctAnswers,
    GameFinalModel? gameData,
    int? currentGameIndex,
    int? isWrong,
    List<GameImagesGameFinalModel>? gameImages,
    List<int>? selectedItems,
    bool? isArabic,
    // bool? isInteracting,
  }) {
    return XOutInitial(
      listGameData: listGameData ?? this.listGameData,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      currentGameIndex: currentGameIndex ?? this.currentGameIndex,
      isWrong: isWrong ?? this.isWrong,
      gameImages: gameImages ?? this.gameImages,
      selectedItems: selectedItems ?? this.selectedItems,
      gameData: gameData ?? this.gameData,
      isArabic: isArabic ?? this.isArabic,
    );
  }

  XOutInitial clearCurrentCorrectAnswers() {
    return XOutInitial(
      listGameData: listGameData,
      correctAnswers: null,
      isWrong: null,
      gameImages: gameImages,
      currentGameIndex: currentGameIndex,
      selectedItems: null,
      gameData: gameData ?? gameData,
      isArabic: isArabic,
    );
  }

  XOutInitial clearWrongStateAnswer() {
    return XOutInitial(
      listGameData: listGameData,
      correctAnswers: correctAnswers,
      isWrong: null,
      gameImages: gameImages,
      currentGameIndex: currentGameIndex,
      selectedItems: selectedItems,
      gameData: gameData ?? gameData,
      isArabic: isArabic,
    );
  }

  @override
  List<Object?> get props => [
        listGameData,
        gameImages,
        correctAnswers,
        selectedItems,
        currentGameIndex,
        gameData,
        isWrong,
        isArabic,
      ];
}
