// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'program_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgramGameFinalModel _$ProgramGameFinalModelFromJson(
        Map<String, dynamic> json) =>
    ProgramGameFinalModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      schoolId: (json['school_id'] as num?)?.toInt(),
      courseId: (json['course_id'] as num?)?.toInt(),
      stageId: (json['stage_id'] as num?)?.toInt(),
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      image: json['image'] as String?,
      studentTests: (json['student_tests'] as List<dynamic>?)
          ?.map((e) => TestGameFinalModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      course: json['course'] == null
          ? null
          : CourseGameFinalModel.fromJson(
              json['course'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProgramGameFinalModelToJson(
        ProgramGameFinalModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'image': instance.image,
      'school_id': instance.schoolId,
      'course_id': instance.courseId,
      'stage_id': instance.stageId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'course': instance.course?.toJson(),
      'student_tests': instance.studentTests?.map((e) => e.toJson()).toList(),
    };
