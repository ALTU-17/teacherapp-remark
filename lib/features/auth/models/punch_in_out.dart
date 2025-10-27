import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

part 'punch_in_out.freezed.dart';
part 'punch_in_out.g.dart';

@freezed
abstract class PunchInOut with _$PunchInOut {
  @HiveType(typeId: 4, adapterName: 'PunchInOutAdapter')
  const factory PunchInOut({
    @HiveField(0) @JsonKey(name: "employee_id") String? employeeId,
    @HiveField(1) @JsonKey(name: "date_part") String? datePart,
    @HiveField(2) @JsonKey(name: "punch_in_time") String? punchInTime,
    @HiveField(3) @JsonKey(name: "punch_out_time") String? punchOutTime,
    @HiveField(4) @JsonKey(name: "name") String? name,
  }) = _PunchInOut;

  factory PunchInOut.fromJson(Map<String, dynamic> json) =>
      _$PunchInOutFromJson(json);
}
