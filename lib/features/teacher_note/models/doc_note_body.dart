import 'package:freezed_annotation/freezed_annotation.dart';

part 'doc_note_body.freezed.dart';
part 'doc_note_body.g.dart';

@freezed
abstract class DocNoteBody with _$DocNoteBody {
  const factory DocNoteBody({
    @JsonKey(name: "note_id") required String noteId,
    @JsonKey(name: "dailynote_date") String? dailynoteDate,
    @JsonKey(name: "short_name") required String shortName,
  }) = _DocNoteBody;

  factory DocNoteBody.fromJson(Map<String, dynamic> json) =>
      _$DocNoteBodyFromJson(json);
}
