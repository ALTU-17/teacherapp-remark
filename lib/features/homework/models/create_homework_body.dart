import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_homework_body.freezed.dart';
part 'create_homework_body.g.dart';

@freezed
abstract class CreateHomeworkBody with _$CreateHomeworkBody {
  const factory CreateHomeworkBody({
    @JsonKey(name: "random_no") String? randomNo,
    @JsonKey(name: "homework_id") String? homeworkId,
    @JsonKey(name: "academic_yr") String? academicYr,
    @JsonKey(name: "teacher_id") String? teacherId,
    @JsonKey(name: "section_id") String? sectionId,
    @JsonKey(name: "class_id") String? classId,
    @JsonKey(name: "sm_id") String? smId,
    @JsonKey(name: "description") String? description,
    @JsonKey(name: "publish") String? publish,
    @JsonKey(name: "end_date") String? endDate,
    @JsonKey(name: "start_date") String? startDate,
    @JsonKey(name: "login_type") String? loginType,
    @JsonKey(name: "operation") @Default('create') String? operation,
    @JsonKey(name: "short_name") String? shortName,
    @JsonKey(name: "deleteimagelist") @Default([]) List<String> deleteimagelist,
    @JsonKey(name: "filename") @Default([]) List<String> filename,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default([])
    List<PlatformFile> files,
  }) = _CreateHomeworkBody;

  factory CreateHomeworkBody.fromJson(Map<String, dynamic> json) =>
      _$CreateHomeworkBodyFromJson(json);
}
