// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_choices_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameChoicesGameFinalModel _$GameChoicesGameFinalModelFromJson(
        Map<String, dynamic> json) =>
    GameChoicesGameFinalModel(
      id: (json['id'] as num?)?.toInt(),
      gameId: (json['game_id'] as num?)?.toInt(),
      isCorrect: (json['is_correct'] as num?)?.toInt(),
      choice: json['choice'] as String?,
      questionId: (json['question_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
    );

Map<String, dynamic> _$GameChoicesGameFinalModelToJson(
        GameChoicesGameFinalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'game_id': instance.gameId,
      'choice': instance.choice,
      'question_id': instance.questionId,
      'is_correct': instance.isCorrect,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
