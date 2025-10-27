// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'calender.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Calender {
  @JsonKey(name: "Events")
  List<Event> get events;
  @JsonKey(name: "Homework")
  List<dynamic> get homework;
  @JsonKey(name: "Holidays")
  List<Event> get holidays;

  /// Create a copy of Calender
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $CalenderCopyWith<Calender> get copyWith =>
      _$CalenderCopyWithImpl<Calender>(this as Calender, _$identity);

  /// Serializes this Calender to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Calender &&
            const DeepCollectionEquality().equals(other.events, events) &&
            const DeepCollectionEquality().equals(other.homework, homework) &&
            const DeepCollectionEquality().equals(other.holidays, holidays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(events),
      const DeepCollectionEquality().hash(homework),
      const DeepCollectionEquality().hash(holidays));

  @override
  String toString() {
    return 'Calender(events: $events, homework: $homework, holidays: $holidays)';
  }
}

/// @nodoc
abstract mixin class $CalenderCopyWith<$Res> {
  factory $CalenderCopyWith(Calender value, $Res Function(Calender) _then) =
      _$CalenderCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "Events") List<Event> events,
      @JsonKey(name: "Homework") List<dynamic> homework,
      @JsonKey(name: "Holidays") List<Event> holidays});
}

/// @nodoc
class _$CalenderCopyWithImpl<$Res> implements $CalenderCopyWith<$Res> {
  _$CalenderCopyWithImpl(this._self, this._then);

  final Calender _self;
  final $Res Function(Calender) _then;

  /// Create a copy of Calender
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? events = null,
    Object? homework = null,
    Object? holidays = null,
  }) {
    return _then(_self.copyWith(
      events: null == events
          ? _self.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      homework: null == homework
          ? _self.homework
          : homework // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      holidays: null == holidays
          ? _self.holidays
          : holidays // ignore: cast_nullable_to_non_nullable
              as List<Event>,
    ));
  }
}

/// Adds pattern-matching-related methods to [Calender].
extension CalenderPatterns on Calender {
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
    TResult Function(_Calender value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Calender() when $default != null:
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
    TResult Function(_Calender value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Calender():
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
    TResult? Function(_Calender value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Calender() when $default != null:
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
            @JsonKey(name: "Events") List<Event> events,
            @JsonKey(name: "Homework") List<dynamic> homework,
            @JsonKey(name: "Holidays") List<Event> holidays)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Calender() when $default != null:
        return $default(_that.events, _that.homework, _that.holidays);
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
            @JsonKey(name: "Events") List<Event> events,
            @JsonKey(name: "Homework") List<dynamic> homework,
            @JsonKey(name: "Holidays") List<Event> holidays)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Calender():
        return $default(_that.events, _that.homework, _that.holidays);
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
            @JsonKey(name: "Events") List<Event> events,
            @JsonKey(name: "Homework") List<dynamic> homework,
            @JsonKey(name: "Holidays") List<Event> holidays)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Calender() when $default != null:
        return $default(_that.events, _that.homework, _that.holidays);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Calender implements Calender {
  const _Calender(
      {@JsonKey(name: "Events") required final List<Event> events,
      @JsonKey(name: "Homework") required final List<dynamic> homework,
      @JsonKey(name: "Holidays") required final List<Event> holidays})
      : _events = events,
        _homework = homework,
        _holidays = holidays;
  factory _Calender.fromJson(Map<String, dynamic> json) =>
      _$CalenderFromJson(json);

  final List<Event> _events;
  @override
  @JsonKey(name: "Events")
  List<Event> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  final List<dynamic> _homework;
  @override
  @JsonKey(name: "Homework")
  List<dynamic> get homework {
    if (_homework is EqualUnmodifiableListView) return _homework;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_homework);
  }

  final List<Event> _holidays;
  @override
  @JsonKey(name: "Holidays")
  List<Event> get holidays {
    if (_holidays is EqualUnmodifiableListView) return _holidays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_holidays);
  }

  /// Create a copy of Calender
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$CalenderCopyWith<_Calender> get copyWith =>
      __$CalenderCopyWithImpl<_Calender>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$CalenderToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Calender &&
            const DeepCollectionEquality().equals(other._events, _events) &&
            const DeepCollectionEquality().equals(other._homework, _homework) &&
            const DeepCollectionEquality().equals(other._holidays, _holidays));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_events),
      const DeepCollectionEquality().hash(_homework),
      const DeepCollectionEquality().hash(_holidays));

  @override
  String toString() {
    return 'Calender(events: $events, homework: $homework, holidays: $holidays)';
  }
}

/// @nodoc
abstract mixin class _$CalenderCopyWith<$Res>
    implements $CalenderCopyWith<$Res> {
  factory _$CalenderCopyWith(_Calender value, $Res Function(_Calender) _then) =
      __$CalenderCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "Events") List<Event> events,
      @JsonKey(name: "Homework") List<dynamic> homework,
      @JsonKey(name: "Holidays") List<Event> holidays});
}

/// @nodoc
class __$CalenderCopyWithImpl<$Res> implements _$CalenderCopyWith<$Res> {
  __$CalenderCopyWithImpl(this._self, this._then);

  final _Calender _self;
  final $Res Function(_Calender) _then;

  /// Create a copy of Calender
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? events = null,
    Object? homework = null,
    Object? holidays = null,
  }) {
    return _then(_Calender(
      events: null == events
          ? _self._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<Event>,
      homework: null == homework
          ? _self._homework
          : homework // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      holidays: null == holidays
          ? _self._holidays
          : holidays // ignore: cast_nullable_to_non_nullable
              as List<Event>,
    ));
  }
}

