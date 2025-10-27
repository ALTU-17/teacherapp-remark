// acd_yr:2025-2026
// login_type:T
// publish:Y
// operation:publish
// notes_id:326
// reg_id:32

import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_publish_body.freezed.dart';
part 'note_publish_body.g.dart';

@freezed
abstract class NotePublishBody with _$NotePublishBody {
  const factory NotePublishBody({
    @JsonKey(name: 'notes_id') String? notesId,
    @Default('publish') String? operation,
    @JsonKey(name: 'login_type') @Default('T') String? loginType,
    @JsonKey(name: 'short_name') String? shortName,
    @JsonKey(name: 'publish') @Default('Y') String? publish,
    @JsonKey(name: 'reg_id') String? regId,
    @JsonKey(name: 'acd_yr') String? acdYr,
    @JsonKey(name: 'subject_id') String? subjectId,
    @JsonKey(name: 'class_id') String? classId,
    @JsonKey(name: 'section_id') String? sectionId,
  }) = _NotePublishBody;

  factory NotePublishBody.fromJson(Map<String, dynamic> json) =>
      _$NotePublishBodyFromJson(json);
}
