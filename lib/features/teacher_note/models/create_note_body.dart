import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_note_body.freezed.dart';
part 'create_note_body.g.dart';

@freezed
abstract class CreateNoteBody with _$CreateNoteBody {
  const factory CreateNoteBody({
    @JsonKey(name: 'academic_yr') String? academicYear,
    @JsonKey(name: 'short_name') String? shortName,
    @JsonKey(name: 'random_no') String? randomNo,
    @JsonKey(name: 'teacher_id') String? teacherId,
    String? description,
    @JsonKey(name: 'str_array') String? strArray,
    @JsonKey(name: 'login_type') @Default('T') String? loginType,
    @Default('Y') String? publish,
    @JsonKey(name: 'dailynote_date') String? dailyNoteDate,
    @Default('create') String? operation,
    @JsonKey(name: 'subject_id') String? subjectId,
    //////////
    @JsonKey(name: 'section_id') String? sectionId,
    @JsonKey(name: 'class_id') String? classId,
    @JsonKey(name: 'notes_id') String? notesId,
    ///////////////
    @JsonKey(name: "deleteimagelist") List<String>? deleteimagelist,
    @JsonKey(name: "filename") List<String>? filename,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default([])
    List<PlatformFile> files,
  }) = _CreateNoteBody;

  factory CreateNoteBody.fromJson(Map<String, dynamic> json) =>
      _$CreateNoteBodyFromJson(json);
}