/// @nodoc
mixin _$Event {
  @JsonKey(name: "title")
  String get title;
  @JsonKey(name: "start_date")
  String get startDate;
  @JsonKey(name: "event_desc")
  String get eventDesc;
  @JsonKey(name: "colorcode")
  String get colorcode;
  @JsonKey(name: "end_date")
  String? get endDate;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $EventCopyWith<Event> get copyWith =>
      _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Event &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.eventDesc, eventDesc) ||
                other.eventDesc == eventDesc) &&
            (identical(other.colorcode, colorcode) ||
                other.colorcode == colorcode) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, startDate, eventDesc, colorcode, endDate);

  @override
  String toString() {
    return 'Event(title: $title, startDate: $startDate, eventDesc: $eventDesc, colorcode: $colorcode, endDate: $endDate)';
  }
}

/// @nodoc
abstract mixin class $EventCopyWith<$Res> {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) =
      _$EventCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: "title") String title,
      @JsonKey(name: "start_date") String startDate,
      @JsonKey(name: "event_desc") String eventDesc,
      @JsonKey(name: "colorcode") String colorcode,
      @JsonKey(name: "end_date") String? endDate});
}

/// @nodoc
class _$EventCopyWithImpl<$Res> implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? startDate = null,
    Object? eventDesc = null,
    Object? colorcode = null,
    Object? endDate = freezed,
  }) {
    return _then(_self.copyWith(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      eventDesc: null == eventDesc
          ? _self.eventDesc
          : eventDesc // ignore: cast_nullable_to_non_nullable
              as String,
      colorcode: null == colorcode
          ? _self.colorcode
          : colorcode // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [Event].
extension EventPatterns on Event {
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
    TResult Function(_Event value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Event() when $default != null:
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
    TResult Function(_Event value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Event():
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
    TResult? Function(_Event value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Event() when $default != null:
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
            @JsonKey(name: "title") String title,
            @JsonKey(name: "start_date") String startDate,
            @JsonKey(name: "event_desc") String eventDesc,
            @JsonKey(name: "colorcode") String colorcode,
            @JsonKey(name: "end_date") String? endDate)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Event() when $default != null:
        return $default(_that.title, _that.startDate, _that.eventDesc,
            _that.colorcode, _that.endDate);
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
            @JsonKey(name: "title") String title,
            @JsonKey(name: "start_date") String startDate,
            @JsonKey(name: "event_desc") String eventDesc,
            @JsonKey(name: "colorcode") String colorcode,
            @JsonKey(name: "end_date") String? endDate)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Event():
        return $default(_that.title, _that.startDate, _that.eventDesc,
            _that.colorcode, _that.endDate);
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
            @JsonKey(name: "title") String title,
            @JsonKey(name: "start_date") String startDate,
            @JsonKey(name: "event_desc") String eventDesc,
            @JsonKey(name: "colorcode") String colorcode,
            @JsonKey(name: "end_date") String? endDate)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _Event() when $default != null:
        return $default(_that.title, _that.startDate, _that.eventDesc,
            _that.colorcode, _that.endDate);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _Event implements Event {
  const _Event(
      {@JsonKey(name: "title") required this.title,
      @JsonKey(name: "start_date") required this.startDate,
      @JsonKey(name: "event_desc") required this.eventDesc,
      @JsonKey(name: "colorcode") required this.colorcode,
      @JsonKey(name: "end_date") this.endDate});
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  @override
  @JsonKey(name: "title")
  final String title;
  @override
  @JsonKey(name: "start_date")
  final String startDate;
  @override
  @JsonKey(name: "event_desc")
  final String eventDesc;
  @override
  @JsonKey(name: "colorcode")
  final String colorcode;
  @override
  @JsonKey(name: "end_date")
  final String? endDate;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EventCopyWith<_Event> get copyWith =>
      __$EventCopyWithImpl<_Event>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$EventToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Event &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.eventDesc, eventDesc) ||
                other.eventDesc == eventDesc) &&
            (identical(other.colorcode, colorcode) ||
                other.colorcode == colorcode) &&
            (identical(other.endDate, endDate) || other.endDate == endDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, startDate, eventDesc, colorcode, endDate);

  @override
  String toString() {
    return 'Event(title: $title, startDate: $startDate, eventDesc: $eventDesc, colorcode: $colorcode, endDate: $endDate)';
  }
}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) =
      __$EventCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "title") String title,
      @JsonKey(name: "start_date") String startDate,
      @JsonKey(name: "event_desc") String eventDesc,
      @JsonKey(name: "colorcode") String colorcode,
      @JsonKey(name: "end_date") String? endDate});
}

/// @nodoc
class __$EventCopyWithImpl<$Res> implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

  /// Create a copy of Event
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? title = null,
    Object? startDate = null,
    Object? eventDesc = null,
    Object? colorcode = null,
    Object? endDate = freezed,
  }) {
    return _then(_Event(
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      startDate: null == startDate
          ? _self.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as String,
      eventDesc: null == eventDesc
          ? _self.eventDesc
          : eventDesc // ignore: cast_nullable_to_non_nullable
              as String,
      colorcode: null == colorcode
          ? _self.colorcode
          : colorcode // ignore: cast_nullable_to_non_nullable
              as String,
      endDate: freezed == endDate
          ? _self.endDate
          : endDate // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
