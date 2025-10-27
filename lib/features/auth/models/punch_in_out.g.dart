// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punch_in_out.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PunchInOutAdapter extends TypeAdapter<_PunchInOut> {
  @override
  final typeId = 4;

  @override
  _PunchInOut read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return _PunchInOut(
      employeeId: fields[0] as String?,
      datePart: fields[1] as String?,
      punchInTime: fields[2] as String?,
      punchOutTime: fields[3] as String?,
      name: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, _PunchInOut obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.employeeId)
      ..writeByte(1)
      ..write(obj.datePart)
      ..writeByte(2)
      ..write(obj.punchInTime)
      ..writeByte(3)
      ..write(obj.punchOutTime)
      ..writeByte(4)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PunchInOutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PunchInOut _$PunchInOutFromJson(Map<String, dynamic> json) => _PunchInOut(
      employeeId: json['employee_id'] as String?,
      datePart: json['date_part'] as String?,
      punchInTime: json['punch_in_time'] as String?,
      punchOutTime: json['punch_out_time'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PunchInOutToJson(_PunchInOut instance) =>
    <String, dynamic>{
      if (instance.employeeId case final value?) 'employee_id': value,
      if (instance.datePart case final value?) 'date_part': value,
      if (instance.punchInTime case final value?) 'punch_in_time': value,
      if (instance.punchOutTime case final value?) 'punch_out_time': value,
      if (instance.name case final value?) 'name': value,
    };
