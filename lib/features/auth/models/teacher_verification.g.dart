// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teacher_verification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TeacherVerificationAdapter extends TypeAdapter<_TeacherVerification> {
  @override
  final typeId = 0;

  @override
  _TeacherVerification read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _TeacherVerification(
      userId: fields[0] == null ? "test" : fields[0] as String,
      schoolId: fields[1] as String,
      name: fields[2] as String,
      shortName: fields[3] as String,
      url: fields[4] as String,
      teacherapkUrl: fields[5] as String,
      projectUrl: fields[6] as String,
      defaultPassword: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, _TeacherVerification obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.schoolId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.shortName)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.teacherapkUrl)
      ..writeByte(6)
      ..write(obj.projectUrl)
      ..writeByte(7)
      ..write(obj.defaultPassword);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherVerificationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeacherVerification _$TeacherVerificationFromJson(Map<String, dynamic> json) =>
    _TeacherVerification(
      userId: json['user_id'] as String? ?? "test",
      schoolId: json['school_id'] as String,
      name: json['name'] as String,
      shortName: json['short_name'] as String,
      url: json['url'] as String,
      teacherapkUrl: json['teacherapk_url'] as String,
      projectUrl: json['project_url'] as String,
      defaultPassword: json['default_password'] as String,
    );

Map<String, dynamic> _$TeacherVerificationToJson(
        _TeacherVerification instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'school_id': instance.schoolId,
      'name': instance.name,
      'short_name': instance.shortName,
      'url': instance.url,
      'teacherapk_url': instance.teacherapkUrl,
      'project_url': instance.projectUrl,
      'default_password': instance.defaultPassword,
    };
