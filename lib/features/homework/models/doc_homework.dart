import 'package:freezed_annotation/freezed_annotation.dart';

part 'doc_homework.freezed.dart';
part 'doc_homework.g.dart';

@freezed
abstract class DocHomework with _$DocHomework {
  const factory DocHomework({
    @JsonKey(name: "status") bool? status,
    @JsonKey(name: "images") List<Img>? images,
    @JsonKey(name: "url") String? url,
  }) = _DocHomework;

  factory DocHomework.fromJson(Map<String, dynamic> json) =>
      _$DocHomeworkFromJson(json);
}

@freezed
abstract class Img with _$Img {
  const factory Img({
    @JsonKey(name: "homework_id") String? homeworkId,
    @JsonKey(name: "image_name") String? imageName,
    @JsonKey(name: "file_size") String? fileSize,
  }) = _Img;

  factory Img.fromJson(Map<String, dynamic> json) => _$ImgFromJson(json);
}
