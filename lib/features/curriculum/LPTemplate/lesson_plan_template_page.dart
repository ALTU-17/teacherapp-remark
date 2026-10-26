// lesson_plan_template_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/features/auth/providers/auth_provider.dart';

import 'create_edit_lesson_plan_template.dart';
import 'lesson_plan_template_api_service.dart';
import 'models.dart';

class LessonPlanTemplatePage extends ConsumerStatefulWidget {
  const LessonPlanTemplatePage({super.key});

  @override
  ConsumerState<LessonPlanTemplatePage> createState() =>
      _LessonPlanTemplatePageState();
}

class _LessonPlanTemplatePageState extends ConsumerState<LessonPlanTemplatePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider).requireValue;
    final regId = auth.regId ?? '';

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink, Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close_rounded, color: Colors.white, size: 24.w),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'Lesson Plan Template',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            indicatorWeight: 2.5,
            tabs: const [
              Tab(text: 'Manage'),
              Tab(text: 'Template'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _TemplateManageTab(regId: regId),
            _TemplateBrowseTab(regId: regId),
          ],
        ),
      ),
    );
  }
}

class _TemplateManageTab extends StatefulWidget {
  final String regId;

  const _TemplateManageTab({required this.regId});

  @override
  State<_TemplateManageTab> createState() => _TemplateManageTabState();
}

class _TemplateManageTabState extends State<_TemplateManageTab> {
  final LessonPlanTemplateApiService _apiService =
      LessonPlanTemplateApiService();
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isLoading = false;
  String? _error;
  List<TemplateRecord> _records = [];

  static const double _wSr = 50;
  static const double _wClass = 50;
  static const double _wSubject = 100;
  static const double _wChapter = 150;
  static const double _wEdit = 70;
  static const double _wDelete = 70;

  double get _tablePixelWidth =>
      _wSr.w +
      _wClass.w +
      _wSubject.w +
      _wChapter.w +
      _wEdit.w +
      _wDelete.w +
      4.w;

