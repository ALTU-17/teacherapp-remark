// create_edit_lesson_plan_template.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'lesson_plan_template_api_service.dart';
import 'models.dart';

enum TemplateFormMode { create, edit }

class LessonPlanTemplateFormScreen extends StatefulWidget {
  final TemplateFormMode mode;
  final int classId;
  final int subjectId;
  final int chapterId;
  final String regId;
  final String className;
  final String subject;
  final String chapter;
  final int? templateId;
  final List<TemplateDetail> existingDetails;

  const LessonPlanTemplateFormScreen({
    super.key,
    required this.mode,
    required this.classId,
    required this.subjectId,
    required this.chapterId,
    required this.regId,
    required this.className,
    required this.subject,
    required this.chapter,
    this.templateId,
    this.existingDetails = const [],
  });

  @override
  State<LessonPlanTemplateFormScreen> createState() =>
      _LessonPlanTemplateFormScreenState();
}

class _LessonPlanTemplateFormScreenState
    extends State<LessonPlanTemplateFormScreen> {
  final LessonPlanTemplateApiService _apiService =
      LessonPlanTemplateApiService();
  List<TemplateFieldData> _fields = [];
  bool _isLoadingHeadings = true;
  bool _isSaving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadHeadings();
  }

  Future<void> _loadHeadings() async {
    setState(() {
      _isLoadingHeadings = true;
      _error = null;
    });

    try {
      final headings = await _apiService.getNonDailyHeadings();
      final descriptionByHeading = {
        for (final detail in widget.existingDetails)
          detail.headingId: detail.description,
      };

      for (final field in _fields) {
        field.dispose();
      }

      _fields = headings.map((heading) {
        return TemplateFieldData(
          headingId: heading.headingId,
          headingName: heading.name,
          controller: TextEditingController(
            text: descriptionByHeading[heading.headingId] ?? '',
          ),
        );
      }).toList();
    } catch (e) {
      _error = e.toString();
    } finally {
      if (mounted) {
        setState(() => _isLoadingHeadings = false);
      }
    }
  }

  @override
  void dispose() {
    for (final field in _fields) {
      field.dispose();
    }
    super.dispose();
  }

  bool get isEdit => widget.mode == TemplateFormMode.edit;

  int get _resolvedTemplateId {
    final explicitId = widget.templateId ?? 0;
    if (explicitId > 0) return explicitId;
    if (widget.existingDetails.isNotEmpty) {
      return widget.existingDetails.first.templateId;
    }
    return 0;
  }

  List<Map<String, dynamic>> _buildDescriptions() {
    return _fields.map((field) {
      final text = field.controller.text.trimRight();
      final description = text.trim() == '•' ? '' : text;
      return {
        'lesson_plan_headings_id': field.headingId,
        'description': description,
      };
    }).toList();
  }

  Future<void> _onSave({required bool publish}) async {
    if (_isSaving) return;

    setState(() => _isSaving = true);

    try {
      if (isEdit && _resolvedTemplateId <= 0) {
        throw Exception('Lesson plan template id missing');
      }

      final descriptions = _buildDescriptions();
      final message = isEdit
          ? await _apiService.updateTemplate(
              templateId: _resolvedTemplateId,
              classId: widget.classId,
              subjectId: widget.subjectId,
              chapterId: widget.chapterId,
              descriptions: descriptions,
              publish: publish,
            )
          : await _apiService.saveTemplate(
              classId: widget.classId,
              subjectId: widget.subjectId,
              chapterId: widget.chapterId,
              descriptions: descriptions,
              publish: publish,
            );

      if (!mounted) return;
      _showSnack(message, true);
      await Future.delayed(const Duration(milliseconds: 600));
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      _showSnack(e.toString(), false);
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _reset() {
    setState(() {
      for (final field in _fields) {
        field.controller.clear();
      }
    });
  }

  void _showSnack(String msg, bool ok) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(children: [
          Icon(ok ? Icons.check_circle : Icons.error_outline,
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
            onPressed: () => Navigator.of(context).pop(false),
          ),
          title: Text(
            isEdit
                ? 'Edit Lesson Plan Template'
                : 'Create Lesson Plan Template',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(14.w),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r)),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: _buildBody(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_isLoadingHeadings) {
      return SizedBox(
        height: 220.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null) {
      return SizedBox(
        height: 220.h,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.error_outline, color: Colors.red.shade700, size: 32.w),
              SizedBox(height: 8.h),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.sp),
              ),
              SizedBox(height: 12.h),
              ElevatedButton.icon(
                onPressed: _loadHeadings,
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: [
            _chip(Icons.home_work_rounded, 'Class: ${widget.className}',
                Colors.purple),
            _chip(Icons.menu_book_rounded, 'Subject: ${widget.subject}',
                Colors.blue),
            _chip(Icons.edit_note_rounded, 'Chapter: ${widget.chapter}',
                Colors.orange),
          ],
        ),
        SizedBox(height: 16.h),
        if (_fields.isEmpty)
          SizedBox(
            height: 160.h,
            child: Center(
              child: Text(
                'No lesson plan headings found',
                style: TextStyle(fontSize: 13.sp, color: Colors.black54),
              ),
            ),
          )
        else
          _buildHeadingTable(),
        SizedBox(height: 16.h),
        _buildActionButtons(),
      ],
    );
  }

  Widget _buildHeadingTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book_rounded,
                color: Colors.blue.shade700, size: 18.w),
            SizedBox(width: 8.w),
            Text(
              'Teaching Details',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        LayoutBuilder(
          builder: (context, constraints) {
            final fieldWidth = constraints.maxWidth < 390.w ? 112.w : 150.w;

            return Container(
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10.r),
              ),
              clipBehavior: Clip.hardEdge,
              child: Column(
                children: [
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: fieldWidth,
                          child: Text(
                            'Field',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Content',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue.shade700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ..._fields.map(
                    (field) => _buildTeachingDetailRow(field, fieldWidth),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTeachingDetailRow(TemplateFieldData field, double fieldWidth) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: fieldWidth,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(_headingIcon(field.headingId),
                    size: 16.w, color: Colors.blue.shade700),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    field.headingName,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TextField(
              controller: field.controller,
              minLines: 3,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                hintText: '• Enter details...',
                isDense: true,
              ),
              style: TextStyle(fontSize: 12.sp),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  _applyBulletFormatting(field.controller);
                }
              },
              onTap: () {
                if (field.controller.text.isEmpty) {
                  field.controller.value = const TextEditingValue(
                    text: '• ',
                    selection: TextSelection.collapsed(offset: 2),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _headingIcon(int headingId) {
    switch (headingId) {
      case 2:
        return Icons.track_changes_rounded;
      case 3:
        return Icons.menu_book_rounded;
      case 4:
        return Icons.edit_rounded;
      case 5:
        return Icons.military_tech_rounded;
      case 6:
        return Icons.groups_rounded;
      case 7:
        return Icons.home_work_rounded;
      case 8:
        return Icons.notes_rounded;
      case 9:
        return Icons.emoji_events_rounded;
      case 88:
        return Icons.format_list_bulleted_rounded;
      case 90:
        return Icons.calendar_view_month_rounded;
      case 93:
        return Icons.map_outlined;
      case 95:
        return Icons.format_list_numbered_rounded;
      default:
        return Icons.article_outlined;
    }
  }

  void _applyBulletFormatting(TextEditingController controller) {
    final text = controller.text;
    final selection = controller.selection;
    final lines = text.split('\n');
    final formattedLines = lines.map((line) {
      if (line.isEmpty) return line;
      if (line == '• ') return line;
      if (line.startsWith('• ')) return line;
      return '• $line';
    }).toList();

    final newText = formattedLines.join('\n');
    if (newText == text) return;

    var cursorPos = selection.baseOffset;
    var addedChars = 0;
    var charCount = 0;

    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final lineEnd = charCount + line.length;
      if (cursorPos <= lineEnd) break;
      if (line.isNotEmpty && !line.startsWith('• ')) addedChars += 2;
      charCount += line.length + 1;
    }

    if (cursorPos > 0 && cursorPos <= text.length) {
      final currentLineStart = text.lastIndexOf('\n', cursorPos - 1) + 1;
      final nextBreak = text.indexOf('\n', cursorPos);
      final currentLine = text.substring(
        currentLineStart,
        nextBreak == -1 ? text.length : nextBreak,
      );
      if (currentLine.isNotEmpty && !currentLine.startsWith('• ')) {
        addedChars += 2;
      }
    }

    final newCursor = (cursorPos + addedChars).clamp(0, newText.length);
    controller.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newCursor),
    );
  }

  Widget _buildActionButtons() {
    final buttons = isEdit
        ? [
            _filledBtn(
              label: 'Update',
              color: Colors.blue,
              onTap: _isSaving ? null : () => _onSave(publish: false),
            ),
            _filledBtn(
              label: 'Update & Publish',
              color: Colors.blue.shade700,
              onTap: _isSaving ? null : () => _onSave(publish: true),
            ),
            _filledBtn(
              label: 'Back',
              color: Colors.amber,
              onTap: _isSaving ? null : () => Navigator.of(context).pop(false),
            ),
          ]
        : [
            _filledBtn(
              label: 'Save',
              color: Colors.blue,
              onTap: _isSaving ? null : () => _onSave(publish: false),
            ),
            _filledBtn(
              label: 'Save & Publish',
              color: Colors.blue.shade700,
              onTap: _isSaving ? null : () => _onSave(publish: true),
            ),
            _filledBtn(
              label: 'Reset',
              color: Colors.red,
              onTap: _isSaving ? null : _reset,
            ),
            _filledBtn(
              label: 'Back',
              color: Colors.amber,
              onTap: _isSaving ? null : () => Navigator.of(context).pop(false),
            ),
          ];

    return Align(
      alignment: Alignment.centerRight,
      child: Wrap(
        alignment: WrapAlignment.end,
        spacing: 10.w,
        runSpacing: 10.h,
        children: buttons,
      ),
    );
  }

  Widget _filledBtn({
    required String label,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return SizedBox(
      height: 40.h,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _chip(IconData icon, String label, MaterialColor color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.shade200),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.w, color: color.shade700),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: color.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
