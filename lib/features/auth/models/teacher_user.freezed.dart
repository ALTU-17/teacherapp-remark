// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teacher_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TeacherUser {
  @HiveField(0)
  @JsonKey(name: "teacher_verification")
  TeacherVerification? get teacherVerification;
  @HiveField(2)
  @JsonKey(name: "error")
  bool? get error;
  @HiveField(3)
  @JsonKey(name: "reg_id")
  String? get regId;
  @HiveField(4)
  @JsonKey(name: "password")
  String? get password;
  @HiveField(5)
  @JsonKey(name: "default_pwd")
  String? get defaultPwd;
  @HiveField(6)
  @JsonKey(name: "name")
  String? get name;
  @HiveField(7)
  @JsonKey(name: "user_id")
  String? get userId;
  @HiveField(8)
  @JsonKey(name: "role_id")
  String? get roleId;
  @HiveField(9)
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @HiveField(10)
  @JsonKey(name: "teacher_details")
  TeacherDetails? get teacherDetails;
  @HiveField(11)
  PunchInOut? get punc;

  /// Create a copy of TeacherUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TeacherUserCopyWith<TeacherUser> get copyWith =>
      _$TeacherUserCopyWithImpl<TeacherUser>(this as TeacherUser, _$identity);

  /// Serializes this TeacherUser to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TeacherUser &&
            (identical(other.teacherVerification, teacherVerification) ||
                other.teacherVerification == teacherVerification) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.defaultPwd, defaultPwd) ||
                other.defaultPwd == defaultPwd) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.roleId, roleId) || other.roleId == roleId) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.teacherDetails, teacherDetails) ||
                other.teacherDetails == teacherDetails) &&
            (identical(other.punc, punc) || other.punc == punc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      teacherVerification,
      error,
      regId,
      password,
      defaultPwd,
      name,
      userId,
      roleId,
      academicYr,
      teacherDetails,
      punc);

  @override
  String toString() {
    return 'TeacherUser(teacherVerification: $teacherVerification, error: $error, regId: $regId, password: $password, defaultPwd: $defaultPwd, name: $name, userId: $userId, roleId: $roleId, academicYr: $academicYr, teacherDetails: $teacherDetails, punc: $punc)';
  }
}

/// @nodoc
abstract mixin class $TeacherUserCopyWith<$Res> {
  factory $TeacherUserCopyWith(
          TeacherUser value, $Res Function(TeacherUser) _then) =
      _$TeacherUserCopyWithImpl;
  @useResult
  $Res call(
      {@HiveField(0)
      @JsonKey(name: "teacher_verification")
      TeacherVerification? teacherVerification,
      @HiveField(2) @JsonKey(name: "error") bool? error,
      @HiveField(3) @JsonKey(name: "reg_id") String? regId,
      @HiveField(4) @JsonKey(name: "password") String? password,
      @HiveField(5) @JsonKey(name: "default_pwd") String? defaultPwd,
      @HiveField(6) @JsonKey(name: "name") String? name,
      @HiveField(7) @JsonKey(name: "user_id") String? userId,
      @HiveField(8) @JsonKey(name: "role_id") String? roleId,
      @HiveField(9) @JsonKey(name: "academic_yr") String? academicYr,
      @HiveField(10)
      @JsonKey(name: "teacher_details")
      TeacherDetails? teacherDetails,
      @HiveField(11) PunchInOut? punc});

  $TeacherVerificationCopyWith<$Res>? get teacherVerification;
  $TeacherDetailsCopyWith<$Res>? get teacherDetails;
  $PunchInOutCopyWith<$Res>? get punc;
}

/// @nodoc
class _$TeacherUserCopyWithImpl<$Res> implements $TeacherUserCopyWith<$Res> {
  _$TeacherUserCopyWithImpl(this._self, this._then);

  final TeacherUser _self;
  final $Res Function(TeacherUser) _then;

  /// Create a copy of TeacherUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teacherVerification = freezed,
    Object? error = freezed,
    Object? regId = freezed,
    Object? password = freezed,
    Object? defaultPwd = freezed,
    Object? name = freezed,
    Object? userId = freezed,
    Object? roleId = freezed,
    Object? academicYr = freezed,
    Object? teacherDetails = freezed,
    Object? punc = freezed,
  }) {
    return _then(_self.copyWith(
      teacherVerification: freezed == teacherVerification
          ? _self.teacherVerification
          : teacherVerification // ignore: cast_nullable_to_non_nullable
              as TeacherVerification?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool?,
      regId: freezed == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultPwd: freezed == defaultPwd
          ? _self.defaultPwd
          : defaultPwd // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      roleId: freezed == roleId
          ? _self.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherDetails: freezed == teacherDetails
          ? _self.teacherDetails
          : teacherDetails // ignore: cast_nullable_to_non_nullable
              as TeacherDetails?,
      punc: freezed == punc
          ? _self.punc
          : punc // ignore: cast_nullable_to_non_nullable
              as PunchInOut?,
    ));
  }

  /// Create a copy of TeacherUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeacherVerificationCopyWith<$Res>? get teacherVerification {
    if (_self.teacherVerification == null) {
      return null;
    }

    return $TeacherVerificationCopyWith<$Res>(_self.teacherVerification!,
        (value) {
      return _then(_self.copyWith(teacherVerification: value));
    });
  }

  /// Create a copy of TeacherUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeacherDetailsCopyWith<$Res>? get teacherDetails {
    if (_self.teacherDetails == null) {
      return null;
    }

    return $TeacherDetailsCopyWith<$Res>(_self.teacherDetails!, (value) {
      return _then(_self.copyWith(teacherDetails: value));
    });
  }

  /// Create a copy of TeacherUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PunchInOutCopyWith<$Res>? get punc {
    if (_self.punc == null) {
      return null;
    }

    return $PunchInOutCopyWith<$Res>(_self.punc!, (value) {
      return _then(_self.copyWith(punc: value));
    });
  }
}

