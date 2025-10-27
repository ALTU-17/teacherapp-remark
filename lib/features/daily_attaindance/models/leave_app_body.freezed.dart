// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leave_app_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LeaveAppBody {
  @JsonKey(name: 'acd_yr')
  String get acdYr;
  @JsonKey(name: 'staff_id')
  String get staffId;
  @JsonKey(name: 'short_name')
  String get shortName;

  /// Create a copy of LeaveAppBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LeaveAppBodyCopyWith<LeaveAppBody> get copyWith =>
      _$LeaveAppBodyCopyWithImpl<LeaveAppBody>(
          this as LeaveAppBody, _$identity);

  /// Serializes this LeaveAppBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LeaveAppBody &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, acdYr, staffId, shortName);

  @override
  String toString() {
    return 'LeaveAppBody(acdYr: $acdYr, staffId: $staffId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class $LeaveAppBodyCopyWith<$Res> {
  factory $LeaveAppBodyCopyWith(
          LeaveAppBody value, $Res Function(LeaveAppBody) _then) =
      _$LeaveAppBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'acd_yr') String acdYr,
      @JsonKey(name: 'staff_id') String staffId,
      @JsonKey(name: 'short_name') String shortName});
}

/// @nodoc
class _$LeaveAppBodyCopyWithImpl<$Res> implements $LeaveAppBodyCopyWith<$Res> {
  _$LeaveAppBodyCopyWithImpl(this._self, this._then);

  final LeaveAppBody _self;
  final $Res Function(LeaveAppBody) _then;

  /// Create a copy of LeaveAppBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? acdYr = null,
    Object? staffId = null,
    Object? shortName = null,
  }) {
    return _then(_self.copyWith(
      acdYr: null == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String,
      staffId: null == staffId
          ? _self.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _LeaveAppBody implements LeaveAppBody {
  const _LeaveAppBody(
      {@JsonKey(name: 'acd_yr') required this.acdYr,
      @JsonKey(name: 'staff_id') required this.staffId,
      @JsonKey(name: 'short_name') required this.shortName});
  factory _LeaveAppBody.fromJson(Map<String, dynamic> json) =>
      _$LeaveAppBodyFromJson(json);

  @override
  @JsonKey(name: 'acd_yr')
  final String acdYr;
  @override
  @JsonKey(name: 'staff_id')
  final String staffId;
  @override
  @JsonKey(name: 'short_name')
  final String shortName;

  /// Create a copy of LeaveAppBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LeaveAppBodyCopyWith<_LeaveAppBody> get copyWith =>
      __$LeaveAppBodyCopyWithImpl<_LeaveAppBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LeaveAppBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LeaveAppBody &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.staffId, staffId) || other.staffId == staffId) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, acdYr, staffId, shortName);

  @override
  String toString() {
    return 'LeaveAppBody(acdYr: $acdYr, staffId: $staffId, shortName: $shortName)';
  }
}

/// @nodoc
abstract mixin class _$LeaveAppBodyCopyWith<$Res>
    implements $LeaveAppBodyCopyWith<$Res> {
  factory _$LeaveAppBodyCopyWith(
          _LeaveAppBody value, $Res Function(_LeaveAppBody) _then) =
      __$LeaveAppBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'acd_yr') String acdYr,
      @JsonKey(name: 'staff_id') String staffId,
      @JsonKey(name: 'short_name') String shortName});
}

/// @nodoc
class __$LeaveAppBodyCopyWithImpl<$Res>
    implements _$LeaveAppBodyCopyWith<$Res> {
  __$LeaveAppBodyCopyWithImpl(this._self, this._then);

  final _LeaveAppBody _self;
  final $Res Function(_LeaveAppBody) _then;

  /// Create a copy of LeaveAppBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? acdYr = null,
    Object? staffId = null,
    Object? shortName = null,
  }) {
    return _then(_LeaveAppBody(
      acdYr: null == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String,
      staffId: null == staffId
          ? _self.staffId
          : staffId // ignore: cast_nullable_to_non_nullable
              as String,
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
