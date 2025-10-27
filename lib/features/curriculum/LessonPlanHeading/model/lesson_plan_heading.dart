import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_plan_heading.freezed.dart';
part 'lesson_plan_heading.g.dart';

@freezed
class LessonPlanHeading with _$LessonPlanHeading {
  const factory LessonPlanHeading({
    @JsonKey(name: 'lesson_plan_headings_id') required String id,
    @JsonKey(name: 'name') required String title,
    @JsonKey(name: 'sequence') required String sequence,
    @JsonKey(name: 'change_daily') String? changeDaily,
    @JsonKey(name: 'IsUsed') String? isUsed,
  }) = _LessonPlanHeading;

  factory LessonPlanHeading.fromJson(Map<String, dynamic> json) => _$LessonPlanHeadingFromJson(json);

  @override
  // TODO: implement changeDaily
  String? get changeDaily => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement isUsed
  String? get isUsed => throw UnimplementedError();

  @override
  // TODO: implement sequence
  String get sequence => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