/// Adds pattern-matching-related methods to [TeacherUser].
extension TeacherUserPatterns on TeacherUser {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TeacherUser value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TeacherUser() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TeacherUser value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TeacherUser():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TeacherUser value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TeacherUser() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @HiveField(0)
            @JsonKey(name: "teacher_verification")
            TeacherVerification? teacherVerification,
            @HiveField(2) @JsonKey(name: "error") bool? error,
            @HiveField(3) @JsonKey(name: "reg_id") String? regId,
            @HiveField(4) @JsonKey(name: "password") String? password,
            @HiveField(5) @JsonKey(name: "default_pwd") String? defaultPwd,
            @HiveField(6) @JsonKey(name: "name") String? name,
            @HiveField(7) @JsonKey(name: "user_id") String? userId,
            @HiveField(8) @JsonKey(name: "role_id") String? roleId,
            @HiveField(9) @JsonKey(name: "academic_yr") String? academicYr,
            @HiveField(10)
            @JsonKey(name: "teacher_details")
            TeacherDetails? teacherDetails,
            @HiveField(11) PunchInOut? punc)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TeacherUser() when $default != null:
        return $default(
            _that.teacherVerification,
            _that.error,
            _that.regId,
            _that.password,
            _that.defaultPwd,
            _that.name,
            _that.userId,
            _that.roleId,
            _that.academicYr,
            _that.teacherDetails,
            _that.punc);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @HiveField(0)
            @JsonKey(name: "teacher_verification")
            TeacherVerification? teacherVerification,
            @HiveField(2) @JsonKey(name: "error") bool? error,
            @HiveField(3) @JsonKey(name: "reg_id") String? regId,
            @HiveField(4) @JsonKey(name: "password") String? password,
            @HiveField(5) @JsonKey(name: "default_pwd") String? defaultPwd,
            @HiveField(6) @JsonKey(name: "name") String? name,
            @HiveField(7) @JsonKey(name: "user_id") String? userId,
            @HiveField(8) @JsonKey(name: "role_id") String? roleId,
            @HiveField(9) @JsonKey(name: "academic_yr") String? academicYr,
            @HiveField(10)
            @JsonKey(name: "teacher_details")
            TeacherDetails? teacherDetails,
            @HiveField(11) PunchInOut? punc)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TeacherUser():
        return $default(
            _that.teacherVerification,
            _that.error,
            _that.regId,
            _that.password,
            _that.defaultPwd,
            _that.name,
            _that.userId,
            _that.roleId,
            _that.academicYr,
            _that.teacherDetails,
            _that.punc);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @HiveField(0)
            @JsonKey(name: "teacher_verification")
            TeacherVerification? teacherVerification,
            @HiveField(2) @JsonKey(name: "error") bool? error,
            @HiveField(3) @JsonKey(name: "reg_id") String? regId,
            @HiveField(4) @JsonKey(name: "password") String? password,
            @HiveField(5) @JsonKey(name: "default_pwd") String? defaultPwd,
            @HiveField(6) @JsonKey(name: "name") String? name,
            @HiveField(7) @JsonKey(name: "user_id") String? userId,
            @HiveField(8) @JsonKey(name: "role_id") String? roleId,
            @HiveField(9) @JsonKey(name: "academic_yr") String? academicYr,
            @HiveField(10)
            @JsonKey(name: "teacher_details")
            TeacherDetails? teacherDetails,
            @HiveField(11) PunchInOut? punc)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TeacherUser() when $default != null:
        return $default(
            _that.teacherVerification,
            _that.error,
            _that.regId,
            _that.password,
            _that.defaultPwd,
            _that.name,
            _that.userId,
            _that.roleId,
            _that.academicYr,
            _that.teacherDetails,
            _that.punc);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1, adapterName: 'TeacherUserAdapter')
class _TeacherUser implements TeacherUser {
  const _TeacherUser(
      {@HiveField(0)
      @JsonKey(name: "teacher_verification")
      this.teacherVerification,
      @HiveField(2) @JsonKey(name: "error") this.error,
      @HiveField(3) @JsonKey(name: "reg_id") this.regId,
      @HiveField(4) @JsonKey(name: "password") this.password,
      @HiveField(5) @JsonKey(name: "default_pwd") this.defaultPwd,
      @HiveField(6) @JsonKey(name: "name") this.name,
      @HiveField(7) @JsonKey(name: "user_id") this.userId,
      @HiveField(8) @JsonKey(name: "role_id") this.roleId,
      @HiveField(9) @JsonKey(name: "academic_yr") this.academicYr,
      @HiveField(10) @JsonKey(name: "teacher_details") this.teacherDetails,
      @HiveField(11) this.punc});
  factory _TeacherUser.fromJson(Map<String, dynamic> json) =>
      _$TeacherUserFromJson(json);

  @override
  @HiveField(0)
  @JsonKey(name: "teacher_verification")
  final TeacherVerification? teacherVerification;
  @override
  @HiveField(2)
  @JsonKey(name: "error")
  final bool? error;
  @override
  @HiveField(3)
  @JsonKey(name: "reg_id")
  final String? regId;
  @override
  @HiveField(4)
  @JsonKey(name: "password")
  final String? password;
  @override
  @HiveField(5)
  @JsonKey(name: "default_pwd")
  final String? defaultPwd;
  @override
  @HiveField(6)
  @JsonKey(name: "name")
  final String? name;
  @override
  @HiveField(7)
  @JsonKey(name: "user_id")
  final String? userId;
  @override
  @HiveField(8)
  @JsonKey(name: "role_id")
  final String? roleId;
  @override
  @HiveField(9)
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @HiveField(10)
  @JsonKey(name: "teacher_details")
  final TeacherDetails? teacherDetails;
  @override
  @HiveField(11)
  final PunchInOut? punc;

  /// Create a copy of TeacherUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TeacherUserCopyWith<_TeacherUser> get copyWith =>
      __$TeacherUserCopyWithImpl<_TeacherUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TeacherUserToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TeacherUser &&
            (identical(other.teacherVerification, teacherVerification) ||
                other.teacherVerification == teacherVerification) &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.defaultPwd, defaultPwd) ||
                other.defaultPwd == defaultPwd) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.roleId, roleId) || other.roleId == roleId) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.teacherDetails, teacherDetails) ||
                other.teacherDetails == teacherDetails) &&
            (identical(other.punc, punc) || other.punc == punc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      teacherVerification,
      error,
      regId,
      password,
      defaultPwd,
      name,
      userId,
      roleId,
      academicYr,
      teacherDetails,
      punc);

  @override
  String toString() {
    return 'TeacherUser(teacherVerification: $teacherVerification, error: $error, regId: $regId, password: $password, defaultPwd: $defaultPwd, name: $name, userId: $userId, roleId: $roleId, academicYr: $academicYr, teacherDetails: $teacherDetails, punc: $punc)';
  }
}

/// @nodoc
abstract mixin class _$TeacherUserCopyWith<$Res>
    implements $TeacherUserCopyWith<$Res> {
  factory _$TeacherUserCopyWith(
          _TeacherUser value, $Res Function(_TeacherUser) _then) =
      __$TeacherUserCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@HiveField(0)
      @JsonKey(name: "teacher_verification")
      TeacherVerification? teacherVerification,
      @HiveField(2) @JsonKey(name: "error") bool? error,
      @HiveField(3) @JsonKey(name: "reg_id") String? regId,
      @HiveField(4) @JsonKey(name: "password") String? password,
      @HiveField(5) @JsonKey(name: "default_pwd") String? defaultPwd,
      @HiveField(6) @JsonKey(name: "name") String? name,
      @HiveField(7) @JsonKey(name: "user_id") String? userId,
      @HiveField(8) @JsonKey(name: "role_id") String? roleId,
      @HiveField(9) @JsonKey(name: "academic_yr") String? academicYr,
      @HiveField(10)
      @JsonKey(name: "teacher_details")
      TeacherDetails? teacherDetails,
      @HiveField(11) PunchInOut? punc});

  @override
  $TeacherVerificationCopyWith<$Res>? get teacherVerification;
  @override
  $TeacherDetailsCopyWith<$Res>? get teacherDetails;
  @override
  $PunchInOutCopyWith<$Res>? get punc;
}

/// @nodoc
class __$TeacherUserCopyWithImpl<$Res> implements _$TeacherUserCopyWith<$Res> {
  __$TeacherUserCopyWithImpl(this._self, this._then);

  final _TeacherUser _self;
  final $Res Function(_TeacherUser) _then;

  /// Create a copy of TeacherUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? teacherVerification = freezed,
    Object? error = freezed,
    Object? regId = freezed,
    Object? password = freezed,
    Object? defaultPwd = freezed,
    Object? name = freezed,
    Object? userId = freezed,
    Object? roleId = freezed,
    Object? academicYr = freezed,
    Object? teacherDetails = freezed,
    Object? punc = freezed,
  }) {
    return _then(_TeacherUser(
      teacherVerification: freezed == teacherVerification
          ? _self.teacherVerification
          : teacherVerification // ignore: cast_nullable_to_non_nullable
              as TeacherVerification?,
      error: freezed == error
          ? _self.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool?,
      regId: freezed == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _self.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      defaultPwd: freezed == defaultPwd
          ? _self.defaultPwd
          : defaultPwd // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      roleId: freezed == roleId
          ? _self.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherDetails: freezed == teacherDetails
          ? _self.teacherDetails
          : teacherDetails // ignore: cast_nullable_to_non_nullable
              as TeacherDetails?,
      punc: freezed == punc
          ? _self.punc
          : punc // ignore: cast_nullable_to_non_nullable
              as PunchInOut?,
    ));
  }

  /// Create a copy of TeacherUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeacherVerificationCopyWith<$Res>? get teacherVerification {
    if (_self.teacherVerification == null) {
      return null;
    }

    return $TeacherVerificationCopyWith<$Res>(_self.teacherVerification!,
        (value) {
      return _then(_self.copyWith(teacherVerification: value));
    });
  }

  /// Create a copy of TeacherUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TeacherDetailsCopyWith<$Res>? get teacherDetails {
    if (_self.teacherDetails == null) {
      return null;
    }

    return $TeacherDetailsCopyWith<$Res>(_self.teacherDetails!, (value) {
      return _then(_self.copyWith(teacherDetails: value));
    });
  }

  /// Create a copy of TeacherUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PunchInOutCopyWith<$Res>? get punc {
    if (_self.punc == null) {
      return null;
    }

    return $PunchInOutCopyWith<$Res>(_self.punc!, (value) {
      return _then(_self.copyWith(punc: value));
    });
  }
}

/// @nodoc
mixin _$TeacherDetails {
  @HiveField(0)
  @JsonKey(name: 'teacher_id')
  String? get teacherId;
  @HiveField(1)
  @JsonKey(name: 'employee_id')
  String? get employeeId;
  @HiveField(2)
  @JsonKey(name: 'name')
  String? get name;
  @HiveField(3)
  @JsonKey(name: 'father_spouse_name')
  String? get fatherSpouseName;
  @HiveField(4)
  @JsonKey(name: 'birthday')
  String? get birthday;
  @HiveField(5)
  @JsonKey(name: 'date_of_joining')
  String? get dateOfJoining;
  @HiveField(6)
  @JsonKey(name: 'sex')
  String? get sex;
  @HiveField(7)
  @JsonKey(name: 'religion')
  String? get religion;
  @HiveField(8)
  @JsonKey(name: 'blood_group')
  String? get bloodGroup;
  @HiveField(9)
  @JsonKey(name: 'address')
  String? get address;
  @HiveField(10)
  @JsonKey(name: 'phone')
  String? get phone;
  @HiveField(11)
  @JsonKey(name: 'email')
  String? get email;
  @HiveField(12)
  @JsonKey(name: 'designation')
  String? get designation;
  @HiveField(13)
  @JsonKey(name: 'academic_qual')
  String? get academicQual;
  @HiveField(14)
  @JsonKey(name: 'professional_qual')
  String? get professionalQual;
  @HiveField(15)
  @JsonKey(name: 'special_sub')
  String? get specialSub;
  @HiveField(16)
  @JsonKey(name: 'trained')
  String? get trained;
  @HiveField(17)
  @JsonKey(name: 'experience')
  String? get experience;
  @HiveField(18)
  @JsonKey(name: 'aadhar_card_no')
  String? get aadharCardNo;
  @HiveField(19)
  @JsonKey(name: 'teacher_image_name')
  String? get teacherImageName;
  @HiveField(20)
  @JsonKey(name: 'class_id')
  String? get classId;
  @HiveField(21)
  @JsonKey(name: 'section_id')
  String? get sectionId;
  @HiveField(22)
  @JsonKey(name: 'tc_id')
  String? get tcId;
  @HiveField(23)
  @JsonKey(name: 'isDelete')
  String? get isDelete;
  @HiveField(24)
  @JsonKey(name: 'role_id')
  String? get roleId;
  @HiveField(25)
  @JsonKey(name: 'user_id')
  String? get userId;
  @HiveField(26)
  @JsonKey(name: "status")
  bool? get status;
  @HiveField(27)
  @JsonKey(name: "gender")
  String? get gender;
  @HiveField(28)
  @JsonKey(name: "teacher_name")
  String? get teacherName; //TODO IGNORE THE BUTTOM FILEDS ON FORM
  @HiveField(29)
  @JsonKey(name: "class")
  List<ClassInfo>? get classs;
  @HiveField(30)
  @JsonKey(name: "operation")
  String? get operation;
  @HiveField(31)
  @JsonKey(name: "short_name")
  String? get shortName;
  @HiveField(32)
  @JsonKey(name: "reg_id")
  String? get regId;
  @HiveField(33)
  @JsonKey(name: 'str_array')
  String? get strArray;

  /// Create a copy of TeacherDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TeacherDetailsCopyWith<TeacherDetails> get copyWith =>
      _$TeacherDetailsCopyWithImpl<TeacherDetails>(
          this as TeacherDetails, _$identity);

  /// Serializes this TeacherDetails to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TeacherDetails &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fatherSpouseName, fatherSpouseName) ||
                other.fatherSpouseName == fatherSpouseName) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.dateOfJoining, dateOfJoining) ||
                other.dateOfJoining == dateOfJoining) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.religion, religion) ||
                other.religion == religion) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.academicQual, academicQual) ||
                other.academicQual == academicQual) &&
            (identical(other.professionalQual, professionalQual) ||
                other.professionalQual == professionalQual) &&
            (identical(other.specialSub, specialSub) ||
                other.specialSub == specialSub) &&
            (identical(other.trained, trained) || other.trained == trained) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.aadharCardNo, aadharCardNo) ||
                other.aadharCardNo == aadharCardNo) &&
            (identical(other.teacherImageName, teacherImageName) ||
                other.teacherImageName == teacherImageName) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            (identical(other.roleId, roleId) || other.roleId == roleId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.teacherName, teacherName) ||
                other.teacherName == teacherName) &&
            const DeepCollectionEquality().equals(other.classs, classs) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.strArray, strArray) ||
                other.strArray == strArray));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        teacherId,
        employeeId,
        name,
        fatherSpouseName,
        birthday,
        dateOfJoining,
        sex,
        religion,
        bloodGroup,
        address,
        phone,
        email,
        designation,
        academicQual,
        professionalQual,
        specialSub,
        trained,
        experience,
        aadharCardNo,
        teacherImageName,
        classId,
        sectionId,
        tcId,
        isDelete,
        roleId,
        userId,
        status,
        gender,
        teacherName,
        const DeepCollectionEquality().hash(classs),
        operation,
        shortName,
        regId,
        strArray
      ]);

  @override
  String toString() {
    return 'TeacherDetails(teacherId: $teacherId, employeeId: $employeeId, name: $name, fatherSpouseName: $fatherSpouseName, birthday: $birthday, dateOfJoining: $dateOfJoining, sex: $sex, religion: $religion, bloodGroup: $bloodGroup, address: $address, phone: $phone, email: $email, designation: $designation, academicQual: $academicQual, professionalQual: $professionalQual, specialSub: $specialSub, trained: $trained, experience: $experience, aadharCardNo: $aadharCardNo, teacherImageName: $teacherImageName, classId: $classId, sectionId: $sectionId, tcId: $tcId, isDelete: $isDelete, roleId: $roleId, userId: $userId, status: $status, gender: $gender, teacherName: $teacherName, classs: $classs, operation: $operation, shortName: $shortName, regId: $regId, strArray: $strArray)';
  }
}

