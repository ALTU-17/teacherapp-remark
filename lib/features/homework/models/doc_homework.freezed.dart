// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'doc_homework.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DocHomework {
  @JsonKey(name: "status")
  bool? get status;
  @JsonKey(name: "images")
  List<Img>? get images;
  @JsonKey(name: "url")
  String? get url;

  /// Create a copy of DocHomework
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DocHomeworkCopyWith<DocHomework> get copyWith =>
      _$DocHomeworkCopyWithImpl<DocHomework>(this as DocHomework, _$identity);

  /// Serializes this DocHomework to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DocHomework &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.images, images) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(images), url);

  @override
  String toString() {
    return 'DocHomework(status: $status, images: $images, url: $url)';
  }
}

/// @nodoc
abstract mixin class $DocHomeworkCopyWith<$Res> {
  factory $DocHomeworkCopyWith(
          DocHomework value, $Res Function(DocHomework) _then) =
      _$DocHomeworkCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "status") bool? status,
      @JsonKey(name: "images") List<Img>? images,
      @JsonKey(name: "url") String? url});
}

/// @nodoc
class _$DocHomeworkCopyWithImpl<$Res> implements $DocHomeworkCopyWith<$Res> {
  _$DocHomeworkCopyWithImpl(this._self, this._then);

  final DocHomework _self;
  final $Res Function(DocHomework) _then;

  /// Create a copy of DocHomework
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? images = freezed,
    Object? url = freezed,
  }) {
    return _then(_self.copyWith(
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      images: freezed == images
          ? _self.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<Img>?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [DocHomework].
extension DocHomeworkPatterns on DocHomework {
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
    TResult Function(_DocHomework value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DocHomework() when $default != null:
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
    TResult Function(_DocHomework value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocHomework():
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
    TResult? Function(_DocHomework value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocHomework() when $default != null:
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
            @JsonKey(name: "status") bool? status,
            @JsonKey(name: "images") List<Img>? images,
            @JsonKey(name: "url") String? url)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DocHomework() when $default != null:
        return $default(_that.status, _that.images, _that.url);
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
            @JsonKey(name: "status") bool? status,
            @JsonKey(name: "images") List<Img>? images,
            @JsonKey(name: "url") String? url)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocHomework():
        return $default(_that.status, _that.images, _that.url);
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
            @JsonKey(name: "status") bool? status,
            @JsonKey(name: "images") List<Img>? images,
            @JsonKey(name: "url") String? url)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DocHomework() when $default != null:
        return $default(_that.status, _that.images, _that.url);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _DocHomework implements DocHomework {
  const _DocHomework(
      {@JsonKey(name: "status") this.status,
      @JsonKey(name: "images") final List<Img>? images,
      @JsonKey(name: "url") this.url})
      : _images = images;
  factory _DocHomework.fromJson(Map<String, dynamic> json) =>
      _$DocHomeworkFromJson(json);

  @override
  @JsonKey(name: "status")
  final bool? status;
  final List<Img>? _images;
  @override
  @JsonKey(name: "images")
  List<Img>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: "url")
  final String? url;

  /// Create a copy of DocHomework
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DocHomeworkCopyWith<_DocHomework> get copyWith =>
      __$DocHomeworkCopyWithImpl<_DocHomework>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$DocHomeworkToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DocHomework &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, status, const DeepCollectionEquality().hash(_images), url);

  @override
  String toString() {
    return 'DocHomework(status: $status, images: $images, url: $url)';
  }
}

/// @nodoc
abstract mixin class _$DocHomeworkCopyWith<$Res>
    implements $DocHomeworkCopyWith<$Res> {
  factory _$DocHomeworkCopyWith(
          _DocHomework value, $Res Function(_DocHomework) _then) =
      __$DocHomeworkCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "status") bool? status,
      @JsonKey(name: "images") List<Img>? images,
      @JsonKey(name: "url") String? url});
}

/// @nodoc
class __$DocHomeworkCopyWithImpl<$Res> implements _$DocHomeworkCopyWith<$Res> {
  __$DocHomeworkCopyWithImpl(this._self, this._then);

  final _DocHomework _self;
  final $Res Function(_DocHomework) _then;

