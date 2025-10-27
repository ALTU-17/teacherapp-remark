// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'school_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SchoolDetails {
  @JsonKey(name: "setting_id")
  String? get settingId;
  @JsonKey(name: "institute_name")
  String? get instituteName;
  @JsonKey(name: "address")
  String? get address;
  @JsonKey(name: "phone_number")
  String? get phoneNumber;
  @JsonKey(name: "page_title")
  String? get pageTitle;
  @JsonKey(name: "page_meta_tag")
  String? get pageMetaTag;
  @JsonKey(name: "academic_yr_from")
  DateTime? get academicYrFrom;
  @JsonKey(name: "academic_yr_to")
  DateTime? get academicYrTo;
  @JsonKey(name: "academic_yr")
  String? get academicYr;
  @JsonKey(name: "active")
  String? get active;

  /// Create a copy of SchoolDetails
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SchoolDetailsCopyWith<SchoolDetails> get copyWith =>
      _$SchoolDetailsCopyWithImpl<SchoolDetails>(
          this as SchoolDetails, _$identity);

  /// Serializes this SchoolDetails to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SchoolDetails &&
            (identical(other.settingId, settingId) ||
                other.settingId == settingId) &&
            (identical(other.instituteName, instituteName) ||
                other.instituteName == instituteName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.pageTitle, pageTitle) ||
                other.pageTitle == pageTitle) &&
            (identical(other.pageMetaTag, pageMetaTag) ||
                other.pageMetaTag == pageMetaTag) &&
            (identical(other.academicYrFrom, academicYrFrom) ||
                other.academicYrFrom == academicYrFrom) &&
            (identical(other.academicYrTo, academicYrTo) ||
                other.academicYrTo == academicYrTo) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      settingId,
      instituteName,
      address,
      phoneNumber,
      pageTitle,
      pageMetaTag,
      academicYrFrom,
      academicYrTo,
      academicYr,
      active);

  @override
  String toString() {
    return 'SchoolDetails(settingId: $settingId, instituteName: $instituteName, address: $address, phoneNumber: $phoneNumber, pageTitle: $pageTitle, pageMetaTag: $pageMetaTag, academicYrFrom: $academicYrFrom, academicYrTo: $academicYrTo, academicYr: $academicYr, active: $active)';
  }
}

/// @nodoc
abstract mixin class $SchoolDetailsCopyWith<$Res> {
  factory $SchoolDetailsCopyWith(
          SchoolDetails value, $Res Function(SchoolDetails) _then) =
      _$SchoolDetailsCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "setting_id") String? settingId,
      @JsonKey(name: "institute_name") String? instituteName,
      @JsonKey(name: "address") String? address,
      @JsonKey(name: "phone_number") String? phoneNumber,
      @JsonKey(name: "page_title") String? pageTitle,
      @JsonKey(name: "page_meta_tag") String? pageMetaTag,
      @JsonKey(name: "academic_yr_from") DateTime? academicYrFrom,
      @JsonKey(name: "academic_yr_to") DateTime? academicYrTo,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "active") String? active});
}

