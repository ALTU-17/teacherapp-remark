// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AttendanceState {
  List<Students> get students;
  List<Students> get selectedStudents;

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AttendanceStateCopyWith<AttendanceState> get copyWith =>
      _$AttendanceStateCopyWithImpl<AttendanceState>(
          this as AttendanceState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AttendanceState &&
            const DeepCollectionEquality().equals(other.students, students) &&
            const DeepCollectionEquality()
                .equals(other.selectedStudents, selectedStudents));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(students),
      const DeepCollectionEquality().hash(selectedStudents));

  @override
  String toString() {
    return 'AttendanceState(students: $students, selectedStudents: $selectedStudents)';
  }
}

/// @nodoc
abstract mixin class $AttendanceStateCopyWith<$Res> {
  factory $AttendanceStateCopyWith(
          AttendanceState value, $Res Function(AttendanceState) _then) =
      _$AttendanceStateCopyWithImpl;
  @useResult
  $Res call({List<Students> students, List<Students> selectedStudents});
}

/// @nodoc
class _$AttendanceStateCopyWithImpl<$Res>
    implements $AttendanceStateCopyWith<$Res> {
  _$AttendanceStateCopyWithImpl(this._self, this._then);

  final AttendanceState _self;
  final $Res Function(AttendanceState) _then;

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? students = null,
    Object? selectedStudents = null,
  }) {
    return _then(_self.copyWith(
      students: null == students
          ? _self.students
          : students // ignore: cast_nullable_to_non_nullable
              as List<Students>,
      selectedStudents: null == selectedStudents
          ? _self.selectedStudents
          : selectedStudents // ignore: cast_nullable_to_non_nullable
              as List<Students>,
    ));
  }
}

/// Adds pattern-matching-related methods to [AttendanceState].
extension AttendanceStatePatterns on AttendanceState {
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
    TResult Function(_AttendanceState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttendanceState() when $default != null:
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
    TResult Function(_AttendanceState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceState():
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
    TResult? Function(_AttendanceState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceState() when $default != null:
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
    TResult Function(List<Students> students, List<Students> selectedStudents)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _AttendanceState() when $default != null:
        return $default(_that.students, _that.selectedStudents);
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
    TResult Function(List<Students> students, List<Students> selectedStudents)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceState():
        return $default(_that.students, _that.selectedStudents);
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
    TResult? Function(List<Students> students, List<Students> selectedStudents)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _AttendanceState() when $default != null:
        return $default(_that.students, _that.selectedStudents);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _AttendanceState implements AttendanceState {
  const _AttendanceState(
      {final List<Students> students = const [],
      final List<Students> selectedStudents = const []})
      : _students = students,
        _selectedStudents = selectedStudents;

  final List<Students> _students;
  @override
  @JsonKey()
  List<Students> get students {
    if (_students is EqualUnmodifiableListView) return _students;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_students);
  }

  final List<Students> _selectedStudents;
  @override
  @JsonKey()
  List<Students> get selectedStudents {
    if (_selectedStudents is EqualUnmodifiableListView)
      return _selectedStudents;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_selectedStudents);
  }

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AttendanceStateCopyWith<_AttendanceState> get copyWith =>
      __$AttendanceStateCopyWithImpl<_AttendanceState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AttendanceState &&
            const DeepCollectionEquality().equals(other._students, _students) &&
            const DeepCollectionEquality()
                .equals(other._selectedStudents, _selectedStudents));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_students),
      const DeepCollectionEquality().hash(_selectedStudents));

  @override
  String toString() {
    return 'AttendanceState(students: $students, selectedStudents: $selectedStudents)';
  }
}

/// @nodoc
abstract mixin class _$AttendanceStateCopyWith<$Res>
    implements $AttendanceStateCopyWith<$Res> {
  factory _$AttendanceStateCopyWith(
          _AttendanceState value, $Res Function(_AttendanceState) _then) =
      __$AttendanceStateCopyWithImpl;
  @override
  @useResult
  $Res call({List<Students> students, List<Students> selectedStudents});
}

/// @nodoc
class __$AttendanceStateCopyWithImpl<$Res>
    implements _$AttendanceStateCopyWith<$Res> {
  __$AttendanceStateCopyWithImpl(this._self, this._then);

  final _AttendanceState _self;
  final $Res Function(_AttendanceState) _then;

  /// Create a copy of AttendanceState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? students = null,
    Object? selectedStudents = null,
  }) {
    return _then(_AttendanceState(
      students: null == students
          ? _self._students
          : students // ignore: cast_nullable_to_non_nullable
              as List<Students>,
      selectedStudents: null == selectedStudents
          ? _self._selectedStudents
          : selectedStudents // ignore: cast_nullable_to_non_nullable
              as List<Students>,
    ));
  }
}

// dart format on
