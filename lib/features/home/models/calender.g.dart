// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calender.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Calender _$CalenderFromJson(Map<String, dynamic> json) => _Calender(
      events: (json['Events'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
      homework: json['Homework'] as List<dynamic>,
      holidays: (json['Holidays'] as List<dynamic>)
          .map((e) => Event.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CalenderToJson(_Calender instance) => <String, dynamic>{
      'Events': instance.events,
      'Homework': instance.homework,
      'Holidays': instance.holidays,
    };

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
      title: json['title'] as String,
      startDate: json['start_date'] as String,
      eventDesc: json['event_desc'] as String,
      colorcode: json['colorcode'] as String,
      endDate: json['end_date'] as String?,
    );

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
      'title': instance.title,
      'start_date': instance.startDate,
      'event_desc': instance.eventDesc,
      'colorcode': instance.colorcode,
      if (instance.endDate case final value?) 'end_date': value,
    };