/// @nodoc
abstract mixin class $TeacherDetailsCopyWith<$Res> {
  factory $TeacherDetailsCopyWith(
          TeacherDetails value, $Res Function(TeacherDetails) _then) =
      _$TeacherDetailsCopyWithImpl;
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: 'teacher_id') String? teacherId,
      @HiveField(1) @JsonKey(name: 'employee_id') String? employeeId,
      @HiveField(2) @JsonKey(name: 'name') String? name,
      @HiveField(3)
      @JsonKey(name: 'father_spouse_name')
      String? fatherSpouseName,
      @HiveField(4) @JsonKey(name: 'birthday') String? birthday,
      @HiveField(5) @JsonKey(name: 'date_of_joining') String? dateOfJoining,
      @HiveField(6) @JsonKey(name: 'sex') String? sex,
      @HiveField(7) @JsonKey(name: 'religion') String? religion,
      @HiveField(8) @JsonKey(name: 'blood_group') String? bloodGroup,
      @HiveField(9) @JsonKey(name: 'address') String? address,
      @HiveField(10) @JsonKey(name: 'phone') String? phone,
      @HiveField(11) @JsonKey(name: 'email') String? email,
      @HiveField(12) @JsonKey(name: 'designation') String? designation,
      @HiveField(13) @JsonKey(name: 'academic_qual') String? academicQual,
      @HiveField(14)
      @JsonKey(name: 'professional_qual')
      String? professionalQual,
      @HiveField(15) @JsonKey(name: 'special_sub') String? specialSub,
      @HiveField(16) @JsonKey(name: 'trained') String? trained,
      @HiveField(17) @JsonKey(name: 'experience') String? experience,
      @HiveField(18) @JsonKey(name: 'aadhar_card_no') String? aadharCardNo,
      @HiveField(19)
      @JsonKey(name: 'teacher_image_name')
      String? teacherImageName,
      @HiveField(20) @JsonKey(name: 'class_id') String? classId,
      @HiveField(21) @JsonKey(name: 'section_id') String? sectionId,
      @HiveField(22) @JsonKey(name: 'tc_id') String? tcId,
      @HiveField(23) @JsonKey(name: 'isDelete') String? isDelete,
      @HiveField(24) @JsonKey(name: 'role_id') String? roleId,
      @HiveField(25) @JsonKey(name: 'user_id') String? userId,
      @HiveField(26) @JsonKey(name: "status") bool? status,
      @HiveField(27) @JsonKey(name: "gender") String? gender,
      @HiveField(28) @JsonKey(name: "teacher_name") String? teacherName,
      @HiveField(29) @JsonKey(name: "class") List<ClassInfo>? classs,
      @HiveField(30) @JsonKey(name: "operation") String? operation,
      @HiveField(31) @JsonKey(name: "short_name") String? shortName,
      @HiveField(32) @JsonKey(name: "reg_id") String? regId,
      @HiveField(33) @JsonKey(name: 'str_array') String? strArray});
}

