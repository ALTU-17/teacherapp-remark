// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_chapter_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateChapterRequest {
  @JsonKey(name: "short_name")
  String get shortName;
  @JsonKey(name: "class_id")
  String get classId;
  @JsonKey(name: "chapter_no")
  String get chapterNo;
  @JsonKey(name: "name")
  String get name;
  @JsonKey(name: "login_type")
  String get loginType;
  @JsonKey(name: "description")
  String get description;
  @JsonKey(name: "reg_id")
  String get regId;
  @JsonKey(name: "sm_id")
  String get smId;
  @JsonKey(name: "operation")
  String get operation;
  @JsonKey(name: "acd_yr")
  String get acdYr;
  @JsonKey(name: "sub_subject")
  String? get subSubject;

  /// Create a copy of CreateChapterRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CreateChapterRequestCopyWith<CreateChapterRequest> get copyWith =>
      _$CreateChapterRequestCopyWithImpl<CreateChapterRequest>(
          this as CreateChapterRequest, _$identity);

  /// Serializes this CreateChapterRequest to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CreateChapterRequest &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.chapterNo, chapterNo) ||
                other.chapterNo == chapterNo) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.smId, smId) || other.smId == smId) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.subSubject, subSubject) ||
                other.subSubject == subSubject));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shortName, classId, chapterNo,
      name, loginType, description, regId, smId, operation, acdYr, subSubject);

  @override
  String toString() {
    return 'CreateChapterRequest(shortName: $shortName, classId: $classId, chapterNo: $chapterNo, name: $name, loginType: $loginType, description: $description, regId: $regId, smId: $smId, operation: $operation, acdYr: $acdYr, subSubject: $subSubject)';
  }
}

/// @nodoc
abstract mixin class $CreateChapterRequestCopyWith<$Res> {
  factory $CreateChapterRequestCopyWith(CreateChapterRequest value,
          $Res Function(CreateChapterRequest) _then) =
      _$CreateChapterRequestCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "short_name") String shortName,
      @JsonKey(name: "class_id") String classId,
      @JsonKey(name: "chapter_no") String chapterNo,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "login_type") String loginType,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "reg_id") String regId,
      @JsonKey(name: "sm_id") String smId,
      @JsonKey(name: "operation") String operation,
      @JsonKey(name: "acd_yr") String acdYr,
      @JsonKey(name: "sub_subject") String? subSubject});
}

