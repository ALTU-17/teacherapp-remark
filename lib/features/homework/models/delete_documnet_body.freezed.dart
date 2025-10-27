// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'delete_documnet_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeleteDocumentBody {
  @JsonKey(name: 'upload_date')
  String? get uploadDate;
  @JsonKey(name: 'random_no')
  String? get randomNo;
  @JsonKey(name: 'short_name')
  String? get shortName;
  @JsonKey(name: 'doc_type_folder')
  String? get docTypeFolder;
  String? get filename;

  /// Create a copy of DeleteDocumentBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DeleteDocumentBodyCopyWith<DeleteDocumentBody> get copyWith =>
      _$DeleteDocumentBodyCopyWithImpl<DeleteDocumentBody>(
          this as DeleteDocumentBody, _$identity);

  /// Serializes this DeleteDocumentBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DeleteDocumentBody &&
            (identical(other.uploadDate, uploadDate) ||
                other.uploadDate == uploadDate) &&
            (identical(other.randomNo, randomNo) ||
                other.randomNo == randomNo) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.docTypeFolder, docTypeFolder) ||
                other.docTypeFolder == docTypeFolder) &&
            (identical(other.filename, filename) ||
                other.filename == filename));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, uploadDate, randomNo, shortName, docTypeFolder, filename);

  @override
  String toString() {
    return 'DeleteDocumentBody(uploadDate: $uploadDate, randomNo: $randomNo, shortName: $shortName, docTypeFolder: $docTypeFolder, filename: $filename)';
  }
}

/// @nodoc
abstract mixin class $DeleteDocumentBodyCopyWith<$Res> {
  factory $DeleteDocumentBodyCopyWith(
          DeleteDocumentBody value, $Res Function(DeleteDocumentBody) _then) =
      _$DeleteDocumentBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'upload_date') String? uploadDate,
      @JsonKey(name: 'random_no') String? randomNo,
      @JsonKey(name: 'short_name') String? shortName,
      @JsonKey(name: 'doc_type_folder') String? docTypeFolder,
      String? filename});
}

