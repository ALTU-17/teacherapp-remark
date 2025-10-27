// To parse this JSON data, do
//
//     final subject = subjectFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject.freezed.dart';
part 'subject.g.dart';

@freezed
abstract class Subject with _$Subject {
  const factory Subject({
    @JsonKey(name: "subject_id") String? subjectId,
    @JsonKey(name: "sm_id") String? smId,
    @JsonKey(name: "class_id") String? classId,
    @JsonKey(name: "section_id") String? sectionId,
    @JsonKey(name: "teacher_id") String? teacherId,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "created_at") dynamic createdAt,
    @JsonKey(name: "updated_at") dynamic updatedAt,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "subject_type") String? subjectType,
  }) = _Subject;

  factory Subject.fromJson(Map<String, dynamic> json) =>
      _$SubjectFromJson(json);
}
