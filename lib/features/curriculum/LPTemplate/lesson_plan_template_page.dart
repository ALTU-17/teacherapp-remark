// lesson_plan_template_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'models.dart';

class LessonPlanTemplatePage extends StatefulWidget {
  const LessonPlanTemplatePage({super.key});

  @override
  State<LessonPlanTemplatePage> createState() => _LessonPlanTemplatePageState();
}

class _LessonPlanTemplatePageState extends State<LessonPlanTemplatePage>
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
          children: const [
            _TemplateManageTab(),
            _TemplateBrowseTab(),
          ],
        ),
      ),
    );
  }
}


class _TemplateManageTab extends StatefulWidget {
  const _TemplateManageTab();

  @override
  State<_TemplateManageTab> createState() => _TemplateManageTabState();
}

class _TemplateManageTabState extends State<_TemplateManageTab> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  bool _isLoading = false;

  // Fixed column widths
  static const double _wSr = 60;
  static const double _wClass = 90;
  static const double _wSubject = 80;
  static const double _wChapter = 120;
  static const double _wEdit = 70;
  static const double _wDelete = 70;

  double get _tableWidth =>
      _wSr + _wClass + _wSubject + _wChapter + _wEdit + _wDelete;

  // TODO: replace with API data
  List<TemplateRecord> _records = [
    TemplateRecord(templateId: 1, className: '1', subject: 'English', chapter: 'Test Chapter', hasTemplate: false),
    TemplateRecord(templateId: 2, className: '8', subject: 'English', chapter: 'The Wit that Won Hearts', hasTemplate: false),
    TemplateRecord(templateId: 3, className: '6', subject: 'English', chapter: "A FRIEND'S PRAYER", hasTemplate: false),
    TemplateRecord(templateId: 4, className: '2', subject: 'Maths', chapter: 'Subtraction', hasTemplate: true),
    TemplateRecord(templateId: 5, className: '9', subject: 'English', chapter: 'test', hasTemplate: false),
    TemplateRecord(templateId: 6, className: '10', subject: 'Games', chapter: 'demo test', hasTemplate: false),
    TemplateRecord(templateId: 7, className: '5', subject: 'Games', chapter: 'test', hasTemplate: false),
    TemplateRecord(templateId: 8, className: '2', subject: 'Maths', chapter: 'new', hasTemplate: false),
    TemplateRecord(templateId: 9, className: 'Nursery', subject: 'English', chapter: 'Testing Chapter', hasTemplate: false),
  ];

  List<TemplateRecord> get _filtered {
    if (_searchQuery.isEmpty) return _records;
    final q = _searchQuery.toLowerCase();
    return _records
        .where((r) =>
    r.className.toLowerCase().contains(q) ||
        r.subject.toLowerCase().contains(q) ||
        r.chapter.toLowerCase().contains(q))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ─────────────────────────────
                Text(
                  'Lesson Plan Template',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
                SizedBox(height: 10.h),

                // ── Table (fills remaining space) ──────
                Expanded(
                  child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _filtered.isEmpty
                      ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.storage_outlined,
                            size: 40.w, color: Colors.black26),
                        SizedBox(height: 8.h),
                        Text('No data available in table',
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: Colors.black38)),
                      ],
                    ),
                  )
                      : _buildScrollableTable(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Horizontal + vertical scroll for the table
  Widget _buildScrollableTable() {
    return Scrollbar(
      // optional: outer scrollbar for horizontal
      thumbVisibility: true,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: _tableWidth.w,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(10.r),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                // Header (fixed at top)
                _buildTableHeader(),

                // Rows scroll vertically
                Expanded(
                  child: Scrollbar(
                    thumbVisibility: true,
                    child: SingleChildScrollView(
                      child: Column(
                        children: _filtered
                            .asMap()
                            .entries
                            .map((e) => _buildTableRow(e.key + 1, e.value))
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
          _headerCell('Sr. No', _wSr),
          _headerCell('Class', _wClass),
          _headerCell('Subject', _wSubject),
          _headerCell('Chapter', _wChapter),
          _headerCell('Edit', _wEdit, center: true),
          _headerCell('Delete', _wDelete, center: true),
        ],
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

  Widget _buildTableRow(int srNo, TemplateRecord r) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          _bodyCell('$srNo', _wSr),
          _bodyCell(r.className, _wClass),
          _bodyCell(r.subject, _wSubject),
          _bodyCell(r.chapter, _wChapter, maxLines: 2),
          SizedBox(
            width: _wEdit.w,
            child: r.hasTemplate
                ? Center(
              child: IconButton(
                onPressed: () {
                  // TODO: navigate to Edit Template
                },
                icon: Icon(Icons.edit_outlined,
                    size: 18.w, color: Colors.blue.shade700),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            )
                : const SizedBox.shrink(),
          ),
          SizedBox(
            width: _wDelete.w,
            child: r.hasTemplate
                ? Center(
              child: IconButton(
                onPressed: () {
                  setState(() => _records.remove(r));
                },
                icon: Icon(Icons.delete_outline_rounded,
                    size: 18.w, color: Colors.red.shade700),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            )
                : const SizedBox.shrink(),
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
  const _TemplateBrowseTab();

  @override
  State<_TemplateBrowseTab> createState() => _TemplateBrowseTabState();
}

class _TemplateBrowseTabState extends State<_TemplateBrowseTab> {
  // TODO: load from APIs
  final List<String> _classes = ['1', '2', '4', '5', '6', '8', '9', '10', 'Nursery'];
  final List<String> _subjects = ['English', 'Maths', 'Games', 'History'];
  final List<String> _chapters = ['Subtraction', 'Test Chapter', 'new', 'test'];

  String? _selectedClass;
  String? _selectedSubject;
  String? _selectedChapter;
  bool _isLoading = false;

  Future<void> _browse() async {
    if (_selectedClass == null ||
        _selectedSubject == null ||
        _selectedChapter == null) {
      _showSnack('Please select Class, Subject and Chapter', false);
      return;
    }

    setState(() => _isLoading = true);
    try {
      // TODO: call API → check if template exists for this class+subject+chapter
      final bool templateExists = false; // from API

      if (!mounted) return;
      if (templateExists) {
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (_) => LessonPlanTemplateEditScreen(record: ...),
        // ));
      } else {
        // Navigator.push(context, MaterialPageRoute(
        //   builder: (_) => LessonPlanTemplateCreateScreen(
        //     className: _selectedClass!,
        //     subject: _selectedSubject!,
        //     chapter: _selectedChapter!,
        //   ),
        // ));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
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
                    Text(
                      'Lesson Plan Template',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    Expanded(
                      child: _styledDropdown(
                        label: 'Class',
                        hint: 'Select',
                        value: _selectedClass,
                        items: _classes,
                        onChanged: (v) => setState(() => _selectedClass = v),
                        required: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _styledDropdown(
                        label: 'Subject',
                        hint: 'Select',
                        value: _selectedSubject,
                        items: _subjects,
                        onChanged: (v) => setState(() => _selectedSubject = v),
                        required: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: _styledDropdown(
                        label: 'Chapter',
                        hint: 'Select',
                        value: _selectedChapter,
                        items: _chapters,
                        onChanged: (v) => setState(() => _selectedChapter = v),
                        required: true,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Padding(
                      padding: EdgeInsets.only(top: 22.h),
                      child: SizedBox(
                        height: 48.h,
                        child: ElevatedButton.icon(
                          onPressed: _isLoading ? null : _browse,
                          icon: _isLoading
                              ? SizedBox(
                            width: 18.w,
                            height: 18.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Icon(Icons.search_rounded, size: 18.w),
                          label: Text(_isLoading ? 'Loading...' : 'Browse'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade600,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _styledDropdown({
    required String label,
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
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
                ? [TextSpan(text: ' *', style: TextStyle(color: Colors.red.shade700))]
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
          child: DropdownButtonFormField<String>(
            value: value,
            isExpanded: true,
            hint: Text(hint,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500)),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              isDense: true,
            ),
            items: items
                .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e, style: TextStyle(fontSize: 13.sp)),
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