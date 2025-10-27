import 'package:freezed_annotation/freezed_annotation.dart';

part 'doc_homework_body.freezed.dart';
part 'doc_homework_body.g.dart';

@freezed
abstract class DocHomeworkBody with _$DocHomeworkBody {
  const factory DocHomeworkBody({
    @JsonKey(name: "homework_id") required String homeworkId,
    @JsonKey(name: "homework_date") required String homeworkDate,
    @JsonKey(name: "short_name") required String shortName,
  }) = _DocHomeworkBody;

  factory DocHomeworkBody.fromJson(Map<String, dynamic> json) =>
      _$DocHomeworkBodyFromJson(json);
}