  List<TemplateRecord> get _filtered {
    if (_searchQuery.isEmpty) return _records;
    final q = _searchQuery.toLowerCase();
    return _records
        .where((record) =>
            record.className.toLowerCase().contains(q) ||
            record.subject.toLowerCase().contains(q) ||
            record.chapter.toLowerCase().contains(q))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadRecords();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRecords() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final records = await _apiService.getTemplateList();
      if (!mounted) return;
      setState(() => _records = records);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _openEdit(TemplateRecord record) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    TemplateEditDetailsResult details;
    try {
      details = await _apiService.getTemplateById(
        classId: record.classId,
        subjectId: record.subjectId,
        chapterId: record.chapterId,
        templateId: record.templateId,
      );
    } catch (e) {
      if (!mounted) return;
      _showSnack(e.toString(), false);
      setState(() => _isLoading = false);
      return;
    }

    if (!mounted) return;
    setState(() => _isLoading = false);

    final changed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => LessonPlanTemplateFormScreen(
          mode: TemplateFormMode.edit,
          classId: record.classId,
          subjectId: record.subjectId,
          chapterId: record.chapterId,
          regId: record.regId == 0 ? widget.regId : record.regId.toString(),
          className: record.className,
          subject: record.subject,
          chapter: record.chapter,
          templateId: details.templateId,
          existingDetails: details.details,
        ),
      ),
    );
    if (changed == true) _loadRecords();
  }

  Future<void> _deleteTemplate(TemplateRecord record) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Lesson Plan Template'),
          content: Text(
            'Delete template for ${record.className} - ${record.subject} - ${record.chapter}?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final message =
          await _apiService.deleteTemplate(templateId: record.templateId);
      if (!mounted) return;
      setState(() {
        _records.removeWhere(
          (item) => item.templateId == record.templateId,
        );
      });
      _showSnack(message, true);
    } catch (e) {
      if (!mounted) return;
      _showSnack(e.toString(), false);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showSnack(String message, bool ok) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ok ? Colors.green.shade700 : Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Lesson Plan Template',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    // IconButton(
                    //   onPressed: _isLoading ? null : _loadRecords,
                    //   icon: Icon(Icons.refresh, size: 20.w),
                    //   tooltip: 'Refresh',
                    // ),
                  ],
                ),
                SizedBox(height: 8.h),
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search class, subject or chapter',
                    prefixIcon: const Icon(Icons.search),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                  onChanged: (value) => setState(() => _searchQuery = value),
                ),
                SizedBox(height: 10.h),
                Expanded(child: _buildContent()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, size: 40.w, color: Colors.red.shade700),
            SizedBox(height: 8.h),
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.sp, color: Colors.black54),
            ),
            SizedBox(height: 12.h),
            // ElevatedButton.icon(
            //   onPressed: _loadRecords,
            //   icon: const Icon(Icons.refresh),
            //   label: const Text('Retry'),
            // ),
          ],
        ),
      );
    }

    if (_filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.storage_outlined, size: 40.w, color: Colors.black26),
            SizedBox(height: 8.h),
            Text(
              'No data available in table',
              style: TextStyle(fontSize: 13.sp, color: Colors.black38),
            ),
          ],
        ),
      );
    }

    return _buildScrollableTable();
  }

  Widget _buildScrollableTable() {
    return Scrollbar(
      thumbVisibility: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: _tablePixelWidth,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10.r),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                _buildTableHeader(),
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: Column(
                        children: _filtered
                            .asMap()
                            .entries
                            .map((entry) =>
                                _buildTableRow(entry.key + 1, entry.value))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: Colors.grey.shade200,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          _headerCellClass('Sr. No', _wSr),
          _headerCellClass('Class', _wClass),
          _headerCell('Subject', _wSubject),
          _headerCell('Chapter', _wChapter),
          _headerCell('Edit', _wEdit, center: true),
          _headerCell('Delete', _wDelete, center: true),
        ],
      ),
    );
  }

  Widget _headerCellClass(String text, double width, {bool center = false}) {
    return SizedBox(
      width: width.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.w),
        child: Text(
          text,
          textAlign: center ? TextAlign.center : TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    );
  }
  Widget _headerCell(String text, double width, {bool center = false}) {
    return SizedBox(
      width: width.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Text(
          text,
          textAlign: center ? TextAlign.center : TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            fontSize: 12.5.sp,
            fontWeight: FontWeight.w700,
            color: Colors.grey.shade800,
          ),
        ),
      ),
    );
  }

  Widget _buildTableRow(int srNo, TemplateRecord record) {
    final isPublished = record.publish.toUpperCase() == 'Y';

    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          _bodyCell('$srNo', _wSr),
          _bodyCell(record.className, _wClass),
          _bodyCell(record.subject, _wSubject),
          _bodyCell(record.chapter, _wChapter, maxLines: 2),
          SizedBox(
            width: _wEdit.w,
            child: Center(
              child: isPublished
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () => _openEdit(record),
                      icon: Icon(Icons.edit_outlined,
                          size: 18.w, color: Colors.blue.shade700),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
            ),
          ),
          SizedBox(
            width: _wDelete.w,
            child: Center(
              child: isPublished
                  ? const SizedBox.shrink()
                  : IconButton(
                      onPressed: () => _deleteTemplate(record),
                      icon: Icon(Icons.delete_outline_rounded,
                          size: 18.w, color: Colors.red.shade700),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyCell(String text, double width, {int maxLines = 1}) {
    return SizedBox(
      width: width.w,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          style: TextStyle(fontSize: 13.sp),
        ),
      ),
    );
  }
}

class _TemplateBrowseTab extends StatefulWidget {
  final String regId;

  const _TemplateBrowseTab({required this.regId});

  @override
  State<_TemplateBrowseTab> createState() => _TemplateBrowseTabState();
}

class _TemplateBrowseTabState extends State<_TemplateBrowseTab> {
  final LessonPlanTemplateApiService _apiService =
      LessonPlanTemplateApiService();

  List<TemplateClass> _classes = [];
  List<TemplateSubject> _subjects = [];
  List<TemplateChapter> _chapters = [];

  TemplateClass? _selectedClass;
  TemplateSubject? _selectedSubject;
  TemplateChapter? _selectedChapter;

  bool _isLoadingClasses = false;
  bool _isLoadingSubjects = false;
  bool _isLoadingChapters = false;
  bool _isBrowsing = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadClasses();
  }

  Future<void> _loadClasses() async {
    if (widget.regId.isEmpty) {
      setState(() => _error = 'Teacher id missing');
      return;
    }

    setState(() {
      _isLoadingClasses = true;
      _error = null;
    });

    try {
      final classes = await _apiService.getClasses(teacherId: widget.regId);
      if (!mounted) return;
      setState(() => _classes = classes);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoadingClasses = false);
    }
  }

  Future<void> _loadSubjects(TemplateClass selectedClass) async {
    setState(() {
      _isLoadingSubjects = true;
      _error = null;
      _selectedSubject = null;
      _selectedChapter = null;
      _subjects = [];
      _chapters = [];
    });

    try {
      final subjects =
          await _apiService.getSubjects(classId: selectedClass.classId);
      if (!mounted) return;
      setState(() => _subjects = subjects);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoadingSubjects = false);
    }
  }

  Future<void> _loadChapters(TemplateSubject subject) async {
    if (_selectedClass == null) return;

    setState(() {
      _isLoadingChapters = true;
      _error = null;
      _selectedChapter = null;
      _chapters = [];
    });

    try {
      final chapters = await _apiService.getChapters(
        classId: _selectedClass!.classId,
        subjectId: subject.subjectId,
      );
      if (!mounted) return;
      setState(() => _chapters = chapters);
    } catch (e) {
      if (!mounted) return;
      setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoadingChapters = false);
    }
  }

  Future<void> _browse() async {
    if (_selectedClass == null ||
        _selectedSubject == null ||
        _selectedChapter == null) {
      _showSnack('Please select Class, Subject and Chapter', false);
      return;
    }

    setState(() {
      _isBrowsing = true;
      _error = null;
    });

    try {
      final result = await _apiService.getTemplate(
        classId: _selectedClass!.classId,
        subjectId: _selectedSubject!.subjectId,
        chapterId: _selectedChapter!.chapterId,
        regId: widget.regId,
      );
      if (!mounted) return;

      final editDetails = result.hasTemplate
          ? await _apiService.getTemplateById(
              classId: _selectedClass!.classId,
              subjectId: _selectedSubject!.subjectId,
              chapterId: _selectedChapter!.chapterId,
              templateId: result.details.first.templateId,
            )
          : null;
      if (!mounted) return;

      await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (_) => LessonPlanTemplateFormScreen(
            mode: result.hasTemplate
                ? TemplateFormMode.edit
                : TemplateFormMode.create,
            classId: _selectedClass!.classId,
            subjectId: _selectedSubject!.subjectId,
            chapterId: _selectedChapter!.chapterId,
            regId: widget.regId,
            className: _selectedClass!.className,
            subject: _selectedSubject!.name,
            chapter: _selectedChapter!.name,
            templateId: editDetails?.templateId,
            existingDetails: editDetails?.details ?? const [],
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      _showSnack(e.toString(), false);
    } finally {
      if (mounted) setState(() => _isBrowsing = false);
    }
  }

  void _showSnack(String msg, bool ok) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          Icon(ok ? Icons.check_circle : Icons.warning_amber_rounded,
              color: Colors.white, size: 20.w),
          SizedBox(width: 10.w),
          Expanded(child: Text(msg)),
        ]),
        backgroundColor: ok ? Colors.green.shade700 : Colors.red.shade700,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(14.w),
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(Icons.description_rounded,
                          color: Colors.blue.shade700, size: 20.w),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        'Lesson Plan Template',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    if (_isLoadingClasses)
                      SizedBox(
                        width: 20.w,
                        height: 20.w,
                        child: const CircularProgressIndicator(strokeWidth: 2),
                      )
                    // else
                    //   IconButton(
                    //     onPressed: _loadClasses,
                    //     icon: const Icon(Icons.refresh),
                    //     tooltip: 'Refresh classes',
                    //   ),
                  ],
                ),
                if (_error != null) ...[
                  SizedBox(height: 10.h),
                  Text(
                    _error!,
                    style:
                        TextStyle(color: Colors.red.shade700, fontSize: 12.sp),
                  ),
                ],
                SizedBox(height: 16.h),
                _buildBrowseControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrowseControls() {
    final classDropdown = _styledDropdown<TemplateClass>(
      label: 'Class',
      hint: _isLoadingClasses ? 'Loading...' : 'Select',
      value: _selectedClass,
      items: _classes,
      itemLabel: (item) => item.className,
      onChanged: _isLoadingClasses
          ? null
          : (value) {
              setState(() => _selectedClass = value);
              if (value != null) _loadSubjects(value);
            },
      required: true,
    );

    final subjectDropdown = _styledDropdown<TemplateSubject>(
      label: 'Subject',
      hint: _isLoadingSubjects ? 'Loading...' : 'Select',
      value: _selectedSubject,
      items: _subjects,
      itemLabel: (item) => item.name,
      onChanged: _selectedClass == null || _isLoadingSubjects
          ? null
          : (value) {
              setState(() => _selectedSubject = value);
              if (value != null) _loadChapters(value);
            },
      required: true,
    );

    final chapterDropdown = _styledDropdown<TemplateChapter>(
      label: 'Chapter',
      hint: _isLoadingChapters ? 'Loading...' : 'Select',
      value: _selectedChapter,
      items: _chapters,
      itemLabel: (item) => item.name,
      onChanged: _selectedSubject == null || _isLoadingChapters
          ? null
          : (value) => setState(() => _selectedChapter = value),
      required: true,
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final isNarrow = constraints.maxWidth < 620.w;

        if (isNarrow) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              classDropdown,
              SizedBox(height: 12.h),
              subjectDropdown,
              SizedBox(height: 12.h),
              chapterDropdown,
              SizedBox(height: 16.h),
              _browseButton(fullWidth: true),
            ],
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: classDropdown),
            SizedBox(width: 12.w),
            Expanded(child: subjectDropdown),
            SizedBox(width: 12.w),
            Expanded(child: chapterDropdown),
            SizedBox(width: 12.w),
            _browseButton(fullWidth: false),
          ],
        );
      },
    );
  }

  Widget _browseButton({required bool fullWidth}) {
    return SizedBox(
      width: fullWidth ? double.infinity : 160.w,
      height: 48.h,
      child: ElevatedButton.icon(
        onPressed: _isBrowsing ? null : _browse,
        icon: _isBrowsing
            ? SizedBox(
                width: 18.w,
                height: 18.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Icon(Icons.search_rounded, size: 20.w),
        label: Text(
          _isBrowsing ? 'Loading...' : 'Browse',
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade600,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      ),
    );
  }

  Widget _styledDropdown<T>({
    required String label,
    required String hint,
    required T? value,
    required List<T> items,
    required String Function(T item) itemLabel,
    required ValueChanged<T?>? onChanged,
    bool required = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade800,
            ),
            children: required
                ? [
                    TextSpan(
                      text: ' *',
                      style: TextStyle(color: Colors.red.shade700),
                    )
                  ]
                : [],
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonFormField<T>(
            initialValue: value,
            isExpanded: true,
            hint: Text(
              hint,
              style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              isDense: true,
            ),
            items: items
                .map((item) => DropdownMenuItem<T>(
                      value: item,
                      child: Text(
                        itemLabel(item),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ))
                .toList(),
            onChanged: onChanged,
            icon: Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.grey.shade600),
          ),
        ),
      ],
    );
  }
}