/// @nodoc
class _$SchoolDetailsCopyWithImpl<$Res>
    implements $SchoolDetailsCopyWith<$Res> {
  _$SchoolDetailsCopyWithImpl(this._self, this._then);

  final SchoolDetails _self;
  final $Res Function(SchoolDetails) _then;

  /// Create a copy of SchoolDetails
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? settingId = freezed,
    Object? instituteName = freezed,
    Object? address = freezed,
    Object? phoneNumber = freezed,
    Object? pageTitle = freezed,
    Object? pageMetaTag = freezed,
    Object? academicYrFrom = freezed,
    Object? academicYrTo = freezed,
    Object? academicYr = freezed,
    Object? active = freezed,
  }) {
    return _then(_self.copyWith(
      settingId: freezed == settingId
          ? _self.settingId
          : settingId // ignore: cast_nullable_to_non_nullable
              as String?,
      instituteName: freezed == instituteName
          ? _self.instituteName
          : instituteName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      pageTitle: freezed == pageTitle
          ? _self.pageTitle
          : pageTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      pageMetaTag: freezed == pageMetaTag
          ? _self.pageMetaTag
          : pageMetaTag // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYrFrom: freezed == academicYrFrom
          ? _self.academicYrFrom
          : academicYrFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      academicYrTo: freezed == academicYrTo
          ? _self.academicYrTo
          : academicYrTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _self.active
          : active // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SchoolDetails].
extension SchoolDetailsPatterns on SchoolDetails {
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
    TResult Function(_SchoolDetails value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SchoolDetails() when $default != null:
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
    TResult Function(_SchoolDetails value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SchoolDetails():
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
    TResult? Function(_SchoolDetails value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SchoolDetails() when $default != null:
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
            @JsonKey(name: "setting_id") String? settingId,
            @JsonKey(name: "institute_name") String? instituteName,
            @JsonKey(name: "address") String? address,
            @JsonKey(name: "phone_number") String? phoneNumber,
            @JsonKey(name: "page_title") String? pageTitle,
            @JsonKey(name: "page_meta_tag") String? pageMetaTag,
            @JsonKey(name: "academic_yr_from") DateTime? academicYrFrom,
            @JsonKey(name: "academic_yr_to") DateTime? academicYrTo,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "active") String? active)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SchoolDetails() when $default != null:
        return $default(
            _that.settingId,
            _that.instituteName,
            _that.address,
            _that.phoneNumber,
            _that.pageTitle,
            _that.pageMetaTag,
            _that.academicYrFrom,
            _that.academicYrTo,
            _that.academicYr,
            _that.active);
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
            @JsonKey(name: "setting_id") String? settingId,
            @JsonKey(name: "institute_name") String? instituteName,
            @JsonKey(name: "address") String? address,
            @JsonKey(name: "phone_number") String? phoneNumber,
            @JsonKey(name: "page_title") String? pageTitle,
            @JsonKey(name: "page_meta_tag") String? pageMetaTag,
            @JsonKey(name: "academic_yr_from") DateTime? academicYrFrom,
            @JsonKey(name: "academic_yr_to") DateTime? academicYrTo,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "active") String? active)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SchoolDetails():
        return $default(
            _that.settingId,
            _that.instituteName,
            _that.address,
            _that.phoneNumber,
            _that.pageTitle,
            _that.pageMetaTag,
            _that.academicYrFrom,
            _that.academicYrTo,
            _that.academicYr,
            _that.active);
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
            @JsonKey(name: "setting_id") String? settingId,
            @JsonKey(name: "institute_name") String? instituteName,
            @JsonKey(name: "address") String? address,
            @JsonKey(name: "phone_number") String? phoneNumber,
            @JsonKey(name: "page_title") String? pageTitle,
            @JsonKey(name: "page_meta_tag") String? pageMetaTag,
            @JsonKey(name: "academic_yr_from") DateTime? academicYrFrom,
            @JsonKey(name: "academic_yr_to") DateTime? academicYrTo,
            @JsonKey(name: "academic_yr") String? academicYr,
            @JsonKey(name: "active") String? active)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SchoolDetails() when $default != null:
        return $default(
            _that.settingId,
            _that.instituteName,
            _that.address,
            _that.phoneNumber,
            _that.pageTitle,
            _that.pageMetaTag,
            _that.academicYrFrom,
            _that.academicYrTo,
            _that.academicYr,
            _that.active);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _SchoolDetails implements SchoolDetails {
  const _SchoolDetails(
      {@JsonKey(name: "setting_id") this.settingId,
      @JsonKey(name: "institute_name") this.instituteName,
      @JsonKey(name: "address") this.address,
      @JsonKey(name: "phone_number") this.phoneNumber,
      @JsonKey(name: "page_title") this.pageTitle,
      @JsonKey(name: "page_meta_tag") this.pageMetaTag,
      @JsonKey(name: "academic_yr_from") this.academicYrFrom,
      @JsonKey(name: "academic_yr_to") this.academicYrTo,
      @JsonKey(name: "academic_yr") this.academicYr,
      @JsonKey(name: "active") this.active});
  factory _SchoolDetails.fromJson(Map<String, dynamic> json) =>
      _$SchoolDetailsFromJson(json);

  @override
  @JsonKey(name: "setting_id")
  final String? settingId;
  @override
  @JsonKey(name: "institute_name")
  final String? instituteName;
  @override
  @JsonKey(name: "address")
  final String? address;
  @override
  @JsonKey(name: "phone_number")
  final String? phoneNumber;
  @override
  @JsonKey(name: "page_title")
  final String? pageTitle;
  @override
  @JsonKey(name: "page_meta_tag")
  final String? pageMetaTag;
  @override
  @JsonKey(name: "academic_yr_from")
  final DateTime? academicYrFrom;
  @override
  @JsonKey(name: "academic_yr_to")
  final DateTime? academicYrTo;
  @override
  @JsonKey(name: "academic_yr")
  final String? academicYr;
  @override
  @JsonKey(name: "active")
  final String? active;

  /// Create a copy of SchoolDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SchoolDetailsCopyWith<_SchoolDetails> get copyWith =>
      __$SchoolDetailsCopyWithImpl<_SchoolDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$SchoolDetailsToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SchoolDetails &&
            (identical(other.settingId, settingId) ||
                other.settingId == settingId) &&
            (identical(other.instituteName, instituteName) ||
                other.instituteName == instituteName) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.pageTitle, pageTitle) ||
                other.pageTitle == pageTitle) &&
            (identical(other.pageMetaTag, pageMetaTag) ||
                other.pageMetaTag == pageMetaTag) &&
            (identical(other.academicYrFrom, academicYrFrom) ||
                other.academicYrFrom == academicYrFrom) &&
            (identical(other.academicYrTo, academicYrTo) ||
                other.academicYrTo == academicYrTo) &&
            (identical(other.academicYr, academicYr) ||
                other.academicYr == academicYr) &&
            (identical(other.active, active) || other.active == active));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      settingId,
      instituteName,
      address,
      phoneNumber,
      pageTitle,
      pageMetaTag,
      academicYrFrom,
      academicYrTo,
      academicYr,
      active);

  @override
  String toString() {
    return 'SchoolDetails(settingId: $settingId, instituteName: $instituteName, address: $address, phoneNumber: $phoneNumber, pageTitle: $pageTitle, pageMetaTag: $pageMetaTag, academicYrFrom: $academicYrFrom, academicYrTo: $academicYrTo, academicYr: $academicYr, active: $active)';
  }
}

