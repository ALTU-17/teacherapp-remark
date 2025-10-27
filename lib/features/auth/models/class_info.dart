import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
part 'class_info.freezed.dart';
part 'class_info.g.dart';

@freezed
abstract class ClassInfo with _$ClassInfo {
  @HiveType(typeId: 3, adapterName: 'ClassInfoAdapter')
  const factory ClassInfo({
    @HiveField(0) @JsonKey(name: "classname") String? className,
    @HiveField(1) @JsonKey(name: "sectionname") String? sectionName,
    @HiveField(2) @JsonKey(name: "class_id") String? classId,
    @HiveField(3) @JsonKey(name: "section_id") String? sectionId,
  }) = _ClassInfo;

  factory ClassInfo.fromJson(Map<String, dynamic> json) =>
      _$ClassInfoFromJson(json);
}
