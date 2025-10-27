import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'upload_doc_body.freezed.dart';
part 'upload_doc_body.g.dart';

@freezed
abstract class UploadDocBody with _$UploadDocBody {
  const factory UploadDocBody({
    @JsonKey(name: "upload_date") String? uploadDate,
    @JsonKey(name: "homework_id") String? homeworkId,
    @JsonKey(name: "random_no") @Default('1') String? randomNo,
    @JsonKey(name: "short_name") String? shortName,
    @JsonKey(name: "doc_type_folder")
    @Default('homework')
    String? docTypeFolder,
    @JsonKey(name: "filename") String? filename,
    @JsonKey(name: "datafile") String? datafile,
    @JsonKey(includeToJson: false, includeFromJson: false)
    List<PlatformFile>? files,
  }) = _UploadDocBody;

  factory UploadDocBody.fromJson(Map<String, dynamic> json) =>
      _$UploadDocBodyFromJson(json);
}


// upload_date:10-07-2025
// random_no:1
// short_name:SACS
// doc_type_folder:homework
// filename:receipts.png
// datafile: