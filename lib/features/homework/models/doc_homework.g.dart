// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doc_homework.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DocHomework _$DocHomeworkFromJson(Map<String, dynamic> json) => _DocHomework(
      status: json['status'] as bool?,
      images: (json['images'] as List<dynamic>?)
          ?.map((e) => Img.fromJson(e as Map<String, dynamic>))
          .toList(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$DocHomeworkToJson(_DocHomework instance) =>
    <String, dynamic>{
      if (instance.status case final value?) 'status': value,
      if (instance.images case final value?) 'images': value,
      if (instance.url case final value?) 'url': value,
    };

_Img _$ImgFromJson(Map<String, dynamic> json) => _Img(
      homeworkId: json['homework_id'] as String?,
      imageName: json['image_name'] as String?,
      fileSize: json['file_size'] as String?,
    );

Map<String, dynamic> _$ImgToJson(_Img instance) => <String, dynamic>{
      if (instance.homeworkId case final value?) 'homework_id': value,
      if (instance.imageName case final value?) 'image_name': value,
      if (instance.fileSize case final value?) 'file_size': value,
    };
