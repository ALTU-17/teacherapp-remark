// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'curriculum_role_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurriculumRoleInfo {
  @HiveField(0)
  String? get role;
  @HiveField(1)
  String? get deptId;

  /// Create a copy of CurriculumRoleInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CurriculumRoleInfoCopyWith<CurriculumRoleInfo> get copyWith =>
      _$CurriculumRoleInfoCopyWithImpl<CurriculumRoleInfo>(
          this as CurriculumRoleInfo, _$identity);

  /// Serializes this CurriculumRoleInfo to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CurriculumRoleInfo &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.deptId, deptId) || other.deptId == deptId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, role, deptId);

  @override
  String toString() {
    return 'CurriculumRoleInfo(role: $role, deptId: $deptId)';
  }
}

/// @nodoc
abstract mixin class $CurriculumRoleInfoCopyWith<$Res> {
  factory $CurriculumRoleInfoCopyWith(
          CurriculumRoleInfo value, $Res Function(CurriculumRoleInfo) _then) =
      _$CurriculumRoleInfoCopyWithImpl;
  @useResult
  $Res call({@HiveField(0) String? role, @HiveField(1) String? deptId});
}

/// @nodoc
class _$CurriculumRoleInfoCopyWithImpl<$Res>
    implements $CurriculumRoleInfoCopyWith<$Res> {
  _$CurriculumRoleInfoCopyWithImpl(this._self, this._then);

  final CurriculumRoleInfo _self;
  final $Res Function(CurriculumRoleInfo) _then;

  /// Create a copy of CurriculumRoleInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? role = freezed,
    Object? deptId = freezed,
  }) {
    return _then(_self.copyWith(
      role: freezed == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      deptId: freezed == deptId
          ? _self.deptId
          : deptId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 10, adapterName: 'CurriculumRoleInfoAdapter')
class _CurriculumRoleInfo implements CurriculumRoleInfo {
  const _CurriculumRoleInfo(
      {@HiveField(0) this.role, @HiveField(1) this.deptId});
  factory _CurriculumRoleInfo.fromJson(Map<String, dynamic> json) =>
      _$CurriculumRoleInfoFromJson(json);

  @override
  @HiveField(0)
  final String? role;
  @override
  @HiveField(1)
  final String? deptId;

  /// Create a copy of CurriculumRoleInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CurriculumRoleInfoCopyWith<_CurriculumRoleInfo> get copyWith =>
      __$CurriculumRoleInfoCopyWithImpl<_CurriculumRoleInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CurriculumRoleInfoToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CurriculumRoleInfo &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.deptId, deptId) || other.deptId == deptId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, role, deptId);

  @override
  String toString() {
    return 'CurriculumRoleInfo(role: $role, deptId: $deptId)';
  }
}

/// @nodoc
abstract mixin class _$CurriculumRoleInfoCopyWith<$Res>
    implements $CurriculumRoleInfoCopyWith<$Res> {
  factory _$CurriculumRoleInfoCopyWith(
          _CurriculumRoleInfo value, $Res Function(_CurriculumRoleInfo) _then) =
      __$CurriculumRoleInfoCopyWithImpl;
  @override
  @useResult
  $Res call({@HiveField(0) String? role, @HiveField(1) String? deptId});
}

/// @nodoc
class __$CurriculumRoleInfoCopyWithImpl<$Res>
    implements _$CurriculumRoleInfoCopyWith<$Res> {
  __$CurriculumRoleInfoCopyWithImpl(this._self, this._then);

  final _CurriculumRoleInfo _self;
  final $Res Function(_CurriculumRoleInfo) _then;

  /// Create a copy of CurriculumRoleInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? role = freezed,
    Object? deptId = freezed,
  }) {
    return _then(_CurriculumRoleInfo(
      role: freezed == role
          ? _self.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
      deptId: freezed == deptId
          ? _self.deptId
          : deptId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
