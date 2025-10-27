import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_doc_note.freezed.dart';
part 'upload_doc_note.g.dart';

@freezed
abstract class UploadDocNote with _$UploadDocNote {
  const factory UploadDocNote({
    @JsonKey(name: "upload_date") String? uploadDate,
    @JsonKey(name: "random_no") @Default('1') String? randomNo,
    @JsonKey(name: "short_name") String? shortName,
    @JsonKey(name: "doc_type_folder")
    @Default('daily_notes')
    String? docTypeFolder,
    @JsonKey(name: "filename") String? filename,
    @JsonKey(name: "datafile") String? datafile,
    @JsonKey(includeToJson: false, includeFromJson: false)
    List<PlatformFile>? files,
  }) = _UploadDocNote;

  factory UploadDocNote.fromJson(Map<String, dynamic> json) =>
      _$UploadDocNoteFromJson(json);
}


// upload_date:10-07-2025
// random_no:1
// short_name:SACS
// doc_type_folder:homework
// filename:receipts.png
// datafile: