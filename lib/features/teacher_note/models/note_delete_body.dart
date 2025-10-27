// notes_id:291
// operation:delete
// login_type:T
// short_name:SACS

import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_delete_body.freezed.dart';
part 'note_delete_body.g.dart';

@freezed
abstract class NoteDeleteBody with _$NoteDeleteBody {
  const factory NoteDeleteBody({
    @JsonKey(name: 'notes_id') String? notesId,
    @Default('delete') String? operation,
    @JsonKey(name: 'login_type') @Default('T') String? loginType,
    @JsonKey(name: 'short_name') String? shortName,
  }) = _NoteDeleteBody;

  factory NoteDeleteBody.fromJson(Map<String, dynamic> json) =>
      _$NoteDeleteBodyFromJson(json);
}
