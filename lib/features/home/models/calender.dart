import 'package:freezed_annotation/freezed_annotation.dart';

part 'calender.freezed.dart';
part 'calender.g.dart';

@freezed
abstract class Calender with _$Calender {
  const factory Calender({
    @JsonKey(name: "Events") required List<Event> events,
    @JsonKey(name: "Homework") required List<dynamic> homework,
    @JsonKey(name: "Holidays") required List<Event> holidays,
  }) = _Calender;

  factory Calender.fromJson(Map<String, dynamic> json) =>
      _$CalenderFromJson(json);
}

@freezed
abstract class Event with _$Event {
  const factory Event({
    @JsonKey(name: "title") required String title,
    @JsonKey(name: "start_date") required String startDate,
    @JsonKey(name: "event_desc") required String eventDesc,
    @JsonKey(name: "colorcode") required String colorcode,
    @JsonKey(name: "end_date") String? endDate,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
}
