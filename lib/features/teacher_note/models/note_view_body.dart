// acd_yr:2025-2026
// class_id:128
// section_id:506
// notes_id:358
// short_name:SACS

import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_view_body.freezed.dart';
part 'note_view_body.g.dart';

@freezed
abstract class NoteViewBody with _$NoteViewBody {
  const factory NoteViewBody({
    @JsonKey(name: 'acd_yr') String? acdYr,
    @JsonKey(name: 'class_id') String? classId,
    @JsonKey(name: 'section_id') String? sectionId,
    @JsonKey(name: 'notes_id') String? notesId,
    @JsonKey(name: 'short_name') String? shortName,
  }) = _NoteViewBody;

  factory NoteViewBody.fromJson(Map<String, dynamic> json) =>
      _$NoteViewBodyFromJson(json);
}
