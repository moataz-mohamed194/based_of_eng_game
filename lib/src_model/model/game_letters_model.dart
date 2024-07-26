import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'game_letters_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GameLettersGameFinalModel extends Equatable {
  final int? id;
  final String? letter;
  final String? secLetter;
  final int? number;
  final int? warmupId;
  final int? unitId;
  final bool? hide;
  final int? gameId;
  final int? mainQuestion;
  final String? createdAt;
  final String? updatedAt;
  final int? stars;

  const GameLettersGameFinalModel(
      {this.id,
      this.letter,
      this.secLetter,
      this.number,
      this.mainQuestion,
      this.gameId,
      this.hide = false,
      this.warmupId,
      this.unitId,
      this.createdAt,
      this.updatedAt,
      this.stars});
  factory GameLettersGameFinalModel.fromJson(Map<String, dynamic> json) {
    return _$GameLettersGameFinalModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GameLettersGameFinalModelToJson(this);

  @override
  List<Object?> get props => [
        hide,
        gameId,
        id,
        letter,
        secLetter,
        mainQuestion,
        number,
        warmupId,
        unitId,
        createdAt,
        updatedAt,
        stars
      ];
}
