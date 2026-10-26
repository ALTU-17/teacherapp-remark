import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'shared_incoming_file.dart';

final sharedAttachmentControllerProvider = StateNotifierProvider<
    SharedAttachmentController, SharedAttachmentState>((ref) {
  return SharedAttachmentController();
});

class SharedAttachmentState {
  const SharedAttachmentState({
    this.files = const [],
    this.batchId = 0,
  });

  final List<SharedIncomingFile> files;
  final int batchId;

  bool get hasFiles => files.isNotEmpty;

  SharedAttachmentState copyWith({
    List<SharedIncomingFile>? files,
    int? batchId,
  }) {
    return SharedAttachmentState(
      files: files ?? this.files,
      batchId: batchId ?? this.batchId,
    );
  }
}

class SharedAttachmentController extends StateNotifier<SharedAttachmentState> {
  SharedAttachmentController() : super(const SharedAttachmentState());

  static const _channel = MethodChannel('teacherapp/shared_attachments');
  bool _attached = false;

  Future<void> attach() async {
    if (_attached) return;
    _attached = true;

    _channel.setMethodCallHandler((call) async {
      if (call.method == 'onSharedFiles') {
        _setFiles(_parseFiles(call.arguments));
      }
    });

    try {
      final initial = await _channel.invokeMethod(
        'getInitialSharedFiles',
      );
      _setFiles(_parseFiles(initial));
    } catch (_) {
      // Android-only feature; no-op on platforms without the native channel.
    }
  }

  void clear() {
    state = state.copyWith(files: const []);
  }

  List<SharedIncomingFile> _parseFiles(Object? raw) {
    if (raw is! List) return const [];
    return raw
        .whereType<Map<dynamic, dynamic>>()
        .map(SharedIncomingFile.fromMap)
        .where((file) => file.path.isNotEmpty)
        .toList();
  }

  void _setFiles(List<SharedIncomingFile> files) {
    if (files.isEmpty) return;
    state = SharedAttachmentState(
      files: files,
      batchId: state.batchId + 1,
    );
  }
}
