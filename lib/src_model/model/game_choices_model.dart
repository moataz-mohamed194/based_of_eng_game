import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'game_choices_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class GameChoicesGameFinalModel extends Equatable {
  final int? id;
  final int? gameId;
  final String? choice;
  final int? questionId;
  final int? isCorrect;
  final String? createdAt;
  final String? updatedAt;

  const GameChoicesGameFinalModel(
      {this.id,
      this.gameId,
      this.isCorrect,
      this.choice,
      this.questionId,
      this.createdAt,
      this.updatedAt});
  factory GameChoicesGameFinalModel.fromJson(Map<String, dynamic> json) {
    return _$GameChoicesGameFinalModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GameChoicesGameFinalModelToJson(this);

  @override
  List<Object?> get props => [
        questionId,
        gameId,
        id,
        choice,
    isCorrect,
        createdAt,
        updatedAt
      ];
}
