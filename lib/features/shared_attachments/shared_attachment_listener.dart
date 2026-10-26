import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teacherapp/features/auth/providers/auth_provider.dart';
import 'package:teacherapp/features/homework/views/edit_add_homework_view.dart';
import 'package:teacherapp/features/teacher_note/views/edit_add_teacher_note_view.dart';
import 'package:teacherapp/router/routers.dart';
import 'package:teacherapp/views/home/remark/addRemark.dart';

import 'shared_attachment_service.dart';
import 'shared_incoming_file.dart';

enum SharedAttachmentTarget { homework, teacherNote, remark }

class SharedAttachmentListener extends ConsumerStatefulWidget {
  const SharedAttachmentListener({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<SharedAttachmentListener> createState() =>
      _SharedAttachmentListenerState();
}

class _SharedAttachmentListenerState
    extends ConsumerState<SharedAttachmentListener> {
  bool _isChooserOpen = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await ref.read(sharedAttachmentControllerProvider.notifier).attach();
      _maybeShowChooser();
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(sharedAttachmentControllerProvider, (_, __) {
      _maybeShowChooser();
    });
    ref.listen(authProvider, (_, __) {
      _maybeShowChooser();
    });

    return widget.child;
  }

  void _maybeShowChooser() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted || _isChooserOpen) return;

      final sharedState = ref.read(sharedAttachmentControllerProvider);
      if (!sharedState.hasFiles) return;

      final auth = ref.read(authProvider).asData?.value;
      if (auth?.userId == null) return;

      final navContext = shellNavKey.currentContext;
      if (navContext == null) {
        Future.delayed(const Duration(milliseconds: 300), _maybeShowChooser);
        return;
      }
      _isChooserOpen = true;
      final target = await _showTargetChooser(navContext, sharedState.files);
      if (!mounted) return;

      final files = sharedState.files.map((file) => file.toPlatformFile()).toList();
      ref.read(sharedAttachmentControllerProvider.notifier).clear();
      _isChooserOpen = false;

      if (target == null || files.isEmpty) return;
      if (!mounted) return;

      final routeContext = shellNavKey.currentContext;
      if (routeContext == null) return;
      if (!routeContext.mounted) return;
      final navigator = Navigator.of(routeContext);
      switch (target) {
        case SharedAttachmentTarget.homework:
          navigator.push(
            MaterialPageRoute(
              builder: (_) => EditAddHomeWorkView(null, initialFiles: files),
            ),
          );
          break;
        case SharedAttachmentTarget.teacherNote:
          navigator.push(
            MaterialPageRoute(
              builder: (_) => EditAddTeacherNoteView(initialFiles: files),
            ),
          );
          break;
        case SharedAttachmentTarget.remark:
          navigator.push(
            MaterialPageRoute(
              builder: (_) => AddRemark(initialFiles: files),
            ),
          );
          break;
      }
    });
  }

  Future<SharedAttachmentTarget?> _showTargetChooser(
    BuildContext context,
    List<SharedIncomingFile> files,
  ) {
    final visibleNames = files.take(3).map((file) => file.name).join(', ');
    final extraCount = files.length - 3;

    return showModalBottomSheet<SharedAttachmentTarget>(
      context: context,
      useRootNavigator: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Share to Teacher App',
                  style: Theme.of(sheetContext).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  extraCount > 0
                      ? '$visibleNames + $extraCount more'
                      : visibleNames,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(sheetContext).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade700,
                      ),
                ),
                const SizedBox(height: 12),
                _TargetTile(
                  icon: Icons.assignment_rounded,
                  title: 'Create Homework',
                  onTap: () => Navigator.of(sheetContext)
                      .pop(SharedAttachmentTarget.homework),
                ),
                _TargetTile(
                  icon: Icons.note_add_rounded,
                  title: 'Create Teacher Note',
                  onTap: () => Navigator.of(sheetContext)
                      .pop(SharedAttachmentTarget.teacherNote),
                ),
                _TargetTile(
                  icon: Icons.comment_rounded,
                  title: 'Create Remark',
                  onTap: () => Navigator.of(sheetContext)
                      .pop(SharedAttachmentTarget.remark),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TargetTile extends StatelessWidget {
  const _TargetTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFFE3F2FD),
        child: Icon(icon, color: const Color(0xFF1976D2)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: onTap,
    );
  }
}
