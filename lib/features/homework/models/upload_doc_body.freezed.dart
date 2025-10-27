// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_doc_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadDocBody {
  @JsonKey(name: "upload_date")
  String? get uploadDate;
  @JsonKey(name: "homework_id")
  String? get homeworkId;
  @JsonKey(name: "random_no")
  String? get randomNo;
  @JsonKey(name: "short_name")
  String? get shortName;
  @JsonKey(name: "doc_type_folder")
  String? get docTypeFolder;
  @JsonKey(name: "filename")
  String? get filename;
  @JsonKey(name: "datafile")
  String? get datafile;
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<PlatformFile>? get files;

  /// Create a copy of UploadDocBody
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UploadDocBodyCopyWith<UploadDocBody> get copyWith =>
      _$UploadDocBodyCopyWithImpl<UploadDocBody>(
          this as UploadDocBody, _$identity);

  /// Serializes this UploadDocBody to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UploadDocBody &&
            (identical(other.uploadDate, uploadDate) ||
                other.uploadDate == uploadDate) &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.randomNo, randomNo) ||
                other.randomNo == randomNo) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.docTypeFolder, docTypeFolder) ||
                other.docTypeFolder == docTypeFolder) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.datafile, datafile) ||
                other.datafile == datafile) &&
            const DeepCollectionEquality().equals(other.files, files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uploadDate,
      homeworkId,
      randomNo,
      shortName,
      docTypeFolder,
      filename,
      datafile,
      const DeepCollectionEquality().hash(files));

  @override
  String toString() {
    return 'UploadDocBody(uploadDate: $uploadDate, homeworkId: $homeworkId, randomNo: $randomNo, shortName: $shortName, docTypeFolder: $docTypeFolder, filename: $filename, datafile: $datafile, files: $files)';
  }
}

/// @nodoc
abstract mixin class $UploadDocBodyCopyWith<$Res> {
  factory $UploadDocBodyCopyWith(
          UploadDocBody value, $Res Function(UploadDocBody) _then) =
      _$UploadDocBodyCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "upload_date") String? uploadDate,
      @JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "random_no") String? randomNo,
      @JsonKey(name: "short_name") String? shortName,
      @JsonKey(name: "doc_type_folder") String? docTypeFolder,
      @JsonKey(name: "filename") String? filename,
      @JsonKey(name: "datafile") String? datafile,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<PlatformFile>? files});
}

