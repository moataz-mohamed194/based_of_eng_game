// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_letters_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GameLettersGameFinalModel _$GameLettersGameFinalModelFromJson(
        Map<String, dynamic> json) =>
    GameLettersGameFinalModel(
      id: (json['id'] as num?)?.toInt(),
      letter: json['letter'] as String?,
      number: (json['number'] as num?)?.toInt(),
      mainQuestion: (json['main_question'] as num?)?.toInt(),
      gameId: (json['game_id'] as num?)?.toInt(),
      hide: json['hide'] as bool? ?? false,
      warmupId: (json['warmup_id'] as num?)?.toInt(),
      unitId: (json['unit_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      stars: (json['stars'] as num?)?.toInt(),
    );

Map<String, dynamic> _$GameLettersGameFinalModelToJson(
        GameLettersGameFinalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'letter': instance.letter,
      'number': instance.number,
      'warmup_id': instance.warmupId,
      'unit_id': instance.unitId,
      'hide': instance.hide,
      'game_id': instance.gameId,
      'main_question': instance.mainQuestion,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'stars': instance.stars,
    };
