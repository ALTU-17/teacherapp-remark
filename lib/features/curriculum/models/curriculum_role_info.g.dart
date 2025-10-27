// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curriculum_role_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurriculumRoleInfoAdapter extends TypeAdapter<_CurriculumRoleInfo> {
  @override
  final int typeId = 10;

  @override
  _CurriculumRoleInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _CurriculumRoleInfo(
      role: fields[0] as String?,
      deptId: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _CurriculumRoleInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.role)
      ..writeByte(1)
      ..write(obj.deptId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurriculumRoleInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CurriculumRoleInfo _$CurriculumRoleInfoFromJson(Map<String, dynamic> json) =>
    _CurriculumRoleInfo(
      role: json['role'] as String?,
      deptId: json['deptId'] as String?,
    );

Map<String, dynamic> _$CurriculumRoleInfoToJson(_CurriculumRoleInfo instance) =>
    <String, dynamic>{
      if (instance.role case final value?) 'role': value,
      if (instance.deptId case final value?) 'deptId': value,
    };
