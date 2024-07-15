import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'game_images_model.dart';
import 'game_letters_model.dart';
import 'game_types_model.dart';
import 'lesson_model.dart';
part 'game_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GameFinalModel extends Equatable {
  final int? id;
  final int? gameTypeId;
  final int? audioFlag;
  final int? numOfLetters;
  final int? numOfLetterRepeat;
  final int? numOfTrials;
  final String? createdAt;
  final String? inst;
  final String? name;
  final String? mainLetter;
  final String? updatedAt;
  final String? correctAns;
  final LessonGameFinalModel? lesson;
  final String? video;
  final GameTypesFinalModel? gameTypes;
  final List<GameLettersGameFinalModel>? gameLetters;
  final List<GameImagesGameFinalModel>? gameImages;
  final int? lessonId;
  final dynamic stars;
  final int? isEdited;
  final int? nextGameId;
  final int? previousGameId;
  final bool isHidden;
  // String? sectionInBook;

  const GameFinalModel(
      {this.id,
      this.lessonId,
      this.gameTypeId,
      this.audioFlag,
      this.numOfLetters,
      this.numOfLetterRepeat,
      this.video,
      this.mainLetter,
      this.name,
      this.inst,
      this.numOfTrials,
      this.lesson,
      this.gameTypes,
      this.createdAt,
      this.updatedAt,
      this.gameLetters,
      this.stars,
      this.nextGameId,
      this.correctAns,
      this.previousGameId,
      this.isEdited,
      this.isHidden = false,
      this.gameImages});
  factory GameFinalModel.fromJson(Map<String, dynamic> json) {
    return _$GameFinalModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GameFinalModelToJson(this);

  @override
  List<Object?> get props => [
        id,
        lessonId,
        gameTypeId,
        mainLetter,
        name,
        audioFlag,
        video,
        numOfLetters,
        numOfLetterRepeat,
        inst,
        numOfTrials,
        lesson,
        gameTypes,
        createdAt,
        updatedAt,
        gameLetters,
        stars,
        gameImages,
        nextGameId,
        correctAns,
        isEdited,
        previousGameId
      ];
}
