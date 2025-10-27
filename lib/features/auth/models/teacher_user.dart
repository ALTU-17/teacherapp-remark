import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';

import 'models.dart';
part 'teacher_user.freezed.dart';
part 'teacher_user.g.dart';

@freezed
abstract class TeacherUser with _$TeacherUser {
  @HiveType(typeId: 1, adapterName: 'TeacherUserAdapter')
  const factory TeacherUser({
    @HiveField(0)
    @JsonKey(name: "teacher_verification")
    TeacherVerification? teacherVerification,
    @HiveField(2) @JsonKey(name: "error") bool? error,
    @HiveField(3) @JsonKey(name: "reg_id") String? regId,
    @HiveField(4) @JsonKey(name: "password") String? password,
    @HiveField(5) @JsonKey(name: "default_pwd") String? defaultPwd,
    @HiveField(6) @JsonKey(name: "name") String? name,
    @HiveField(7) @JsonKey(name: "user_id") String? userId,
    @HiveField(8) @JsonKey(name: "role_id") String? roleId,
    @HiveField(9) @JsonKey(name: "academic_yr") String? academicYr,
    @HiveField(10)
    @JsonKey(name: "teacher_details")
    TeacherDetails? teacherDetails,
    @HiveField(11) PunchInOut? punc,
  }) = _TeacherUser;

  factory TeacherUser.fromJson(Map<String, dynamic> json) =>
      _$TeacherUserFromJson(json);
}

@freezed
abstract class TeacherDetails with _$TeacherDetails {
  @HiveType(typeId: 2, adapterName: 'TeacherDetailsAdapter')
  const factory TeacherDetails({
    @HiveField(0) @JsonKey(name: 'teacher_id') String? teacherId,
    @HiveField(1) @JsonKey(name: 'employee_id') String? employeeId,
    @HiveField(2) @JsonKey(name: 'name') String? name,
    @HiveField(3) @JsonKey(name: 'father_spouse_name') String? fatherSpouseName,
    @HiveField(4) @JsonKey(name: 'birthday') String? birthday,
    @HiveField(5) @JsonKey(name: 'date_of_joining') String? dateOfJoining,
    @HiveField(6) @JsonKey(name: 'sex') String? sex,
    @HiveField(7) @JsonKey(name: 'religion') String? religion,
    @HiveField(8) @JsonKey(name: 'blood_group') String? bloodGroup,
    @HiveField(9) @JsonKey(name: 'address') String? address,
    @HiveField(10) @JsonKey(name: 'phone') String? phone,
    @HiveField(11) @JsonKey(name: 'email') String? email,
    @HiveField(12) @JsonKey(name: 'designation') String? designation,
    @HiveField(13) @JsonKey(name: 'academic_qual') String? academicQual,
    @HiveField(14) @JsonKey(name: 'professional_qual') String? professionalQual,
    @HiveField(15) @JsonKey(name: 'special_sub') String? specialSub,
    @HiveField(16) @JsonKey(name: 'trained') String? trained,
    @HiveField(17) @JsonKey(name: 'experience') String? experience,
    @HiveField(18) @JsonKey(name: 'aadhar_card_no') String? aadharCardNo,
    @HiveField(19)
    @JsonKey(name: 'teacher_image_name')
    String? teacherImageName,
    @HiveField(20) @JsonKey(name: 'class_id') String? classId,
    @HiveField(21) @JsonKey(name: 'section_id') String? sectionId,
    @HiveField(22) @JsonKey(name: 'tc_id') String? tcId,
    @HiveField(23) @JsonKey(name: 'isDelete') String? isDelete,
    @HiveField(24) @JsonKey(name: 'role_id') String? roleId,
    @HiveField(25) @JsonKey(name: 'user_id') String? userId,
    @HiveField(26) @JsonKey(name: "status") bool? status,
    @HiveField(27) @JsonKey(name: "gender") String? gender,
    @HiveField(28) @JsonKey(name: "teacher_name") String? teacherName,
    //TODO IGNORE THE BUTTOM FILEDS ON FORM
    @HiveField(29) @JsonKey(name: "class") List<ClassInfo>? classs,
    @HiveField(30) @JsonKey(name: "operation") String? operation,
    @HiveField(31) @JsonKey(name: "short_name") String? shortName,
    @HiveField(32) @JsonKey(name: "reg_id") String? regId,
    @HiveField(33) @JsonKey(name: 'str_array') String? strArray,
  }) = _TeacherDetails;

  factory TeacherDetails.fromJson(Map<String, dynamic> json) =>
      _$TeacherDetailsFromJson(json);
}
