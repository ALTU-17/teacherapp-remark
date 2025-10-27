import 'package:freezed_annotation/freezed_annotation.dart';

part 'chapter.freezed.dart';
part 'chapter.g.dart';

@freezed
abstract class Chapter with _$Chapter {
  const factory Chapter({
    @JsonKey(name: "tec_name") String? tecName,
    @JsonKey(name: "teacher_id") String? teacherId,
    @JsonKey(name: "sub_name") String? subName,
    @JsonKey(name: "class_name") String? className,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "created_by") String? createdBy,
    @JsonKey(name: "publish") String? publish,
    @JsonKey(name: "isDelete") String? isDelete,
    @JsonKey(name: "difficulty_level") String? difficultyLevel,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "sub_subject") String? subSubject,
    @JsonKey(name: "name") String? name,
    @JsonKey(name: "chapter_no") String? chapterNo,
    @JsonKey(name: "subject_id") String? subjectId,
    @JsonKey(name: "class_id") String? classId,
    @JsonKey(name: "chapter_id") String? chapterId,
    // UI fields (not from API)
    @Default(false) bool isSelected,
    @Default(false) bool isPublished,
  }) = _Chapter;

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);
}