/// @nodoc
class _$UploadDocBodyCopyWithImpl<$Res>
    implements $UploadDocBodyCopyWith<$Res> {
  _$UploadDocBodyCopyWithImpl(this._self, this._then);

  final UploadDocBody _self;
  final $Res Function(UploadDocBody) _then;

  /// Create a copy of UploadDocBody
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uploadDate = freezed,
    Object? homeworkId = freezed,
    Object? randomNo = freezed,
    Object? shortName = freezed,
    Object? docTypeFolder = freezed,
    Object? filename = freezed,
    Object? datafile = freezed,
    Object? files = freezed,
  }) {
    return _then(_self.copyWith(
      uploadDate: freezed == uploadDate
          ? _self.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as String?,
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
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
      datafile: freezed == datafile
          ? _self.datafile
          : datafile // ignore: cast_nullable_to_non_nullable
              as String?,
      files: freezed == files
          ? _self.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UploadDocBody].
extension UploadDocBodyPatterns on UploadDocBody {
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
    TResult Function(_UploadDocBody value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UploadDocBody() when $default != null:
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
    TResult Function(_UploadDocBody value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadDocBody():
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
    TResult? Function(_UploadDocBody value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadDocBody() when $default != null:
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
            @JsonKey(name: "upload_date") String? uploadDate,
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "random_no") String? randomNo,
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "doc_type_folder") String? docTypeFolder,
            @JsonKey(name: "filename") String? filename,
            @JsonKey(name: "datafile") String? datafile,
            @JsonKey(includeToJson: false, includeFromJson: false)
            List<PlatformFile>? files)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UploadDocBody() when $default != null:
        return $default(
            _that.uploadDate,
            _that.homeworkId,
            _that.randomNo,
            _that.shortName,
            _that.docTypeFolder,
            _that.filename,
            _that.datafile,
            _that.files);
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
            @JsonKey(name: "upload_date") String? uploadDate,
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "random_no") String? randomNo,
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "doc_type_folder") String? docTypeFolder,
            @JsonKey(name: "filename") String? filename,
            @JsonKey(name: "datafile") String? datafile,
            @JsonKey(includeToJson: false, includeFromJson: false)
            List<PlatformFile>? files)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadDocBody():
        return $default(
            _that.uploadDate,
            _that.homeworkId,
            _that.randomNo,
            _that.shortName,
            _that.docTypeFolder,
            _that.filename,
            _that.datafile,
            _that.files);
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
            @JsonKey(name: "upload_date") String? uploadDate,
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "random_no") String? randomNo,
            @JsonKey(name: "short_name") String? shortName,
            @JsonKey(name: "doc_type_folder") String? docTypeFolder,
            @JsonKey(name: "filename") String? filename,
            @JsonKey(name: "datafile") String? datafile,
            @JsonKey(includeToJson: false, includeFromJson: false)
            List<PlatformFile>? files)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UploadDocBody() when $default != null:
        return $default(
            _that.uploadDate,
            _that.homeworkId,
            _that.randomNo,
            _that.shortName,
            _that.docTypeFolder,
            _that.filename,
            _that.datafile,
            _that.files);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UploadDocBody implements UploadDocBody {
  const _UploadDocBody(
      {@JsonKey(name: "upload_date") this.uploadDate,
      @JsonKey(name: "homework_id") this.homeworkId,
      @JsonKey(name: "random_no") this.randomNo = '1',
      @JsonKey(name: "short_name") this.shortName,
      @JsonKey(name: "doc_type_folder") this.docTypeFolder = 'homework',
      @JsonKey(name: "filename") this.filename,
      @JsonKey(name: "datafile") this.datafile,
      @JsonKey(includeToJson: false, includeFromJson: false)
      final List<PlatformFile>? files})
      : _files = files;
  factory _UploadDocBody.fromJson(Map<String, dynamic> json) =>
      _$UploadDocBodyFromJson(json);

  @override
  @JsonKey(name: "upload_date")
  final String? uploadDate;
  @override
  @JsonKey(name: "homework_id")
  final String? homeworkId;
  @override
  @JsonKey(name: "random_no")
  final String? randomNo;
  @override
  @JsonKey(name: "short_name")
  final String? shortName;
  @override
  @JsonKey(name: "doc_type_folder")
  final String? docTypeFolder;
  @override
  @JsonKey(name: "filename")
  final String? filename;
  @override
  @JsonKey(name: "datafile")
  final String? datafile;
  final List<PlatformFile>? _files;
  @override
  @JsonKey(includeToJson: false, includeFromJson: false)
  List<PlatformFile>? get files {
    final value = _files;
    if (value == null) return null;
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  /// Create a copy of UploadDocBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UploadDocBodyCopyWith<_UploadDocBody> get copyWith =>
      __$UploadDocBodyCopyWithImpl<_UploadDocBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UploadDocBodyToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UploadDocBody &&
            (identical(other.uploadDate, uploadDate) ||
                other.uploadDate == uploadDate) &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.randomNo, randomNo) ||
                other.randomNo == randomNo) &&
            (identical(other.shortName, shortName) ||
                other.shortName == shortName) &&
            (identical(other.docTypeFolder, docTypeFolder) ||
                other.docTypeFolder == docTypeFolder) &&
            (identical(other.filename, filename) ||
                other.filename == filename) &&
            (identical(other.datafile, datafile) ||
                other.datafile == datafile) &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uploadDate,
      homeworkId,
      randomNo,
      shortName,
      docTypeFolder,
      filename,
      datafile,
      const DeepCollectionEquality().hash(_files));

  @override
  String toString() {
    return 'UploadDocBody(uploadDate: $uploadDate, homeworkId: $homeworkId, randomNo: $randomNo, shortName: $shortName, docTypeFolder: $docTypeFolder, filename: $filename, datafile: $datafile, files: $files)';
  }
}

/// @nodoc
abstract mixin class _$UploadDocBodyCopyWith<$Res>
    implements $UploadDocBodyCopyWith<$Res> {
  factory _$UploadDocBodyCopyWith(
          _UploadDocBody value, $Res Function(_UploadDocBody) _then) =
      __$UploadDocBodyCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "upload_date") String? uploadDate,
      @JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "random_no") String? randomNo,
      @JsonKey(name: "short_name") String? shortName,
      @JsonKey(name: "doc_type_folder") String? docTypeFolder,
      @JsonKey(name: "filename") String? filename,
      @JsonKey(name: "datafile") String? datafile,
      @JsonKey(includeToJson: false, includeFromJson: false)
      List<PlatformFile>? files});
}

/// @nodoc
class __$UploadDocBodyCopyWithImpl<$Res>
    implements _$UploadDocBodyCopyWith<$Res> {
  __$UploadDocBodyCopyWithImpl(this._self, this._then);

  final _UploadDocBody _self;
  final $Res Function(_UploadDocBody) _then;

  /// Create a copy of UploadDocBody
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? uploadDate = freezed,
    Object? homeworkId = freezed,
    Object? randomNo = freezed,
    Object? shortName = freezed,
    Object? docTypeFolder = freezed,
    Object? filename = freezed,
    Object? datafile = freezed,
    Object? files = freezed,
  }) {
    return _then(_UploadDocBody(
      uploadDate: freezed == uploadDate
          ? _self.uploadDate
          : uploadDate // ignore: cast_nullable_to_non_nullable
              as String?,
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
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
      datafile: freezed == datafile
          ? _self.datafile
          : datafile // ignore: cast_nullable_to_non_nullable
              as String?,
      files: freezed == files
          ? _self._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<PlatformFile>?,
    ));
  }
}

// dart format on
