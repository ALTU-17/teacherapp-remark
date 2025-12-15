import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../models/chapter.dart';
import '../providers/chapter_list_provider.dart';
import '../providers/create_chapter_provider.dart';
import 'CreateChapterPage.dart';
import 'EditChapterPage.dart';
import '../../auth/providers/auth_provider.dart';


class ChaptersPage extends HookConsumerWidget {
  const ChaptersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chaptersAsync = ref.watch(chapterListPProvider);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 30.h,
        title: Text(
          "Manage Chapters",
          style: TextStyle(fontSize: 18.sp, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: chaptersAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text("No Chapters found")),
          data: (chapters) => ChaptersListBody(chapters: chapters),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 208, 28, 127),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateChapterPage()),
          );
          if (result == true) {
            // Refresh the chapter list
            ref.invalidate(chapterListPProvider);
          }
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class ChaptersListBody extends ConsumerStatefulWidget {
  final List<Chapter> chapters;

  const ChaptersListBody({super.key, required this.chapters});

  @override
  ConsumerState<ChaptersListBody> createState() => _ChaptersListBodyState();
}

class _ChaptersListBodyState extends ConsumerState<ChaptersListBody> {
  bool selectAll = false;
  List<Chapter> localChapters = [];
  late TextEditingController searchCtrl;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();

    localChapters = List.from(widget.chapters);

    searchCtrl = TextEditingController();
    searchCtrl.addListener(() {
      setState(() {
        searchQuery = searchCtrl.text.trim().toLowerCase();
      });
    });

    selectAll = localChapters.isNotEmpty && localChapters.every((c) => c.isSelected);
  }

  @override
  void didUpdateWidget(ChaptersListBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.chapters != widget.chapters) {
      setState(() {
        localChapters = List.from(widget.chapters);
        selectAll = localChapters.isNotEmpty && localChapters.every((c) => c.isSelected);
      });
    }
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.read(authProvider).requireValue;
    final myRegId = auth.regId ?? "";

    // 🔍 SEARCH FILTERING
    final filteredChapters = localChapters.where((c) {
      final name = (c.name ?? "").toLowerCase();
      final lessonNo = (c.chapterNo ?? "").toLowerCase();
      final createdBy = (c.tecName ?? "").toLowerCase();
      final sub = (c.subName ?? "").toLowerCase();

      return name.contains(searchQuery) ||
          lessonNo.contains(searchQuery) ||
          sub.contains(searchQuery) ||
          createdBy.contains(searchQuery);
    }).toList();

    return Column(
      children: [
        SizedBox(height: 130.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextField(
            controller: searchCtrl,
            decoration: InputDecoration(
              hintText: "Search by name, lesson number, created by",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),

        SizedBox(height: 5.h),

        // Publish + Select All row
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.publish, size: 18),
                label: Text(
                  'Publish Selected',
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                ),
                onPressed: () async {
                  final selected = localChapters.where((c) => c.isSelected).toList();
                  if (selected.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please select at least one chapter')),
                    );
                    return;
                  }

                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Confirm Publish'),
                      content: const Text('Publish selected chapter(s)?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                        TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Publish')),
                      ],
                    ),
                  );

                  if (confirm == true) _publishChapters(selected);
                },
              ),

              const Spacer(),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    selectAll = !selectAll;
                    for (int i = 0; i < localChapters.length; i++) {
                      localChapters[i] = localChapters[i].copyWith(isSelected: selectAll);
                    }
                  });
                },
                child: Text(
                  selectAll ? 'Unselect All' : 'Select All',
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
              )
            ],
          ),
        ),

        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            itemCount: filteredChapters.length,
            itemBuilder: (context, index) {
              final chapter = filteredChapters[index];
              return ChapterCard(
                chapter: chapter,
                currentTeacherId: myRegId,
                onSelectionChanged: (selected) {
                  setState(() {
                    int actualIndex = localChapters.indexWhere((c) => c.chapterId == chapter.chapterId);
                    localChapters[actualIndex] = chapter.copyWith(isSelected: selected);
                    selectAll = localChapters.isNotEmpty && localChapters.every((c) => c.isSelected);
                  });
                },
                onPublishChanged: (_) {},
                onEdit: () async {
                  final changed = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditChapterPage(chapter: chapter)),
                  );

                  if (changed == true) {
                    ref.invalidate(chapterListPProvider);
                  }
                },
                onDelete: () => _confirmAndDeleteChapter(chapter),
              );
            },
          ),
        ),
      ],
    );
  }

  // DELETE CHAPTER
  Future<void> _confirmAndDeleteChapter(Chapter chapter) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Delete chapter "${chapter.name ?? ''}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: Colors.red))),
        ],
      ),
    );

    if (confirm != true) return;

    final auth = ref.read(authProvider).requireValue;
    final service = ref.read(chapterServiceProvider);

    final ok = await service.deleteChapter(
      shortName: auth.teacherVerification?.shortName ?? '',
      chapterId: chapter.chapterId ?? '',
    );

    if (ok) {
      setState(() {
        localChapters.removeWhere((c) => c.chapterId == chapter.chapterId);
        selectAll = localChapters.isNotEmpty && localChapters.every((c) => c.isSelected);
      });

      ref.invalidate(chapterListPProvider);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Chapter deleted')));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Delete failed')));
    }
  }

  // PUBLISH CHAPTERS
  Future<void> _publishChapters(List<Chapter> selectedChapters) async {
    final chapterIds = selectedChapters.map((c) => c.chapterId).whereType<String>().join(',');

    final auth = ref.read(authProvider).requireValue;
    final service = ref.read(chapterServiceProvider);

    final result = await service.publishChapters(
      shortName: auth.teacherVerification?.shortName ?? '',
      selectedChapterIds: chapterIds,
    );

    if (result['status'] == true) {
      setState(() {
        for (int i = 0; i < localChapters.length; i++) {
          if (selectedChapters.any((c) => c.chapterId == localChapters[i].chapterId)) {
            localChapters[i] = localChapters[i].copyWith(
              isPublished: true,
              isSelected: false,
              publish: 'Y',
            );
          }
        }
        selectAll = false;
      });

      ref.invalidate(chapterListPProvider);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['success_msg'] ?? 'Published!'))
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result['error_msg'] ?? 'Publish failed'))
      );
    }
  }
}



