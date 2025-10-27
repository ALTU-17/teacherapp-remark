class NoteAttachment {
  final String noteId;
  final String imageName;
  final String fileSize;
  final String url;

  NoteAttachment({
    required this.noteId,
    required this.imageName,
    required this.fileSize,
    required this.url,
  });

  factory NoteAttachment.fromJson(Map<String, dynamic> json) {
    return NoteAttachment(
      noteId: json['notes_id'] ?? '',
      imageName: json['image_name'] ?? '',
      fileSize: json['file_size'] ?? '',
      url: json['url'] ?? '',
    );
  }

  String get fullUrl => "$url";
}
class HWAttachment {
  final String hwId;
  final String imageName;
  final String fileSize;
  final String url;

  HWAttachment({
    required this.hwId,
    required this.imageName,
    required this.fileSize,
    required this.url,
  });

  factory HWAttachment.fromJson(Map<String, dynamic> json) {
    return HWAttachment(
      hwId: json['homework_id'] ?? '',
      imageName: json['image_name'] ?? '',
      fileSize: json['file_size'] ?? '',
      url: json['url'] ?? '',
    );
  }

  String get fullUrl => "$url/$imageName";
}