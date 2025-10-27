import 'package:freezed_annotation/freezed_annotation.dart';

part 'note.freezed.dart';
part 'note.g.dart';

@freezed
abstract class Note with _$Note {
  const factory Note({
    @JsonKey(name: "notes_id") String? notesId,
    @JsonKey(name: "date") String? date,
    @JsonKey(name: "publish_date") DateTime? publishDate,
    @JsonKey(name: "class_id") String? classId,
    @JsonKey(name: "teacher_id") String? teacherId,
    @JsonKey(name: "section_id") String? sectionId,
    @JsonKey(name: "subject_id") String? subjectId,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "publish") String? publish,
    @JsonKey(name: "subjectname") String? subjectname,
    @JsonKey(name: "sm_id") String? smId,
    @JsonKey(name: "classname") String? classname,
    @JsonKey(name: "sectionname") String? sectionname,
  }) = _Note;

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);
}