/// @nodoc
class _$TeacherDetailsCopyWithImpl<$Res>
    implements $TeacherDetailsCopyWith<$Res> {
  _$TeacherDetailsCopyWithImpl(this._self, this._then);

  final TeacherDetails _self;
  final $Res Function(TeacherDetails) _then;

  /// Create a copy of TeacherDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teacherId = freezed,
    Object? employeeId = freezed,
    Object? name = freezed,
    Object? fatherSpouseName = freezed,
    Object? birthday = freezed,
    Object? dateOfJoining = freezed,
    Object? sex = freezed,
    Object? religion = freezed,
    Object? bloodGroup = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? designation = freezed,
    Object? academicQual = freezed,
    Object? professionalQual = freezed,
    Object? specialSub = freezed,
    Object? trained = freezed,
    Object? experience = freezed,
    Object? aadharCardNo = freezed,
    Object? teacherImageName = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? tcId = freezed,
    Object? isDelete = freezed,
    Object? roleId = freezed,
    Object? userId = freezed,
    Object? status = freezed,
    Object? gender = freezed,
    Object? teacherName = freezed,
    Object? classs = freezed,
    Object? operation = freezed,
    Object? shortName = freezed,
    Object? regId = freezed,
    Object? strArray = freezed,
  }) {
    return _then(_self.copyWith(
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeId: freezed == employeeId
          ? _self.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      fatherSpouseName: freezed == fatherSpouseName
          ? _self.fatherSpouseName
          : fatherSpouseName // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _self.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfJoining: freezed == dateOfJoining
          ? _self.dateOfJoining
          : dateOfJoining // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _self.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String?,
      religion: freezed == religion
          ? _self.religion
          : religion // ignore: cast_nullable_to_non_nullable
              as String?,
      bloodGroup: freezed == bloodGroup
          ? _self.bloodGroup
          : bloodGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      designation: freezed == designation
          ? _self.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      academicQual: freezed == academicQual
          ? _self.academicQual
          : academicQual // ignore: cast_nullable_to_non_nullable
              as String?,
      professionalQual: freezed == professionalQual
          ? _self.professionalQual
          : professionalQual // ignore: cast_nullable_to_non_nullable
              as String?,
      specialSub: freezed == specialSub
          ? _self.specialSub
          : specialSub // ignore: cast_nullable_to_non_nullable
              as String?,
      trained: freezed == trained
          ? _self.trained
          : trained // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _self.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String?,
      aadharCardNo: freezed == aadharCardNo
          ? _self.aadharCardNo
          : aadharCardNo // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherImageName: freezed == teacherImageName
          ? _self.teacherImageName
          : teacherImageName // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      tcId: freezed == tcId
          ? _self.tcId
          : tcId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: freezed == isDelete
          ? _self.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as String?,
      roleId: freezed == roleId
          ? _self.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      gender: freezed == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherName: freezed == teacherName
          ? _self.teacherName
          : teacherName // ignore: cast_nullable_to_non_nullable
              as String?,
      classs: freezed == classs
          ? _self.classs
          : classs // ignore: cast_nullable_to_non_nullable
              as List<ClassInfo>?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      regId: freezed == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String?,
      strArray: freezed == strArray
          ? _self.strArray
          : strArray // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [TeacherDetails].
extension TeacherDetailsPatterns on TeacherDetails {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_TeacherDetails value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TeacherDetails() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_TeacherDetails value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TeacherDetails():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_TeacherDetails value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TeacherDetails() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @HiveField(0) @JsonKey(name: 'teacher_id') String? teacherId,
            @HiveField(1) @JsonKey(name: 'employee_id') String? employeeId,
            @HiveField(2) @JsonKey(name: 'name') String? name,
            @HiveField(3)
            @JsonKey(name: 'father_spouse_name')
            String? fatherSpouseName,
            @HiveField(4) @JsonKey(name: 'birthday') String? birthday,
            @HiveField(5)
            @JsonKey(name: 'date_of_joining')
            String? dateOfJoining,
            @HiveField(6) @JsonKey(name: 'sex') String? sex,
            @HiveField(7) @JsonKey(name: 'religion') String? religion,
            @HiveField(8) @JsonKey(name: 'blood_group') String? bloodGroup,
            @HiveField(9) @JsonKey(name: 'address') String? address,
            @HiveField(10) @JsonKey(name: 'phone') String? phone,
            @HiveField(11) @JsonKey(name: 'email') String? email,
            @HiveField(12) @JsonKey(name: 'designation') String? designation,
            @HiveField(13) @JsonKey(name: 'academic_qual') String? academicQual,
            @HiveField(14)
            @JsonKey(name: 'professional_qual')
            String? professionalQual,
            @HiveField(15) @JsonKey(name: 'special_sub') String? specialSub,
            @HiveField(16) @JsonKey(name: 'trained') String? trained,
            @HiveField(17) @JsonKey(name: 'experience') String? experience,
            @HiveField(18)
            @JsonKey(name: 'aadhar_card_no')
            String? aadharCardNo,
            @HiveField(19)
            @JsonKey(name: 'teacher_image_name')
            String? teacherImageName,
            @HiveField(20) @JsonKey(name: 'class_id') String? classId,
            @HiveField(21) @JsonKey(name: 'section_id') String? sectionId,
            @HiveField(22) @JsonKey(name: 'tc_id') String? tcId,
            @HiveField(23) @JsonKey(name: 'isDelete') String? isDelete,
            @HiveField(24) @JsonKey(name: 'role_id') String? roleId,
            @HiveField(25) @JsonKey(name: 'user_id') String? userId,
            @HiveField(26) @JsonKey(name: "status") bool? status,
            @HiveField(27) @JsonKey(name: "gender") String? gender,
            @HiveField(28) @JsonKey(name: "teacher_name") String? teacherName,
            @HiveField(29) @JsonKey(name: "class") List<ClassInfo>? classs,
            @HiveField(30) @JsonKey(name: "operation") String? operation,
            @HiveField(31) @JsonKey(name: "short_name") String? shortName,
            @HiveField(32) @JsonKey(name: "reg_id") String? regId,
            @HiveField(33) @JsonKey(name: 'str_array') String? strArray)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _TeacherDetails() when $default != null:
        return $default(
            _that.teacherId,
            _that.employeeId,
            _that.name,
            _that.fatherSpouseName,
            _that.birthday,
            _that.dateOfJoining,
            _that.sex,
            _that.religion,
            _that.bloodGroup,
            _that.address,
            _that.phone,
            _that.email,
            _that.designation,
            _that.academicQual,
            _that.professionalQual,
            _that.specialSub,
            _that.trained,
            _that.experience,
            _that.aadharCardNo,
            _that.teacherImageName,
            _that.classId,
            _that.sectionId,
            _that.tcId,
            _that.isDelete,
            _that.roleId,
            _that.userId,
            _that.status,
            _that.gender,
            _that.teacherName,
            _that.classs,
            _that.operation,
            _that.shortName,
            _that.regId,
            _that.strArray);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @HiveField(0) @JsonKey(name: 'teacher_id') String? teacherId,
            @HiveField(1) @JsonKey(name: 'employee_id') String? employeeId,
            @HiveField(2) @JsonKey(name: 'name') String? name,
            @HiveField(3)
            @JsonKey(name: 'father_spouse_name')
            String? fatherSpouseName,
            @HiveField(4) @JsonKey(name: 'birthday') String? birthday,
            @HiveField(5)
            @JsonKey(name: 'date_of_joining')
            String? dateOfJoining,
            @HiveField(6) @JsonKey(name: 'sex') String? sex,
            @HiveField(7) @JsonKey(name: 'religion') String? religion,
            @HiveField(8) @JsonKey(name: 'blood_group') String? bloodGroup,
            @HiveField(9) @JsonKey(name: 'address') String? address,
            @HiveField(10) @JsonKey(name: 'phone') String? phone,
            @HiveField(11) @JsonKey(name: 'email') String? email,
            @HiveField(12) @JsonKey(name: 'designation') String? designation,
            @HiveField(13) @JsonKey(name: 'academic_qual') String? academicQual,
            @HiveField(14)
            @JsonKey(name: 'professional_qual')
            String? professionalQual,
            @HiveField(15) @JsonKey(name: 'special_sub') String? specialSub,
            @HiveField(16) @JsonKey(name: 'trained') String? trained,
            @HiveField(17) @JsonKey(name: 'experience') String? experience,
            @HiveField(18)
            @JsonKey(name: 'aadhar_card_no')
            String? aadharCardNo,
            @HiveField(19)
            @JsonKey(name: 'teacher_image_name')
            String? teacherImageName,
            @HiveField(20) @JsonKey(name: 'class_id') String? classId,
            @HiveField(21) @JsonKey(name: 'section_id') String? sectionId,
            @HiveField(22) @JsonKey(name: 'tc_id') String? tcId,
            @HiveField(23) @JsonKey(name: 'isDelete') String? isDelete,
            @HiveField(24) @JsonKey(name: 'role_id') String? roleId,
            @HiveField(25) @JsonKey(name: 'user_id') String? userId,
            @HiveField(26) @JsonKey(name: "status") bool? status,
            @HiveField(27) @JsonKey(name: "gender") String? gender,
            @HiveField(28) @JsonKey(name: "teacher_name") String? teacherName,
            @HiveField(29) @JsonKey(name: "class") List<ClassInfo>? classs,
            @HiveField(30) @JsonKey(name: "operation") String? operation,
            @HiveField(31) @JsonKey(name: "short_name") String? shortName,
            @HiveField(32) @JsonKey(name: "reg_id") String? regId,
            @HiveField(33) @JsonKey(name: 'str_array') String? strArray)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TeacherDetails():
        return $default(
            _that.teacherId,
            _that.employeeId,
            _that.name,
            _that.fatherSpouseName,
            _that.birthday,
            _that.dateOfJoining,
            _that.sex,
            _that.religion,
            _that.bloodGroup,
            _that.address,
            _that.phone,
            _that.email,
            _that.designation,
            _that.academicQual,
            _that.professionalQual,
            _that.specialSub,
            _that.trained,
            _that.experience,
            _that.aadharCardNo,
            _that.teacherImageName,
            _that.classId,
            _that.sectionId,
            _that.tcId,
            _that.isDelete,
            _that.roleId,
            _that.userId,
            _that.status,
            _that.gender,
            _that.teacherName,
            _that.classs,
            _that.operation,
            _that.shortName,
            _that.regId,
            _that.strArray);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @HiveField(0) @JsonKey(name: 'teacher_id') String? teacherId,
            @HiveField(1) @JsonKey(name: 'employee_id') String? employeeId,
            @HiveField(2) @JsonKey(name: 'name') String? name,
            @HiveField(3)
            @JsonKey(name: 'father_spouse_name')
            String? fatherSpouseName,
            @HiveField(4) @JsonKey(name: 'birthday') String? birthday,
            @HiveField(5)
            @JsonKey(name: 'date_of_joining')
            String? dateOfJoining,
            @HiveField(6) @JsonKey(name: 'sex') String? sex,
            @HiveField(7) @JsonKey(name: 'religion') String? religion,
            @HiveField(8) @JsonKey(name: 'blood_group') String? bloodGroup,
            @HiveField(9) @JsonKey(name: 'address') String? address,
            @HiveField(10) @JsonKey(name: 'phone') String? phone,
            @HiveField(11) @JsonKey(name: 'email') String? email,
            @HiveField(12) @JsonKey(name: 'designation') String? designation,
            @HiveField(13) @JsonKey(name: 'academic_qual') String? academicQual,
            @HiveField(14)
            @JsonKey(name: 'professional_qual')
            String? professionalQual,
            @HiveField(15) @JsonKey(name: 'special_sub') String? specialSub,
            @HiveField(16) @JsonKey(name: 'trained') String? trained,
            @HiveField(17) @JsonKey(name: 'experience') String? experience,
            @HiveField(18)
            @JsonKey(name: 'aadhar_card_no')
            String? aadharCardNo,
            @HiveField(19)
            @JsonKey(name: 'teacher_image_name')
            String? teacherImageName,
            @HiveField(20) @JsonKey(name: 'class_id') String? classId,
            @HiveField(21) @JsonKey(name: 'section_id') String? sectionId,
            @HiveField(22) @JsonKey(name: 'tc_id') String? tcId,
            @HiveField(23) @JsonKey(name: 'isDelete') String? isDelete,
            @HiveField(24) @JsonKey(name: 'role_id') String? roleId,
            @HiveField(25) @JsonKey(name: 'user_id') String? userId,
            @HiveField(26) @JsonKey(name: "status") bool? status,
            @HiveField(27) @JsonKey(name: "gender") String? gender,
            @HiveField(28) @JsonKey(name: "teacher_name") String? teacherName,
            @HiveField(29) @JsonKey(name: "class") List<ClassInfo>? classs,
            @HiveField(30) @JsonKey(name: "operation") String? operation,
            @HiveField(31) @JsonKey(name: "short_name") String? shortName,
            @HiveField(32) @JsonKey(name: "reg_id") String? regId,
            @HiveField(33) @JsonKey(name: 'str_array') String? strArray)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _TeacherDetails() when $default != null:
        return $default(
            _that.teacherId,
            _that.employeeId,
            _that.name,
            _that.fatherSpouseName,
            _that.birthday,
            _that.dateOfJoining,
            _that.sex,
            _that.religion,
            _that.bloodGroup,
            _that.address,
            _that.phone,
            _that.email,
            _that.designation,
            _that.academicQual,
            _that.professionalQual,
            _that.specialSub,
            _that.trained,
            _that.experience,
            _that.aadharCardNo,
            _that.teacherImageName,
            _that.classId,
            _that.sectionId,
            _that.tcId,
            _that.isDelete,
            _that.roleId,
            _that.userId,
            _that.status,
            _that.gender,
            _that.teacherName,
            _that.classs,
            _that.operation,
            _that.shortName,
            _that.regId,
            _that.strArray);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 2, adapterName: 'TeacherDetailsAdapter')
