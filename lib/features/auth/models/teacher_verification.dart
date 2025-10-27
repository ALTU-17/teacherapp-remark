

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';


part 'teacher_verification.freezed.dart';
part 'teacher_verification.g.dart';



@freezed
abstract class TeacherVerification with _$TeacherVerification {
   @HiveType(typeId: 0, adapterName: 'TeacherVerificationAdapter')
    const factory TeacherVerification({
     @Default("test") @HiveField(0)  @JsonKey(name: "user_id")
        String userId,
      @HiveField(1)  @JsonKey(name: "school_id")
       required String schoolId,
       @HiveField(2)  @JsonKey(name: "name")
        required String name,
     @HiveField(3)   @JsonKey(name: "short_name")
        required String shortName,
        @HiveField(4) @JsonKey(name: "url")
        required String url,
        @HiveField(5)  @JsonKey(name: "teacherapk_url")
        required String teacherapkUrl,
         @HiveField(6)  @JsonKey(name: "project_url")
        required String projectUrl,
         @HiveField(7)  @JsonKey(name: "default_password")
        required String defaultPassword,
    }) = _TeacherVerification;

    factory TeacherVerification.fromJson(Map<String, dynamic> json) => _$TeacherVerificationFromJson(json);
}
