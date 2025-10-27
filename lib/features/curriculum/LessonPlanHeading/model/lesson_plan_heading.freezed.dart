// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_plan_heading.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LessonPlanHeading {
  @JsonKey(name: 'lesson_plan_headings_id')
  String get id;
  @JsonKey(name: 'name')
  String get title;
  @JsonKey(name: 'sequence')
  String get sequence;
  @JsonKey(name: 'change_daily')
  String? get changeDaily;
  @JsonKey(name: 'IsUsed')
  String? get isUsed;

  /// Create a copy of LessonPlanHeading
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LessonPlanHeadingCopyWith<LessonPlanHeading> get copyWith =>
      _$LessonPlanHeadingCopyWithImpl<LessonPlanHeading>(
          this as LessonPlanHeading, _$identity);

  /// Serializes this LessonPlanHeading to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LessonPlanHeading &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.changeDaily, changeDaily) ||
                other.changeDaily == changeDaily) &&
            (identical(other.isUsed, isUsed) || other.isUsed == isUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, sequence, changeDaily, isUsed);

  @override
  String toString() {
    return 'LessonPlanHeading(id: $id, title: $title, sequence: $sequence, changeDaily: $changeDaily, isUsed: $isUsed)';
  }
}

/// @nodoc
abstract mixin class $LessonPlanHeadingCopyWith<$Res> {
  factory $LessonPlanHeadingCopyWith(
          LessonPlanHeading value, $Res Function(LessonPlanHeading) _then) =
      _$LessonPlanHeadingCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'lesson_plan_headings_id') String id,
      @JsonKey(name: 'name') String title,
      @JsonKey(name: 'sequence') String sequence,
      @JsonKey(name: 'change_daily') String? changeDaily,
      @JsonKey(name: 'IsUsed') String? isUsed});
}

/// @nodoc
class _$LessonPlanHeadingCopyWithImpl<$Res>
    implements $LessonPlanHeadingCopyWith<$Res> {
  _$LessonPlanHeadingCopyWithImpl(this._self, this._then);

  final LessonPlanHeading _self;
  final $Res Function(LessonPlanHeading) _then;

  /// Create a copy of LessonPlanHeading
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? sequence = null,
    Object? changeDaily = freezed,
    Object? isUsed = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      sequence: null == sequence
          ? _self.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as String,
      changeDaily: freezed == changeDaily
          ? _self.changeDaily
          : changeDaily // ignore: cast_nullable_to_non_nullable
              as String?,
      isUsed: freezed == isUsed
          ? _self.isUsed
          : isUsed // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LessonPlanHeading implements LessonPlanHeading {
  const _LessonPlanHeading(
      {@JsonKey(name: 'lesson_plan_headings_id') required this.id,
      @JsonKey(name: 'name') required this.title,
      @JsonKey(name: 'sequence') required this.sequence,
      @JsonKey(name: 'change_daily') this.changeDaily,
      @JsonKey(name: 'IsUsed') this.isUsed});
  factory _LessonPlanHeading.fromJson(Map<String, dynamic> json) =>
      _$LessonPlanHeadingFromJson(json);

  @override
  @JsonKey(name: 'lesson_plan_headings_id')
  final String id;
  @override
  @JsonKey(name: 'name')
  final String title;
  @override
  @JsonKey(name: 'sequence')
  final String sequence;
  @override
  @JsonKey(name: 'change_daily')
  final String? changeDaily;
  @override
  @JsonKey(name: 'IsUsed')
  final String? isUsed;

  /// Create a copy of LessonPlanHeading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LessonPlanHeadingCopyWith<_LessonPlanHeading> get copyWith =>
      __$LessonPlanHeadingCopyWithImpl<_LessonPlanHeading>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LessonPlanHeadingToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LessonPlanHeading &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.sequence, sequence) ||
                other.sequence == sequence) &&
            (identical(other.changeDaily, changeDaily) ||
                other.changeDaily == changeDaily) &&
            (identical(other.isUsed, isUsed) || other.isUsed == isUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, sequence, changeDaily, isUsed);

  @override
  String toString() {
    return 'LessonPlanHeading(id: $id, title: $title, sequence: $sequence, changeDaily: $changeDaily, isUsed: $isUsed)';
  }
}

/// @nodoc
abstract mixin class _$LessonPlanHeadingCopyWith<$Res>
    implements $LessonPlanHeadingCopyWith<$Res> {
  factory _$LessonPlanHeadingCopyWith(
          _LessonPlanHeading value, $Res Function(_LessonPlanHeading) _then) =
      __$LessonPlanHeadingCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'lesson_plan_headings_id') String id,
      @JsonKey(name: 'name') String title,
      @JsonKey(name: 'sequence') String sequence,
      @JsonKey(name: 'change_daily') String? changeDaily,
      @JsonKey(name: 'IsUsed') String? isUsed});
}

/// @nodoc
class __$LessonPlanHeadingCopyWithImpl<$Res>
    implements _$LessonPlanHeadingCopyWith<$Res> {
  __$LessonPlanHeadingCopyWithImpl(this._self, this._then);

  final _LessonPlanHeading _self;
  final $Res Function(_LessonPlanHeading) _then;

  /// Create a copy of LessonPlanHeading
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? sequence = null,
    Object? changeDaily = freezed,
    Object? isUsed = freezed,
  }) {
    return _then(_LessonPlanHeading(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      sequence: null == sequence
          ? _self.sequence
          : sequence // ignore: cast_nullable_to_non_nullable
              as String,
      changeDaily: freezed == changeDaily
          ? _self.changeDaily
          : changeDaily // ignore: cast_nullable_to_non_nullable
              as String?,
      isUsed: freezed == isUsed
          ? _self.isUsed
          : isUsed // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
