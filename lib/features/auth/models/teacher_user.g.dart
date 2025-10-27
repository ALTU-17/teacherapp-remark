// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeacherUserAdapter extends TypeAdapter<_TeacherUser> {
  @override
  final typeId = 1;

  @override
  _TeacherUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _TeacherUser(
      teacherVerification: fields[0] as TeacherVerification?,
      error: fields[2] as bool?,
      regId: fields[3] as String?,
      password: fields[4] as String?,
      defaultPwd: fields[5] as String?,
      name: fields[6] as String?,
      userId: fields[7] as String?,
      roleId: fields[8] as String?,
      academicYr: fields[9] as String?,
      teacherDetails: fields[10] as TeacherDetails?,
      punc: fields[11] as PunchInOut?,
    );
  }

  @override
  void write(BinaryWriter writer, _TeacherUser obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.teacherVerification)
      ..writeByte(2)
      ..write(obj.error)
      ..writeByte(3)
      ..write(obj.regId)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.defaultPwd)
      ..writeByte(6)
      ..write(obj.name)
      ..writeByte(7)
      ..write(obj.userId)
      ..writeByte(8)
      ..write(obj.roleId)
      ..writeByte(9)
      ..write(obj.academicYr)
      ..writeByte(10)
      ..write(obj.teacherDetails)
      ..writeByte(11)
      ..write(obj.punc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TeacherDetailsAdapter extends TypeAdapter<_TeacherDetails> {
  @override
  final typeId = 2;

  @override
  _TeacherDetails read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _TeacherDetails(
      teacherId: fields[0] as String?,
      employeeId: fields[1] as String?,
      name: fields[2] as String?,
      fatherSpouseName: fields[3] as String?,
      birthday: fields[4] as String?,
      dateOfJoining: fields[5] as String?,
      sex: fields[6] as String?,
      religion: fields[7] as String?,
      bloodGroup: fields[8] as String?,
      address: fields[9] as String?,
      phone: fields[10] as String?,
      email: fields[11] as String?,
      designation: fields[12] as String?,
      academicQual: fields[13] as String?,
      professionalQual: fields[14] as String?,
      specialSub: fields[15] as String?,
      trained: fields[16] as String?,
      experience: fields[17] as String?,
      aadharCardNo: fields[18] as String?,
      teacherImageName: fields[19] as String?,
      classId: fields[20] as String?,
      sectionId: fields[21] as String?,
      tcId: fields[22] as String?,
      isDelete: fields[23] as String?,
      roleId: fields[24] as String?,
      userId: fields[25] as String?,
      status: fields[26] as bool?,
      gender: fields[27] as String?,
      teacherName: fields[28] as String?,
      classs: (fields[29] as List?)?.cast<ClassInfo>(),
      operation: fields[30] as String?,
      shortName: fields[31] as String?,
      regId: fields[32] as String?,
      strArray: fields[33] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _TeacherDetails obj) {
    writer
      ..writeByte(34)
      ..writeByte(0)
      ..write(obj.teacherId)
      ..writeByte(1)
      ..write(obj.employeeId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.fatherSpouseName)
      ..writeByte(4)
      ..write(obj.birthday)
      ..writeByte(5)
      ..write(obj.dateOfJoining)
      ..writeByte(6)
      ..write(obj.sex)
      ..writeByte(7)
      ..write(obj.religion)
      ..writeByte(8)
      ..write(obj.bloodGroup)
      ..writeByte(9)
      ..write(obj.address)
      ..writeByte(10)
      ..write(obj.phone)
      ..writeByte(11)
      ..write(obj.email)
      ..writeByte(12)
      ..write(obj.designation)
      ..writeByte(13)
      ..write(obj.academicQual)
      ..writeByte(14)
      ..write(obj.professionalQual)
      ..writeByte(15)
      ..write(obj.specialSub)
      ..writeByte(16)
      ..write(obj.trained)
      ..writeByte(17)
      ..write(obj.experience)
      ..writeByte(18)
      ..write(obj.aadharCardNo)
      ..writeByte(19)
      ..write(obj.teacherImageName)
      ..writeByte(20)
      ..write(obj.classId)
      ..writeByte(21)
      ..write(obj.sectionId)
      ..writeByte(22)
      ..write(obj.tcId)
      ..writeByte(23)
      ..write(obj.isDelete)
      ..writeByte(24)
      ..write(obj.roleId)
      ..writeByte(25)
      ..write(obj.userId)
      ..writeByte(26)
      ..write(obj.status)
      ..writeByte(27)
      ..write(obj.gender)
      ..writeByte(28)
      ..write(obj.teacherName)
      ..writeByte(29)
      ..write(obj.classs)
      ..writeByte(30)
      ..write(obj.operation)
      ..writeByte(31)
      ..write(obj.shortName)
      ..writeByte(32)
      ..write(obj.regId)
      ..writeByte(33)
      ..write(obj.strArray);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherDetailsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeacherUser _$TeacherUserFromJson(Map<String, dynamic> json) => _TeacherUser(
      teacherVerification: json['teacher_verification'] == null
          ? null
          : TeacherVerification.fromJson(
              json['teacher_verification'] as Map<String, dynamic>),
      error: json['error'] as bool?,
      regId: json['reg_id'] as String?,
      password: json['password'] as String?,
      defaultPwd: json['default_pwd'] as String?,
      name: json['name'] as String?,
      userId: json['user_id'] as String?,
      roleId: json['role_id'] as String?,
      academicYr: json['academic_yr'] as String?,
      teacherDetails: json['teacher_details'] == null
          ? null
          : TeacherDetails.fromJson(
              json['teacher_details'] as Map<String, dynamic>),
      punc: json['punc'] == null
          ? null
          : PunchInOut.fromJson(json['punc'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeacherUserToJson(_TeacherUser instance) =>
    <String, dynamic>{
      if (instance.teacherVerification case final value?)
        'teacher_verification': value,
      if (instance.error case final value?) 'error': value,
      if (instance.regId case final value?) 'reg_id': value,
      if (instance.password case final value?) 'password': value,
      if (instance.defaultPwd case final value?) 'default_pwd': value,
      if (instance.name case final value?) 'name': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.roleId case final value?) 'role_id': value,
      if (instance.academicYr case final value?) 'academic_yr': value,
      if (instance.teacherDetails case final value?) 'teacher_details': value,
      if (instance.punc case final value?) 'punc': value,
    };

_TeacherDetails _$TeacherDetailsFromJson(Map<String, dynamic> json) =>
    _TeacherDetails(
      teacherId: json['teacher_id'] as String?,
      employeeId: json['employee_id'] as String?,
      name: json['name'] as String?,
      fatherSpouseName: json['father_spouse_name'] as String?,
      birthday: json['birthday'] as String?,
      dateOfJoining: json['date_of_joining'] as String?,
      sex: json['sex'] as String?,
      religion: json['religion'] as String?,
      bloodGroup: json['blood_group'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      designation: json['designation'] as String?,
      academicQual: json['academic_qual'] as String?,
      professionalQual: json['professional_qual'] as String?,
      specialSub: json['special_sub'] as String?,
      trained: json['trained'] as String?,
      experience: json['experience'] as String?,
      aadharCardNo: json['aadhar_card_no'] as String?,
      teacherImageName: json['teacher_image_name'] as String?,
      classId: json['class_id'] as String?,
      sectionId: json['section_id'] as String?,
      tcId: json['tc_id'] as String?,
      isDelete: json['isDelete'] as String?,
      roleId: json['role_id'] as String?,
      userId: json['user_id'] as String?,
      status: json['status'] as bool?,
      gender: json['gender'] as String?,
      teacherName: json['teacher_name'] as String?,
      classs: (json['class'] as List<dynamic>?)
          ?.map((e) => ClassInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      operation: json['operation'] as String?,
      shortName: json['short_name'] as String?,
      regId: json['reg_id'] as String?,
      strArray: json['str_array'] as String?,
    );

Map<String, dynamic> _$TeacherDetailsToJson(_TeacherDetails instance) =>
    <String, dynamic>{
      if (instance.teacherId case final value?) 'teacher_id': value,
      if (instance.employeeId case final value?) 'employee_id': value,
      if (instance.name case final value?) 'name': value,
      if (instance.fatherSpouseName case final value?)
        'father_spouse_name': value,
      if (instance.birthday case final value?) 'birthday': value,
      if (instance.dateOfJoining case final value?) 'date_of_joining': value,
      if (instance.sex case final value?) 'sex': value,
      if (instance.religion case final value?) 'religion': value,
      if (instance.bloodGroup case final value?) 'blood_group': value,
      if (instance.address case final value?) 'address': value,
      if (instance.phone case final value?) 'phone': value,
      if (instance.email case final value?) 'email': value,
      if (instance.designation case final value?) 'designation': value,
      if (instance.academicQual case final value?) 'academic_qual': value,
      if (instance.professionalQual case final value?)
        'professional_qual': value,
      if (instance.specialSub case final value?) 'special_sub': value,
      if (instance.trained case final value?) 'trained': value,
      if (instance.experience case final value?) 'experience': value,
      if (instance.aadharCardNo case final value?) 'aadhar_card_no': value,
      if (instance.teacherImageName case final value?)
        'teacher_image_name': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
      if (instance.tcId case final value?) 'tc_id': value,
      if (instance.isDelete case final value?) 'isDelete': value,
      if (instance.roleId case final value?) 'role_id': value,
      if (instance.userId case final value?) 'user_id': value,
      if (instance.status case final value?) 'status': value,
      if (instance.gender case final value?) 'gender': value,
      if (instance.teacherName case final value?) 'teacher_name': value,
      if (instance.classs case final value?) 'class': value,
      if (instance.operation case final value?) 'operation': value,
      if (instance.shortName case final value?) 'short_name': value,
      if (instance.regId case final value?) 'reg_id': value,
      if (instance.strArray case final value?) 'str_array': value,
    };
