import 'dart:io';

import 'package:file_picker/file_picker.dart';

class SharedIncomingFile {
  const SharedIncomingFile({
    required this.name,
    required this.path,
    required this.size,
    this.mimeType,
  });

  final String name;
  final String path;
  final int size;
  final String? mimeType;

  factory SharedIncomingFile.fromMap(Map<dynamic, dynamic> map) {
    final path = map['path']?.toString() ?? '';
    final name = map['name']?.toString();
    final file = File(path);
    final resolvedName = (name == null || name.isEmpty)
        ? path.split(Platform.pathSeparator).last
        : name;
    final resolvedSize = map['size'];

    return SharedIncomingFile(
      name: resolvedName,
      path: path,
      mimeType: map['mimeType']?.toString(),
      size: resolvedSize is int
          ? resolvedSize
          : int.tryParse(resolvedSize?.toString() ?? '') ??
              (file.existsSync() ? file.lengthSync() : 0),
    );
  }

  PlatformFile toPlatformFile() {
    return PlatformFile(
      name: name,
      path: path,
      size: size,
    );
  }
}