/// @nodoc
abstract mixin class _$SchoolDetailsCopyWith<$Res>
    implements $SchoolDetailsCopyWith<$Res> {
  factory _$SchoolDetailsCopyWith(
          _SchoolDetails value, $Res Function(_SchoolDetails) _then) =
      __$SchoolDetailsCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "setting_id") String? settingId,
      @JsonKey(name: "institute_name") String? instituteName,
      @JsonKey(name: "address") String? address,
      @JsonKey(name: "phone_number") String? phoneNumber,
      @JsonKey(name: "page_title") String? pageTitle,
      @JsonKey(name: "page_meta_tag") String? pageMetaTag,
      @JsonKey(name: "academic_yr_from") DateTime? academicYrFrom,
      @JsonKey(name: "academic_yr_to") DateTime? academicYrTo,
      @JsonKey(name: "academic_yr") String? academicYr,
      @JsonKey(name: "active") String? active});
}

/// @nodoc
class __$SchoolDetailsCopyWithImpl<$Res>
    implements _$SchoolDetailsCopyWith<$Res> {
  __$SchoolDetailsCopyWithImpl(this._self, this._then);

  final _SchoolDetails _self;
  final $Res Function(_SchoolDetails) _then;

  /// Create a copy of SchoolDetails
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? settingId = freezed,
    Object? instituteName = freezed,
    Object? address = freezed,
    Object? phoneNumber = freezed,
    Object? pageTitle = freezed,
    Object? pageMetaTag = freezed,
    Object? academicYrFrom = freezed,
    Object? academicYrTo = freezed,
    Object? academicYr = freezed,
    Object? active = freezed,
  }) {
    return _then(_SchoolDetails(
      settingId: freezed == settingId
          ? _self.settingId
          : settingId // ignore: cast_nullable_to_non_nullable
              as String?,
      instituteName: freezed == instituteName
          ? _self.instituteName
          : instituteName // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _self.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      pageTitle: freezed == pageTitle
          ? _self.pageTitle
          : pageTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      pageMetaTag: freezed == pageMetaTag
          ? _self.pageMetaTag
          : pageMetaTag // ignore: cast_nullable_to_non_nullable
              as String?,
      academicYrFrom: freezed == academicYrFrom
          ? _self.academicYrFrom
          : academicYrFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      academicYrTo: freezed == academicYrTo
          ? _self.academicYrTo
          : academicYrTo // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      academicYr: freezed == academicYr
          ? _self.academicYr
          : academicYr // ignore: cast_nullable_to_non_nullable
              as String?,
      active: freezed == active
          ? _self.active
          : active // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