class _TeacherDetails implements TeacherDetails {
  const _TeacherDetails(
      {@HiveField(0) @JsonKey(name: 'teacher_id') this.teacherId,
      @HiveField(1) @JsonKey(name: 'employee_id') this.employeeId,
      @HiveField(2) @JsonKey(name: 'name') this.name,
      @HiveField(3) @JsonKey(name: 'father_spouse_name') this.fatherSpouseName,
      @HiveField(4) @JsonKey(name: 'birthday') this.birthday,
      @HiveField(5) @JsonKey(name: 'date_of_joining') this.dateOfJoining,
      @HiveField(6) @JsonKey(name: 'sex') this.sex,
      @HiveField(7) @JsonKey(name: 'religion') this.religion,
      @HiveField(8) @JsonKey(name: 'blood_group') this.bloodGroup,
      @HiveField(9) @JsonKey(name: 'address') this.address,
      @HiveField(10) @JsonKey(name: 'phone') this.phone,
      @HiveField(11) @JsonKey(name: 'email') this.email,
      @HiveField(12) @JsonKey(name: 'designation') this.designation,
      @HiveField(13) @JsonKey(name: 'academic_qual') this.academicQual,
      @HiveField(14) @JsonKey(name: 'professional_qual') this.professionalQual,
      @HiveField(15) @JsonKey(name: 'special_sub') this.specialSub,
      @HiveField(16) @JsonKey(name: 'trained') this.trained,
      @HiveField(17) @JsonKey(name: 'experience') this.experience,
      @HiveField(18) @JsonKey(name: 'aadhar_card_no') this.aadharCardNo,
      @HiveField(19) @JsonKey(name: 'teacher_image_name') this.teacherImageName,
      @HiveField(20) @JsonKey(name: 'class_id') this.classId,
      @HiveField(21) @JsonKey(name: 'section_id') this.sectionId,
      @HiveField(22) @JsonKey(name: 'tc_id') this.tcId,
      @HiveField(23) @JsonKey(name: 'isDelete') this.isDelete,
      @HiveField(24) @JsonKey(name: 'role_id') this.roleId,
      @HiveField(25) @JsonKey(name: 'user_id') this.userId,
      @HiveField(26) @JsonKey(name: "status") this.status,
      @HiveField(27) @JsonKey(name: "gender") this.gender,
      @HiveField(28) @JsonKey(name: "teacher_name") this.teacherName,
      @HiveField(29) @JsonKey(name: "class") final List<ClassInfo>? classs,
      @HiveField(30) @JsonKey(name: "operation") this.operation,
      @HiveField(31) @JsonKey(name: "short_name") this.shortName,
      @HiveField(32) @JsonKey(name: "reg_id") this.regId,
      @HiveField(33) @JsonKey(name: 'str_array') this.strArray})
      : _classs = classs;
  factory _TeacherDetails.fromJson(Map<String, dynamic> json) =>
      _$TeacherDetailsFromJson(json);

