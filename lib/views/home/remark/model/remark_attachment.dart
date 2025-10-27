// In ClassSubStudentModel.dart
class RemarkAttachment {
  final String remarkId;
  final String imageName;
  final String fileSize;
  final String url;

  RemarkAttachment({
    required this.remarkId,
    required this.imageName,
    required this.fileSize,
    required this.url,
  });

  factory RemarkAttachment.fromJson(Map<String, dynamic> json) => RemarkAttachment(
    remarkId: json['remark_id'] ?? '',
    imageName: json['image_name'] ?? '',
    fileSize: json['file_size'] ?? '',
    url: json['url'] ?? '',
  );
}// In ClassSubStudentModel.dart
