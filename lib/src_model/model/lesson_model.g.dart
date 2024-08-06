// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonGameFinalModel _$LessonGameFinalModelFromJson(
        Map<String, dynamic> json) =>
    LessonGameFinalModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      stars: (json['stars'] as num?)?.toInt(),
      number: (json['number'] as num?)?.toInt(),
      unitId: (json['unit_id'] as num?)?.toInt(),
      warmupId: (json['warmup_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      type: json['type'] as String?,
      mobLessonName: json['mob_lesson_name'] as String?,
      unit: json['unit'] == null
          ? null
          : UserCourseGameFinalModel.fromJson(
              json['unit'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LessonGameFinalModelToJson(
        LessonGameFinalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'warmup_id': instance.warmupId,
      'stars': instance.stars,
      'type': instance.type,
      'unit_id': instance.unitId,
      'name': instance.name,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'mob_lesson_name': instance.mobLessonName,
      'unit': instance.unit?.toJson(),
    };
