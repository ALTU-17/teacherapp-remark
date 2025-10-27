// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClassInfoAdapter extends TypeAdapter<_ClassInfo> {
  @override
  final typeId = 3;

  @override
  _ClassInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _ClassInfo(
      className: fields[0] as String?,
      sectionName: fields[1] as String?,
      classId: fields[2] as String?,
      sectionId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _ClassInfo obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.className)
      ..writeByte(1)
      ..write(obj.sectionName)
      ..writeByte(2)
      ..write(obj.classId)
      ..writeByte(3)
      ..write(obj.sectionId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClassInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ClassInfo _$ClassInfoFromJson(Map<String, dynamic> json) => _ClassInfo(
      className: json['classname'] as String?,
      sectionName: json['sectionname'] as String?,
      classId: json['class_id'] as String?,
      sectionId: json['section_id'] as String?,
    );

Map<String, dynamic> _$ClassInfoToJson(_ClassInfo instance) =>
    <String, dynamic>{
      if (instance.className case final value?) 'classname': value,
      if (instance.sectionName case final value?) 'sectionname': value,
      if (instance.classId case final value?) 'class_id': value,
      if (instance.sectionId case final value?) 'section_id': value,
    };