  @override
  @HiveField(0)
  @JsonKey(name: 'teacher_id')
  final String? teacherId;
  @override
  @HiveField(1)
  @JsonKey(name: 'employee_id')
  final String? employeeId;
  @override
  @HiveField(2)
  @JsonKey(name: 'name')
  final String? name;
  @override
  @HiveField(3)
  @JsonKey(name: 'father_spouse_name')
  final String? fatherSpouseName;
  @override
  @HiveField(4)
  @JsonKey(name: 'birthday')
  final String? birthday;
  @override
  @HiveField(5)
  @JsonKey(name: 'date_of_joining')
  final String? dateOfJoining;
  @override
  @HiveField(6)
  @JsonKey(name: 'sex')
  final String? sex;
  @override
  @HiveField(7)
  @JsonKey(name: 'religion')
  final String? religion;
  @override
  @HiveField(8)
  @JsonKey(name: 'blood_group')
  final String? bloodGroup;
  @override
  @HiveField(9)
  @JsonKey(name: 'address')
  final String? address;
  @override
  @HiveField(10)
  @JsonKey(name: 'phone')
  final String? phone;
  @override
  @HiveField(11)
  @JsonKey(name: 'email')
  final String? email;
  @override
  @HiveField(12)
  @JsonKey(name: 'designation')
  final String? designation;
  @override
  @HiveField(13)
  @JsonKey(name: 'academic_qual')
  final String? academicQual;
  @override
  @HiveField(14)
  @JsonKey(name: 'professional_qual')
  final String? professionalQual;
  @override
  @HiveField(15)
  @JsonKey(name: 'special_sub')
  final String? specialSub;
  @override
  @HiveField(16)
  @JsonKey(name: 'trained')
  final String? trained;
  @override
  @HiveField(17)
  @JsonKey(name: 'experience')
  final String? experience;
  @override
  @HiveField(18)
  @JsonKey(name: 'aadhar_card_no')
  final String? aadharCardNo;
  @override
  @HiveField(19)
  @JsonKey(name: 'teacher_image_name')
  final String? teacherImageName;
  @override
  @HiveField(20)
  @JsonKey(name: 'class_id')
  final String? classId;
  @override
  @HiveField(21)
  @JsonKey(name: 'section_id')
  final String? sectionId;
  @override
  @HiveField(22)
  @JsonKey(name: 'tc_id')
  final String? tcId;
  @override
  @HiveField(23)
  @JsonKey(name: 'isDelete')
  final String? isDelete;
  @override
  @HiveField(24)
  @JsonKey(name: 'role_id')
  final String? roleId;
  @override
  @HiveField(25)
  @JsonKey(name: 'user_id')
  final String? userId;
  @override
  @HiveField(26)
  @JsonKey(name: "status")
  final bool? status;
  @override
  @HiveField(27)
  @JsonKey(name: "gender")
  final String? gender;
  @override
  @HiveField(28)
  @JsonKey(name: "teacher_name")
  final String? teacherName;
//TODO IGNORE THE BUTTOM FILEDS ON FORM
  final List<ClassInfo>? _classs;
//TODO IGNORE THE BUTTOM FILEDS ON FORM
  @override
  @HiveField(29)
  @JsonKey(name: "class")
  List<ClassInfo>? get classs {
    final value = _classs;
    if (value == null) return null;
    if (_classs is EqualUnmodifiableListView) return _classs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @HiveField(30)
  @JsonKey(name: "operation")
  final String? operation;
  @override
  @HiveField(31)
  @JsonKey(name: "short_name")
  final String? shortName;
  @override
  @HiveField(32)
  @JsonKey(name: "reg_id")
  final String? regId;
  @override
  @HiveField(33)
  @JsonKey(name: 'str_array')
  final String? strArray;

  /// Create a copy of TeacherDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TeacherDetailsCopyWith<_TeacherDetails> get copyWith =>
      __$TeacherDetailsCopyWithImpl<_TeacherDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TeacherDetailsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TeacherDetails &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.employeeId, employeeId) ||
                other.employeeId == employeeId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.fatherSpouseName, fatherSpouseName) ||
                other.fatherSpouseName == fatherSpouseName) &&
            (identical(other.birthday, birthday) ||
                other.birthday == birthday) &&
            (identical(other.dateOfJoining, dateOfJoining) ||
                other.dateOfJoining == dateOfJoining) &&
            (identical(other.sex, sex) || other.sex == sex) &&
            (identical(other.religion, religion) ||
                other.religion == religion) &&
            (identical(other.bloodGroup, bloodGroup) ||
                other.bloodGroup == bloodGroup) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.designation, designation) ||
                other.designation == designation) &&
            (identical(other.academicQual, academicQual) ||
                other.academicQual == academicQual) &&
            (identical(other.professionalQual, professionalQual) ||
                other.professionalQual == professionalQual) &&
            (identical(other.specialSub, specialSub) ||
                other.specialSub == specialSub) &&
            (identical(other.trained, trained) || other.trained == trained) &&
            (identical(other.experience, experience) ||
                other.experience == experience) &&
            (identical(other.aadharCardNo, aadharCardNo) ||
                other.aadharCardNo == aadharCardNo) &&
            (identical(other.teacherImageName, teacherImageName) ||
                other.teacherImageName == teacherImageName) &&
            (identical(other.classId, classId) || other.classId == classId) &&
            (identical(other.sectionId, sectionId) ||
                other.sectionId == sectionId) &&
            (identical(other.tcId, tcId) || other.tcId == tcId) &&
            (identical(other.isDelete, isDelete) ||
                other.isDelete == isDelete) &&
            (identical(other.roleId, roleId) || other.roleId == roleId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.teacherName, teacherName) ||
                other.teacherName == teacherName) &&
            const DeepCollectionEquality().equals(other._classs, _classs) &&
            (identical(other.operation, operation) ||
                other.operation == operation) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.regId, regId) || other.regId == regId) &&
            (identical(other.strArray, strArray) ||
                other.strArray == strArray));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        teacherId,
        employeeId,
        name,
        fatherSpouseName,
        birthday,
        dateOfJoining,
        sex,
        religion,
        bloodGroup,
        address,
        phone,
        email,
        designation,
        academicQual,
        professionalQual,
        specialSub,
        trained,
        experience,
        aadharCardNo,
        teacherImageName,
        classId,
        sectionId,
        tcId,
        isDelete,
        roleId,
        userId,
        status,
        gender,
        teacherName,
        const DeepCollectionEquality().hash(_classs),
        operation,
        shortName,
        regId,
        strArray
      ]);

  @override
  String toString() {
    return 'TeacherDetails(teacherId: $teacherId, employeeId: $employeeId, name: $name, fatherSpouseName: $fatherSpouseName, birthday: $birthday, dateOfJoining: $dateOfJoining, sex: $sex, religion: $religion, bloodGroup: $bloodGroup, address: $address, phone: $phone, email: $email, designation: $designation, academicQual: $academicQual, professionalQual: $professionalQual, specialSub: $specialSub, trained: $trained, experience: $experience, aadharCardNo: $aadharCardNo, teacherImageName: $teacherImageName, classId: $classId, sectionId: $sectionId, tcId: $tcId, isDelete: $isDelete, roleId: $roleId, userId: $userId, status: $status, gender: $gender, teacherName: $teacherName, classs: $classs, operation: $operation, shortName: $shortName, regId: $regId, strArray: $strArray)';
  }
}

