// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remark.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Remark {
  @JsonKey(name: 'remark_id')
  String get remarkId;
  @JsonKey(name: 'remark_desc')
  String get remarkDesc;
  @JsonKey(name: 'remark_subject')
  String get remarkSubject;
  @JsonKey(name: 'remark_type')
  String get remarkType;
  @JsonKey(name: 'remark_date')
  String get remarkDate;
  @JsonKey(name: 'class_name')
  String get className;
  @JsonKey(name: 'sec_name')
  String get secName;
  @JsonKey(name: 'sub_name')
  String get subName;
  @JsonKey(name: 'first_name')
  String get firstName;
  @JsonKey(name: 'mid_name')
  String get midName;
  @JsonKey(name: 'last_name')
  String get lastName;

  /// Create a copy of Remark
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $RemarkCopyWith<Remark> get copyWith =>
      _$RemarkCopyWithImpl<Remark>(this as Remark, _$identity);

  /// Serializes this Remark to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Remark &&
            (identical(other.remarkId, remarkId) ||
                other.remarkId == remarkId) &&
            (identical(other.remarkDesc, remarkDesc) ||
                other.remarkDesc == remarkDesc) &&
            (identical(other.remarkSubject, remarkSubject) ||
                other.remarkSubject == remarkSubject) &&
            (identical(other.remarkType, remarkType) ||
                other.remarkType == remarkType) &&
            (identical(other.remarkDate, remarkDate) ||
                other.remarkDate == remarkDate) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.secName, secName) || other.secName == secName) &&
            (identical(other.subName, subName) || other.subName == subName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.midName, midName) || other.midName == midName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      remarkId,
      remarkDesc,
      remarkSubject,
      remarkType,
      remarkDate,
      className,
      secName,
      subName,
      firstName,
      midName,
      lastName);

  @override
  String toString() {
    return 'Remark(remarkId: $remarkId, remarkDesc: $remarkDesc, remarkSubject: $remarkSubject, remarkType: $remarkType, remarkDate: $remarkDate, className: $className, secName: $secName, subName: $subName, firstName: $firstName, midName: $midName, lastName: $lastName)';
  }
}

/// @nodoc
abstract mixin class $RemarkCopyWith<$Res> {
  factory $RemarkCopyWith(Remark value, $Res Function(Remark) _then) =
      _$RemarkCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'remark_id') String remarkId,
      @JsonKey(name: 'remark_desc') String remarkDesc,
      @JsonKey(name: 'remark_subject') String remarkSubject,
      @JsonKey(name: 'remark_type') String remarkType,
      @JsonKey(name: 'remark_date') String remarkDate,
      @JsonKey(name: 'class_name') String className,
      @JsonKey(name: 'sec_name') String secName,
      @JsonKey(name: 'sub_name') String subName,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'mid_name') String midName,
      @JsonKey(name: 'last_name') String lastName});
}

/// @nodoc
class _$RemarkCopyWithImpl<$Res> implements $RemarkCopyWith<$Res> {
  _$RemarkCopyWithImpl(this._self, this._then);

  final Remark _self;
  final $Res Function(Remark) _then;