/// @nodoc
class _$CreateChapterRequestCopyWithImpl<$Res>
    implements $CreateChapterRequestCopyWith<$Res> {
  _$CreateChapterRequestCopyWithImpl(this._self, this._then);

  final CreateChapterRequest _self;
  final $Res Function(CreateChapterRequest) _then;

  /// Create a copy of CreateChapterRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shortName = null,
    Object? classId = null,
    Object? chapterNo = null,
    Object? name = null,
    Object? loginType = null,
    Object? description = null,
    Object? regId = null,
    Object? smId = null,
    Object? operation = null,
    Object? acdYr = null,
    Object? subSubject = freezed,
  }) {
    return _then(_self.copyWith(
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      chapterNo: null == chapterNo
          ? _self.chapterNo
          : chapterNo // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      loginType: null == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      regId: null == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String,
      smId: null == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String,
      operation: null == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String,
      acdYr: null == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String,
      subSubject: freezed == subSubject
          ? _self.subSubject
          : subSubject // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _CreateChapterRequest implements CreateChapterRequest {
  const _CreateChapterRequest(
      {@JsonKey(name: "short_name") required this.shortName,
      @JsonKey(name: "class_id") required this.classId,
      @JsonKey(name: "chapter_no") required this.chapterNo,
      @JsonKey(name: "name") required this.name,
      @JsonKey(name: "login_type") required this.loginType,
      @JsonKey(name: "description") required this.description,
      @JsonKey(name: "reg_id") required this.regId,
      @JsonKey(name: "sm_id") required this.smId,
      @JsonKey(name: "operation") required this.operation,
      @JsonKey(name: "acd_yr") required this.acdYr,
      @JsonKey(name: "sub_subject") this.subSubject});
  factory _CreateChapterRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateChapterRequestFromJson(json);

  @override
  @JsonKey(name: "short_name")
  final String shortName;
  @override
  @JsonKey(name: "class_id")
  final String classId;
  @override
  @JsonKey(name: "chapter_no")
  final String chapterNo;
  @override
  @JsonKey(name: "name")
  final String name;
  @override
  @JsonKey(name: "login_type")
  final String loginType;
  @override
  @JsonKey(name: "description")
  final String description;
  @override
  @JsonKey(name: "reg_id")
  final String regId;
  @override
  @JsonKey(name: "sm_id")
  final String smId;
  @override
  @JsonKey(name: "operation")
  final String operation;
  @override
  @JsonKey(name: "acd_yr")
  final String acdYr;
  @override
  @JsonKey(name: "sub_subject")
  final String? subSubject;

  /// Create a copy of CreateChapterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CreateChapterRequestCopyWith<_CreateChapterRequest> get copyWith =>
      __$CreateChapterRequestCopyWithImpl<_CreateChapterRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CreateChapterRequestToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _CreateChapterRequest &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.chapterNo, chapterNo) ||
                other.chapterNo == chapterNo) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.loginType, loginType) ||
                other.loginType == loginType) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.smId, smId) || other.smId == smId) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.acdYr, acdYr) || other.acdYr == acdYr) &&
            (identical(other.subSubject, subSubject) ||
                other.subSubject == subSubject));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shortName, classId, chapterNo,
      name, loginType, description, regId, smId, operation, acdYr, subSubject);

  @override
  String toString() {
    return 'CreateChapterRequest(shortName: $shortName, classId: $classId, chapterNo: $chapterNo, name: $name, loginType: $loginType, description: $description, regId: $regId, smId: $smId, operation: $operation, acdYr: $acdYr, subSubject: $subSubject)';
  }
}

/// @nodoc
abstract mixin class _$CreateChapterRequestCopyWith<$Res>
    implements $CreateChapterRequestCopyWith<$Res> {
  factory _$CreateChapterRequestCopyWith(_CreateChapterRequest value,
          $Res Function(_CreateChapterRequest) _then) =
      __$CreateChapterRequestCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "short_name") String shortName,
      @JsonKey(name: "class_id") String classId,
      @JsonKey(name: "chapter_no") String chapterNo,
      @JsonKey(name: "name") String name,
      @JsonKey(name: "login_type") String loginType,
      @JsonKey(name: "description") String description,
      @JsonKey(name: "reg_id") String regId,
      @JsonKey(name: "sm_id") String smId,
      @JsonKey(name: "operation") String operation,
      @JsonKey(name: "acd_yr") String acdYr,
      @JsonKey(name: "sub_subject") String? subSubject});
}

/// @nodoc
class __$CreateChapterRequestCopyWithImpl<$Res>
    implements _$CreateChapterRequestCopyWith<$Res> {
  __$CreateChapterRequestCopyWithImpl(this._self, this._then);

  final _CreateChapterRequest _self;
  final $Res Function(_CreateChapterRequest) _then;

  /// Create a copy of CreateChapterRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? shortName = null,
    Object? classId = null,
    Object? chapterNo = null,
    Object? name = null,
    Object? loginType = null,
    Object? description = null,
    Object? regId = null,
    Object? smId = null,
    Object? operation = null,
    Object? acdYr = null,
    Object? subSubject = freezed,
  }) {
    return _then(_CreateChapterRequest(
      shortName: null == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String,
      classId: null == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String,
      chapterNo: null == chapterNo
          ? _self.chapterNo
          : chapterNo // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      loginType: null == loginType
          ? _self.loginType
          : loginType // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      regId: null == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String,
      smId: null == smId
          ? _self.smId
          : smId // ignore: cast_nullable_to_non_nullable
              as String,
      operation: null == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String,
      acdYr: null == acdYr
          ? _self.acdYr
          : acdYr // ignore: cast_nullable_to_non_nullable
              as String,
      subSubject: freezed == subSubject
          ? _self.subSubject
          : subSubject // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