class ChapterCard extends StatelessWidget {
  final Chapter chapter;
  final ValueChanged<bool> onSelectionChanged;
  final ValueChanged<bool> onPublishChanged;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final String currentTeacherId;

  const ChapterCard({
    super.key,
    required this.chapter,
    required this.onSelectionChanged,
    required this.onPublishChanged,
    this.onEdit,
    this.onDelete,
    required this.currentTeacherId,
  });

  @override
  Widget build(BuildContext context) {
    // Has delete rights if: not published, or published AND created by me
    final isOwner = (chapter.createdBy ?? '') == currentTeacherId;
    final canDelete = isOwner && (chapter.isDelete != 'Y'); // not already deleted
    final canEdit = isOwner && (chapter.publish != 'Y');
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r)),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow(
              'Class',
              '${chapter.className ?? ""}  |  ${chapter.subName ??
                  ""}  |   Lesson No: ${chapter.chapterNo ?? ""}',
            ),
            _buildDetailRow('Name', chapter.name ?? ""),
            if ((chapter.subSubject ?? '').isNotEmpty)
              _buildDetailRow('Sub-Subject', chapter.subSubject ?? ""),
            _buildDetailRow('Created By', chapter.tecName ?? ""),
            SizedBox(height: 5.h),

            Row(
              children: [
                if (chapter.publish != 'Y' && isOwner)
                  Checkbox(
                    value: chapter.isSelected,
                    onChanged: (value) => onSelectionChanged(value ?? false),
                  ),

                if (canEdit)
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: onEdit,
                  ),

                // 👇 Replace delete icon with "Deleted" label if isDelete == 'Y'
                if (chapter.isDelete == 'Y' && isOwner)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      "Deleted",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                else if (canDelete)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: RichText(
        text: TextSpan(
          style: TextStyle(fontSize: 14.sp, color: Colors.black),
          children: [
            TextSpan(
              text: '$label : ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