  /// Create a copy of DocHomework
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = freezed,
    Object? images = freezed,
    Object? url = freezed,
  }) {
    return _then(_DocHomework(
      status: freezed == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      images: freezed == images
          ? _self._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<Img>?,
      url: freezed == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$Img {
  @JsonKey(name: "homework_id")
  String? get homeworkId;
  @JsonKey(name: "image_name")
  String? get imageName;
  @JsonKey(name: "file_size")
  String? get fileSize;

  /// Create a copy of Img
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ImgCopyWith<Img> get copyWith =>
      _$ImgCopyWithImpl<Img>(this as Img, _$identity);

  /// Serializes this Img to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Img &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.imageName, imageName) ||
                other.imageName == imageName) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeworkId, imageName, fileSize);

  @override
  String toString() {
    return 'Img(homeworkId: $homeworkId, imageName: $imageName, fileSize: $fileSize)';
  }
}

/// @nodoc
abstract mixin class $ImgCopyWith<$Res> {
  factory $ImgCopyWith(Img value, $Res Function(Img) _then) = _$ImgCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "image_name") String? imageName,
      @JsonKey(name: "file_size") String? fileSize});
}

/// @nodoc
class _$ImgCopyWithImpl<$Res> implements $ImgCopyWith<$Res> {
  _$ImgCopyWithImpl(this._self, this._then);

  final Img _self;
  final $Res Function(Img) _then;

  /// Create a copy of Img
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? homeworkId = freezed,
    Object? imageName = freezed,
    Object? fileSize = freezed,
  }) {
    return _then(_self.copyWith(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      imageName: freezed == imageName
          ? _self.imageName
          : imageName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: freezed == fileSize
          ? _self.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Img].
extension ImgPatterns on Img {
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
    TResult Function(_Img value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Img() when $default != null:
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
    TResult Function(_Img value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Img():
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
    TResult? Function(_Img value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Img() when $default != null:
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
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "image_name") String? imageName,
            @JsonKey(name: "file_size") String? fileSize)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Img() when $default != null:
        return $default(_that.homeworkId, _that.imageName, _that.fileSize);
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
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "image_name") String? imageName,
            @JsonKey(name: "file_size") String? fileSize)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Img():
        return $default(_that.homeworkId, _that.imageName, _that.fileSize);
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
            @JsonKey(name: "homework_id") String? homeworkId,
            @JsonKey(name: "image_name") String? imageName,
            @JsonKey(name: "file_size") String? fileSize)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Img() when $default != null:
        return $default(_that.homeworkId, _that.imageName, _that.fileSize);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Img implements Img {
  const _Img(
      {@JsonKey(name: "homework_id") this.homeworkId,
      @JsonKey(name: "image_name") this.imageName,
      @JsonKey(name: "file_size") this.fileSize});
  factory _Img.fromJson(Map<String, dynamic> json) => _$ImgFromJson(json);

  @override
  @JsonKey(name: "homework_id")
  final String? homeworkId;
  @override
  @JsonKey(name: "image_name")
  final String? imageName;
  @override
  @JsonKey(name: "file_size")
  final String? fileSize;

  /// Create a copy of Img
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImgCopyWith<_Img> get copyWith =>
      __$ImgCopyWithImpl<_Img>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ImgToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Img &&
            (identical(other.homeworkId, homeworkId) ||
                other.homeworkId == homeworkId) &&
            (identical(other.imageName, imageName) ||
                other.imageName == imageName) &&
            (identical(other.fileSize, fileSize) ||
                other.fileSize == fileSize));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, homeworkId, imageName, fileSize);

  @override
  String toString() {
    return 'Img(homeworkId: $homeworkId, imageName: $imageName, fileSize: $fileSize)';
  }
}

/// @nodoc
abstract mixin class _$ImgCopyWith<$Res> implements $ImgCopyWith<$Res> {
  factory _$ImgCopyWith(_Img value, $Res Function(_Img) _then) =
      __$ImgCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "homework_id") String? homeworkId,
      @JsonKey(name: "image_name") String? imageName,
      @JsonKey(name: "file_size") String? fileSize});
}

/// @nodoc
class __$ImgCopyWithImpl<$Res> implements _$ImgCopyWith<$Res> {
  __$ImgCopyWithImpl(this._self, this._then);

  final _Img _self;
  final $Res Function(_Img) _then;

  /// Create a copy of Img
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? homeworkId = freezed,
    Object? imageName = freezed,
    Object? fileSize = freezed,
  }) {
    return _then(_Img(
      homeworkId: freezed == homeworkId
          ? _self.homeworkId
          : homeworkId // ignore: cast_nullable_to_non_nullable
              as String?,
      imageName: freezed == imageName
          ? _self.imageName
          : imageName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileSize: freezed == fileSize
          ? _self.fileSize
          : fileSize // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