  /// Create a copy of Remark
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? remarkId = null,
    Object? remarkDesc = null,
    Object? remarkSubject = null,
    Object? remarkType = null,
    Object? remarkDate = null,
    Object? className = null,
    Object? secName = null,
    Object? subName = null,
    Object? firstName = null,
    Object? midName = null,
    Object? lastName = null,
  }) {
    return _then(_self.copyWith(
      remarkId: null == remarkId
          ? _self.remarkId
          : remarkId // ignore: cast_nullable_to_non_nullable
              as String,
      remarkDesc: null == remarkDesc
          ? _self.remarkDesc
          : remarkDesc // ignore: cast_nullable_to_non_nullable
              as String,
      remarkSubject: null == remarkSubject
          ? _self.remarkSubject
          : remarkSubject // ignore: cast_nullable_to_non_nullable
              as String,
      remarkType: null == remarkType
          ? _self.remarkType
          : remarkType // ignore: cast_nullable_to_non_nullable
              as String,
      remarkDate: null == remarkDate
          ? _self.remarkDate
          : remarkDate // ignore: cast_nullable_to_non_nullable
              as String,
      className: null == className
          ? _self.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      secName: null == secName
          ? _self.secName
          : secName // ignore: cast_nullable_to_non_nullable
              as String,
      subName: null == subName
          ? _self.subName
          : subName // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      midName: null == midName
          ? _self.midName
          : midName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _Remark implements Remark {
  const _Remark(
      {@JsonKey(name: 'remark_id') required this.remarkId,
      @JsonKey(name: 'remark_desc') required this.remarkDesc,
      @JsonKey(name: 'remark_subject') required this.remarkSubject,
      @JsonKey(name: 'remark_type') required this.remarkType,
      @JsonKey(name: 'remark_date') required this.remarkDate,
      @JsonKey(name: 'class_name') required this.className,
      @JsonKey(name: 'sec_name') required this.secName,
      @JsonKey(name: 'sub_name') required this.subName,
      @JsonKey(name: 'first_name') required this.firstName,
      @JsonKey(name: 'mid_name') required this.midName,
      @JsonKey(name: 'last_name') required this.lastName});
  factory _Remark.fromJson(Map<String, dynamic> json) => _$RemarkFromJson(json);

  @override
  @JsonKey(name: 'remark_id')
  final String remarkId;
  @override
  @JsonKey(name: 'remark_desc')
  final String remarkDesc;
  @override
  @JsonKey(name: 'remark_subject')
  final String remarkSubject;
  @override
  @JsonKey(name: 'remark_type')
  final String remarkType;
  @override
  @JsonKey(name: 'remark_date')
  final String remarkDate;
  @override
  @JsonKey(name: 'class_name')
  final String className;
  @override
  @JsonKey(name: 'sec_name')
  final String secName;
  @override
  @JsonKey(name: 'sub_name')
  final String subName;
  @override
  @JsonKey(name: 'first_name')
  final String firstName;
  @override
  @JsonKey(name: 'mid_name')
  final String midName;
  @override
  @JsonKey(name: 'last_name')
  final String lastName;

  /// Create a copy of Remark
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$RemarkCopyWith<_Remark> get copyWith =>
      __$RemarkCopyWithImpl<_Remark>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$RemarkToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Remark &&
            (identical(other.remarkId, remarkId) ||
                other.remarkId == remarkId) &&
            (identical(other.remarkDesc, remarkDesc) ||
                other.remarkDesc == remarkDesc) &&
            (identical(other.remarkSubject, remarkSubject) ||
                other.remarkSubject == remarkSubject) &&
            (identical(other.remarkType, remarkType) ||
                other.remarkType == remarkType) &&
            (identical(other.remarkDate, remarkDate) ||
                other.remarkDate == remarkDate) &&
            (identical(other.className, className) ||
                other.className == className) &&
            (identical(other.secName, secName) || other.secName == secName) &&
            (identical(other.subName, subName) || other.subName == subName) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.midName, midName) || other.midName == midName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      remarkId,
      remarkDesc,
      remarkSubject,
      remarkType,
      remarkDate,
      className,
      secName,
      subName,
      firstName,
      midName,
      lastName);

  @override
  String toString() {
    return 'Remark(remarkId: $remarkId, remarkDesc: $remarkDesc, remarkSubject: $remarkSubject, remarkType: $remarkType, remarkDate: $remarkDate, className: $className, secName: $secName, subName: $subName, firstName: $firstName, midName: $midName, lastName: $lastName)';
  }
}

/// @nodoc
abstract mixin class _$RemarkCopyWith<$Res> implements $RemarkCopyWith<$Res> {
  factory _$RemarkCopyWith(_Remark value, $Res Function(_Remark) _then) =
      __$RemarkCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'remark_id') String remarkId,
      @JsonKey(name: 'remark_desc') String remarkDesc,
      @JsonKey(name: 'remark_subject') String remarkSubject,
      @JsonKey(name: 'remark_type') String remarkType,
      @JsonKey(name: 'remark_date') String remarkDate,
      @JsonKey(name: 'class_name') String className,
      @JsonKey(name: 'sec_name') String secName,
      @JsonKey(name: 'sub_name') String subName,
      @JsonKey(name: 'first_name') String firstName,
      @JsonKey(name: 'mid_name') String midName,
      @JsonKey(name: 'last_name') String lastName});
}

/// @nodoc
class __$RemarkCopyWithImpl<$Res> implements _$RemarkCopyWith<$Res> {
  __$RemarkCopyWithImpl(this._self, this._then);

  final _Remark _self;
  final $Res Function(_Remark) _then;

  /// Create a copy of Remark
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? remarkId = null,
    Object? remarkDesc = null,
    Object? remarkSubject = null,
    Object? remarkType = null,
    Object? remarkDate = null,
    Object? className = null,
    Object? secName = null,
    Object? subName = null,
    Object? firstName = null,
    Object? midName = null,
    Object? lastName = null,
  }) {
    return _then(_Remark(
      remarkId: null == remarkId
          ? _self.remarkId
          : remarkId // ignore: cast_nullable_to_non_nullable
              as String,
      remarkDesc: null == remarkDesc
          ? _self.remarkDesc
          : remarkDesc // ignore: cast_nullable_to_non_nullable
              as String,
      remarkSubject: null == remarkSubject
          ? _self.remarkSubject
          : remarkSubject // ignore: cast_nullable_to_non_nullable
              as String,
      remarkType: null == remarkType
          ? _self.remarkType
          : remarkType // ignore: cast_nullable_to_non_nullable
              as String,
      remarkDate: null == remarkDate
          ? _self.remarkDate
          : remarkDate // ignore: cast_nullable_to_non_nullable
              as String,
      className: null == className
          ? _self.className
          : className // ignore: cast_nullable_to_non_nullable
              as String,
      secName: null == secName
          ? _self.secName
          : secName // ignore: cast_nullable_to_non_nullable
              as String,
      subName: null == subName
          ? _self.subName
          : subName // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _self.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      midName: null == midName
          ? _self.midName
          : midName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _self.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