/// @nodoc
class _$DeleteDocumentBodyCopyWithImpl<$Res>
    implements $DeleteDocumentBodyCopyWith<$Res> {
  _$DeleteDocumentBodyCopyWithImpl(this._self, this._then);

  final DeleteDocumentBody _self;
  final $Res Function(DeleteDocumentBody) _then;

  /// Create a copy of DeleteDocumentBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uploadDate = freezed,
    Object? randomNo = freezed,
    Object? shortName = freezed,
    Object? docTypeFolder = freezed,
    Object? filename = freezed,
  }) {
    return _then(_self.copyWith(
      uploadDate: freezed == uploadDate
          ? _self.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as String?,
      randomNo: freezed == randomNo
          ? _self.randomNo
          : randomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      docTypeFolder: freezed == docTypeFolder
          ? _self.docTypeFolder
          : docTypeFolder // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: freezed == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DeleteDocumentBody].
extension DeleteDocumentBodyPatterns on DeleteDocumentBody {
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
    TResult Function(_DeleteDocumentBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeleteDocumentBody() when $default != null:
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
    TResult Function(_DeleteDocumentBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeleteDocumentBody():
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
    TResult? Function(_DeleteDocumentBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeleteDocumentBody() when $default != null:
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
            @JsonKey(name: 'upload_date') String? uploadDate,
            @JsonKey(name: 'random_no') String? randomNo,
            @JsonKey(name: 'short_name') String? shortName,
            @JsonKey(name: 'doc_type_folder') String? docTypeFolder,
            String? filename)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DeleteDocumentBody() when $default != null:
        return $default(_that.uploadDate, _that.randomNo, _that.shortName,
            _that.docTypeFolder, _that.filename);
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
            @JsonKey(name: 'upload_date') String? uploadDate,
            @JsonKey(name: 'random_no') String? randomNo,
            @JsonKey(name: 'short_name') String? shortName,
            @JsonKey(name: 'doc_type_folder') String? docTypeFolder,
            String? filename)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeleteDocumentBody():
        return $default(_that.uploadDate, _that.randomNo, _that.shortName,
            _that.docTypeFolder, _that.filename);
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
            @JsonKey(name: 'upload_date') String? uploadDate,
            @JsonKey(name: 'random_no') String? randomNo,
            @JsonKey(name: 'short_name') String? shortName,
            @JsonKey(name: 'doc_type_folder') String? docTypeFolder,
            String? filename)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DeleteDocumentBody() when $default != null:
        return $default(_that.uploadDate, _that.randomNo, _that.shortName,
            _that.docTypeFolder, _that.filename);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DeleteDocumentBody implements DeleteDocumentBody {
  const _DeleteDocumentBody(
      {@JsonKey(name: 'upload_date') this.uploadDate,
      @JsonKey(name: 'random_no') this.randomNo,
      @JsonKey(name: 'short_name') this.shortName,
      @JsonKey(name: 'doc_type_folder') this.docTypeFolder,
      this.filename});
  factory _DeleteDocumentBody.fromJson(Map<String, dynamic> json) =>
      _$DeleteDocumentBodyFromJson(json);

  @override
  @JsonKey(name: 'upload_date')
  final String? uploadDate;
  @override
  @JsonKey(name: 'random_no')
  final String? randomNo;
  @override
  @JsonKey(name: 'short_name')
  final String? shortName;
  @override
  @JsonKey(name: 'doc_type_folder')
  final String? docTypeFolder;
  @override
  final String? filename;

  /// Create a copy of DeleteDocumentBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeleteDocumentBodyCopyWith<_DeleteDocumentBody> get copyWith =>
      __$DeleteDocumentBodyCopyWithImpl<_DeleteDocumentBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DeleteDocumentBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeleteDocumentBody &&
            (identical(other.uploadDate, uploadDate) ||
                other.uploadDate == uploadDate) &&
            (identical(other.randomNo, randomNo) ||
                other.randomNo == randomNo) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.docTypeFolder, docTypeFolder) ||
                other.docTypeFolder == docTypeFolder) &&
            (identical(other.filename, filename) ||
                other.filename == filename));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, uploadDate, randomNo, shortName, docTypeFolder, filename);

  @override
  String toString() {
    return 'DeleteDocumentBody(uploadDate: $uploadDate, randomNo: $randomNo, shortName: $shortName, docTypeFolder: $docTypeFolder, filename: $filename)';
  }
}

/// @nodoc
abstract mixin class _$DeleteDocumentBodyCopyWith<$Res>
    implements $DeleteDocumentBodyCopyWith<$Res> {
  factory _$DeleteDocumentBodyCopyWith(
          _DeleteDocumentBody value, $Res Function(_DeleteDocumentBody) _then) =
      __$DeleteDocumentBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'upload_date') String? uploadDate,
      @JsonKey(name: 'random_no') String? randomNo,
      @JsonKey(name: 'short_name') String? shortName,
      @JsonKey(name: 'doc_type_folder') String? docTypeFolder,
      String? filename});
}

/// @nodoc
class __$DeleteDocumentBodyCopyWithImpl<$Res>
    implements _$DeleteDocumentBodyCopyWith<$Res> {
  __$DeleteDocumentBodyCopyWithImpl(this._self, this._then);

  final _DeleteDocumentBody _self;
  final $Res Function(_DeleteDocumentBody) _then;

  /// Create a copy of DeleteDocumentBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uploadDate = freezed,
    Object? randomNo = freezed,
    Object? shortName = freezed,
    Object? docTypeFolder = freezed,
    Object? filename = freezed,
  }) {
    return _then(_DeleteDocumentBody(
      uploadDate: freezed == uploadDate
          ? _self.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as String?,
      randomNo: freezed == randomNo
          ? _self.randomNo
          : randomNo // ignore: cast_nullable_to_non_nullable
              as String?,
      shortName: freezed == shortName
          ? _self.shortName
          : shortName // ignore: cast_nullable_to_non_nullable
              as String?,
      docTypeFolder: freezed == docTypeFolder
          ? _self.docTypeFolder
          : docTypeFolder // ignore: cast_nullable_to_non_nullable
              as String?,
      filename: freezed == filename
          ? _self.filename
          : filename // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
