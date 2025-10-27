// upload_date:02-03-2025
// random_no:1
// short_name:SACS
// doc_type_folder:homework
// filename:logout.png

import 'package:freezed_annotation/freezed_annotation.dart';

part 'delete_documnet_body.freezed.dart';
part 'delete_documnet_body.g.dart';

@freezed
abstract class DeleteDocumentBody with _$DeleteDocumentBody {
  const factory DeleteDocumentBody({
    @JsonKey(name: 'upload_date') String? uploadDate,
    @JsonKey(name: 'random_no') String? randomNo,
    @JsonKey(name: 'short_name') String? shortName,
    @JsonKey(name: 'doc_type_folder') String? docTypeFolder,
    String? filename,
  }) = _DeleteDocumentBody;

  factory DeleteDocumentBody.fromJson(Map<String, dynamic> json) =>
      _$DeleteDocumentBodyFromJson(json);
}