/// @nodoc
abstract mixin class _$TeacherDetailsCopyWith<$Res>
    implements $TeacherDetailsCopyWith<$Res> {
  factory _$TeacherDetailsCopyWith(
          _TeacherDetails value, $Res Function(_TeacherDetails) _then) =
      __$TeacherDetailsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@HiveField(0) @JsonKey(name: 'teacher_id') String? teacherId,
      @HiveField(1) @JsonKey(name: 'employee_id') String? employeeId,
      @HiveField(2) @JsonKey(name: 'name') String? name,
      @HiveField(3)
      @JsonKey(name: 'father_spouse_name')
      String? fatherSpouseName,
      @HiveField(4) @JsonKey(name: 'birthday') String? birthday,
      @HiveField(5) @JsonKey(name: 'date_of_joining') String? dateOfJoining,
      @HiveField(6) @JsonKey(name: 'sex') String? sex,
      @HiveField(7) @JsonKey(name: 'religion') String? religion,
      @HiveField(8) @JsonKey(name: 'blood_group') String? bloodGroup,
      @HiveField(9) @JsonKey(name: 'address') String? address,
      @HiveField(10) @JsonKey(name: 'phone') String? phone,
      @HiveField(11) @JsonKey(name: 'email') String? email,
      @HiveField(12) @JsonKey(name: 'designation') String? designation,
      @HiveField(13) @JsonKey(name: 'academic_qual') String? academicQual,
      @HiveField(14)
      @JsonKey(name: 'professional_qual')
      String? professionalQual,
      @HiveField(15) @JsonKey(name: 'special_sub') String? specialSub,
      @HiveField(16) @JsonKey(name: 'trained') String? trained,
      @HiveField(17) @JsonKey(name: 'experience') String? experience,
      @HiveField(18) @JsonKey(name: 'aadhar_card_no') String? aadharCardNo,
      @HiveField(19)
      @JsonKey(name: 'teacher_image_name')
      String? teacherImageName,
      @HiveField(20) @JsonKey(name: 'class_id') String? classId,
      @HiveField(21) @JsonKey(name: 'section_id') String? sectionId,
      @HiveField(22) @JsonKey(name: 'tc_id') String? tcId,
      @HiveField(23) @JsonKey(name: 'isDelete') String? isDelete,
      @HiveField(24) @JsonKey(name: 'role_id') String? roleId,
      @HiveField(25) @JsonKey(name: 'user_id') String? userId,
      @HiveField(26) @JsonKey(name: "status") bool? status,
      @HiveField(27) @JsonKey(name: "gender") String? gender,
      @HiveField(28) @JsonKey(name: "teacher_name") String? teacherName,
      @HiveField(29) @JsonKey(name: "class") List<ClassInfo>? classs,
      @HiveField(30) @JsonKey(name: "operation") String? operation,
      @HiveField(31) @JsonKey(name: "short_name") String? shortName,
      @HiveField(32) @JsonKey(name: "reg_id") String? regId,
      @HiveField(33) @JsonKey(name: 'str_array') String? strArray});
}

/// @nodoc
class __$TeacherDetailsCopyWithImpl<$Res>
    implements _$TeacherDetailsCopyWith<$Res> {
  __$TeacherDetailsCopyWithImpl(this._self, this._then);

  final _TeacherDetails _self;
  final $Res Function(_TeacherDetails) _then;

  /// Create a copy of TeacherDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? teacherId = freezed,
    Object? employeeId = freezed,
    Object? name = freezed,
    Object? fatherSpouseName = freezed,
    Object? birthday = freezed,
    Object? dateOfJoining = freezed,
    Object? sex = freezed,
    Object? religion = freezed,
    Object? bloodGroup = freezed,
    Object? address = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? designation = freezed,
    Object? academicQual = freezed,
    Object? professionalQual = freezed,
    Object? specialSub = freezed,
    Object? trained = freezed,
    Object? experience = freezed,
    Object? aadharCardNo = freezed,
    Object? teacherImageName = freezed,
    Object? classId = freezed,
    Object? sectionId = freezed,
    Object? tcId = freezed,
    Object? isDelete = freezed,
    Object? roleId = freezed,
    Object? userId = freezed,
    Object? status = freezed,
    Object? gender = freezed,
    Object? teacherName = freezed,
    Object? classs = freezed,
    Object? operation = freezed,
    Object? shortName = freezed,
    Object? regId = freezed,
    Object? strArray = freezed,
  }) {
    return _then(_TeacherDetails(
      teacherId: freezed == teacherId
          ? _self.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      employeeId: freezed == employeeId
          ? _self.employeeId
          : employeeId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      fatherSpouseName: freezed == fatherSpouseName
          ? _self.fatherSpouseName
          : fatherSpouseName // ignore: cast_nullable_to_non_nullable
              as String?,
      birthday: freezed == birthday
          ? _self.birthday
          : birthday // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfJoining: freezed == dateOfJoining
          ? _self.dateOfJoining
          : dateOfJoining // ignore: cast_nullable_to_non_nullable
              as String?,
      sex: freezed == sex
          ? _self.sex
          : sex // ignore: cast_nullable_to_non_nullable
              as String?,
      religion: freezed == religion
          ? _self.religion
          : religion // ignore: cast_nullable_to_non_nullable
              as String?,
      bloodGroup: freezed == bloodGroup
          ? _self.bloodGroup
          : bloodGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      designation: freezed == designation
          ? _self.designation
          : designation // ignore: cast_nullable_to_non_nullable
              as String?,
      academicQual: freezed == academicQual
          ? _self.academicQual
          : academicQual // ignore: cast_nullable_to_non_nullable
              as String?,
      professionalQual: freezed == professionalQual
          ? _self.professionalQual
          : professionalQual // ignore: cast_nullable_to_non_nullable
              as String?,
      specialSub: freezed == specialSub
          ? _self.specialSub
          : specialSub // ignore: cast_nullable_to_non_nullable
              as String?,
      trained: freezed == trained
          ? _self.trained
          : trained // ignore: cast_nullable_to_non_nullable
              as String?,
      experience: freezed == experience
          ? _self.experience
          : experience // ignore: cast_nullable_to_non_nullable
              as String?,
      aadharCardNo: freezed == aadharCardNo
          ? _self.aadharCardNo
          : aadharCardNo // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherImageName: freezed == teacherImageName
          ? _self.teacherImageName
          : teacherImageName // ignore: cast_nullable_to_non_nullable
              as String?,
      classId: freezed == classId
          ? _self.classId
          : classId // ignore: cast_nullable_to_non_nullable
              as String?,
      sectionId: freezed == sectionId
          ? _self.sectionId
          : sectionId // ignore: cast_nullable_to_non_nullable
              as String?,
      tcId: freezed == tcId
          ? _self.tcId
          : tcId // ignore: cast_nullable_to_non_nullable
              as String?,
      isDelete: freezed == isDelete
          ? _self.isDelete
          : isDelete // ignore: cast_nullable_to_non_nullable
              as String?,
      roleId: freezed == roleId
          ? _self.roleId
          : roleId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _self.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      gender: freezed == gender
          ? _self.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherName: freezed == teacherName
          ? _self.teacherName
          : teacherName // ignore: cast_nullable_to_non_nullable
              as String?,
      classs: freezed == classs
          ? _self._classs
          : classs // ignore: cast_nullable_to_non_nullable
              as List<ClassInfo>?,
      operation: freezed == operation
          ? _self.operation
          : operation // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      regId: freezed == regId
          ? _self.regId
          : regId // ignore: cast_nullable_to_non_nullable
              as String?,
      strArray: freezed == strArray
          ? _self.strArray
          : strArray // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
