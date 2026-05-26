import 'package:flutter/material.dart';
import 'package:teacherapp/features/curriculum/LessonPlan/services/lp_api_service.dart';
import 'package:teacherapp/features/curriculum/LessonPlan/view/plan_tab_viewmodel.dart';
import '../models/lesson_plan_models.dart';

class EditLessonPlanScreen extends StatefulWidget {
  final LessonPlanData record;

  const EditLessonPlanScreen({super.key, required this.record});

  @override
  State<EditLessonPlanScreen> createState() => _EditLessonPlanScreenState();
}

class _EditLessonPlanScreenState extends State<EditLessonPlanScreen> {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool _isSaving = false;
  String? _error;

  final periodsController = TextEditingController();
  final dateController = TextEditingController();
  String? _periodsError;
  String? _dateError;

  // Dynamic heading fields
  List<_EditField> _fields = [];

  // Teaching points
  final List<TeachingPointData> _teachingPoints = [TeachingPointData()];

  // Data from lesson plan details (for IDs needed in PUT)
  int _lesPlnTempId = 0;
  int _unqId = 0;
  int _lessonPlanId = 0;

  @override
  void initState() {
    super.initState();
    _loadEditData();
  }

  Future<void> _loadEditData() async {
    setState(() => _isLoading = true);

    try {
      // Load headings and lesson plan details in parallel
      final results = await Future.wait([
        _apiService.getLessonPlanHeadingNonDaily(),
        _apiService.getLessonPlanDetails(
          classId: widget.record.classId,
          sectionId: widget.record.sectionId,
          smId: widget.record.subjectId,
          chapterId: widget.record.chapterId,
        ),
      ]);

      final headingsResponse =
      results[0] as LessonPlanHeadingNonDailyResponse;
      final detailsResponse = results[1] as LessonPlanDetailsResponse;

      final details = detailsResponse.data;
      _lesPlnTempId = details.lesPlnTempId;
      _unqId = details.unqId;
      _lessonPlanId = widget.record.lessonPlanId;

      // Populate periods and date from record
      periodsController.text = widget.record.noOfPeriods;
      dateController.text = widget.record.weekDate;

      // Build fields: merge headings with existing descriptions
      final Map<int, String> descriptionMap = {};
      for (var item in details.lessonPlanInfo1) {
        descriptionMap[item.lessonPlanHeadingsId] = item.description ?? '';
      }

      _fields = headingsResponse.data.map((heading) {
        return _EditField(
          lessonPlanHeadingsId: heading.lessonPlanHeadingsId,
          headingName: heading.name,
          controller: TextEditingController(
            text: descriptionMap[heading.lessonPlanHeadingsId] ?? '',
          ),
        );
      }).toList();

      // Populate teaching points from details if available
      // (dc_description rows — use existing teachingPoints or reset)
      _teachingPoints.clear();
      _teachingPoints.add(TeachingPointData());
    } catch (e) {
      _error = e.toString();
      print('Error loading edit data: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  bool _validate() {
    bool valid = true;
    setState(() {
      _periodsError =
      periodsController.text.trim().isEmpty ? 'Required' : null;
      _dateError = dateController.text.trim().isEmpty ? 'Required' : null;
    });
    if (_periodsError != null || _dateError != null) valid = false;
    return valid;
  }

  Future<void> _update() async {
    if (!_validate()) {
      _showSnackBar(
        'Please fill No. of Periods and Date',
        const Color(0xFFC62828),
        Icons.warning_amber_rounded,
      );
      return;
    }

    setState(() => _isSaving = true);

    try {
      final classId = widget.record.classId.toString();
      final sectionId = widget.record.sectionId.toString();
      final smId = widget.record.subjectId.toString();
      final chapterId = widget.record.chapterId.toString();

      final Map<String, dynamic> descriptions = {};
      for (var field in _fields) {
        descriptions['description_${field.lessonPlanHeadingsId}_1'] =
            field.controller.text;
      }

      final List<String> startDates = [];
      final Map<String, dynamic> dcDescriptions = {};
      for (int i = 0; i < _teachingPoints.length; i++) {
        final point = _teachingPoints[i];
        final row = i + 1;
        final rawDate = point.dateController.text;
        String formattedDate = rawDate;
        if (rawDate.contains('/')) {
          final parts = rawDate.split('/');
          if (parts.length == 3) {
            formattedDate =
            '${parts[2].padLeft(4, '0')}-${parts[1].padLeft(2, '0')}-${parts[0].padLeft(2, '0')}';
          }
        }
        startDates.add(formattedDate);
        dcDescriptions['dc_description_1_$row'] = point.pointController.text;
      }

      final payload = <String, dynamic>{
        'class_id': classId,
        'section_id': sectionId,
        'sm_id': smId,
        'chapter_id': chapterId,
        'class_id_array': ['$classId^$sectionId'],
        'no_of_periods': periodsController.text,
        'weeklyDatePicker': dateController.text,
        'les_pln_temp_id': _lesPlnTempId,
        'approve': 'N',
        'lph_dc_row': _teachingPoints.length.toString(),
        'start_date': startDates,
        'lesson_plan_id': _lessonPlanId,
        'unq_id': _unqId,
        ...descriptions,
        ...dcDescriptions,
      };

      print('update_lesson_plan payload: $payload');

      final response = await _apiService.updateLessonPlan(
        unqId: _unqId,
        payload: payload,
      );

      if (response['success'] == true) {
        if (!mounted) return;
        _showSnackBar(
          response['message'] ?? 'Lesson Plan Updated Successfully',
          const Color(0xFF2E7D32),
          Icons.check_circle,
        );
        await Future.delayed(const Duration(milliseconds: 800));
        if (!mounted) return;
        Navigator.of(context).pop(true); // true = refresh list
      } else {
        _showSnackBar(
          response['message'] ?? 'Update failed',
          const Color(0xFFC62828),
          Icons.error_outline,
        );
      }
    } catch (e) {
      _showSnackBar(e.toString(), const Color(0xFFC62828), Icons.error_outline);
    } finally {
      setState(() => _isSaving = false);
    }
  }

  void _showSnackBar(String message, Color color, IconData icon) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 10),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    periodsController.dispose();
    dateController.dispose();
    for (var f in _fields) {
      f.dispose();
    }
    for (var p in _teachingPoints) {
      p.dispose();
    }
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
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          title: const Text(
            'Edit Lesson Plan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
        ),
        body: _isLoading
            ? const Center(
          child: CircularProgressIndicator(color: Colors.white),
        )
            : _error != null
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline,
                  color: Colors.white, size: 40),
              const SizedBox(height: 12),
              Text(
                _error!,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _loadEditData,
                child: const Text('Retry'),
              ),
            ],
          ),
        )
            : SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Info Chips ──────────────────────────
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          spacing: 6,
                          runSpacing: 8,
                          children: [
                            _infoChip(
                              Icons.home_work_outlined,
                              'Class',
                              widget.record.fullClassName,
                            ),
                            _infoChip(
                              Icons.menu_book_outlined,
                              'Subject',
                              widget.record.subName,
                            ),
                            _infoChip(
                              Icons.edit_note_outlined,
                              'Chapter',
                              widget.record.name,
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        // ── Periods + Date ──────────────
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('No. of Periods',
                                      required: true),
                                  const SizedBox(height: 6),
                                  TextField(
                                    controller: periodsController,
                                    keyboardType:
                                    TextInputType.number,
                                    onChanged: (_) => setState(() {
                                      _periodsError = null;
                                    }),
                                    decoration: InputDecoration(
                                      hintText: '0',
                                      errorText: _periodsError,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: _periodsError != null
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                      enabledBorder:
                                      OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: _periodsError != null
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12),
                                      isDense: true,
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  _buildLabel('Date',
                                      required: true),
                                  const SizedBox(height: 6),
                                  TextField(
                                    controller: dateController,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      hintText: 'Pick date',
                                      errorText: _dateError,
                                      suffixIcon: const Icon(
                                          Icons.calendar_today,
                                          size: 16),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: _dateError != null
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                      enabledBorder:
                                      OutlineInputBorder(
                                        borderRadius:
                                        BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                          color: _dateError != null
                                              ? Colors.red
                                              : Colors.grey,
                                        ),
                                      ),
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 12),
                                      isDense: true,
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                    onTap: () async {
                                      final date =
                                      await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2020),
                                        lastDate: DateTime(2030),
                                      );
                                      if (date != null) {
                                        dateController.text =
                                        '${date.day}/${date.month}/${date.year}';
                                        setState(
                                                () => _dateError = null);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Dynamic Heading Fields ──────────────
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Teaching Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                // Header
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 12),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE3F2FD),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: Text(
                                          'Field',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight:
                                            FontWeight.w700,
                                            color: Color(0xFF1565C0),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 210,
                                        child: Text(
                                          'Content',
                                          style: TextStyle(
                                            fontSize: 13,
                                            fontWeight:
                                            FontWeight.w700,
                                            color: Color(0xFF1565C0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Dynamic rows
                                ..._fields.map((field) {
                                  return _buildDetailRow(
                                    field.headingName,
                                    _headingIcon(
                                        field.lessonPlanHeadingsId),
                                    field.controller,
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // ── Teaching Points ─────────────────────
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Teaching Points',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            FloatingActionButton.small(
                              onPressed: () => setState(() =>
                                  _teachingPoints
                                      .add(TeachingPointData())),
                              backgroundColor:
                              const Color(0xFF1976D2),
                              child: const Icon(Icons.add,
                                  color: Colors.white, size: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                // Header
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 12),
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFE3F2FD),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(8),
                                      topRight: Radius.circular(8),
                                    ),
                                  ),
                                  child: const Row(
                                    children: [
                                      SizedBox(
                                        width: 130,
                                        child: Text('Start Date',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w700,
                                                color: Color(
                                                    0xFF1565C0))),
                                      ),
                                      SizedBox(
                                        width: 145,
                                        child: Text(
                                            'Teaching Points',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w700,
                                                color: Color(
                                                    0xFF1565C0))),
                                      ),
                                      // SizedBox(
                                      //   width: 120,
                                      //   child: Text('Daily Time',
                                      //       style: TextStyle(
                                      //           fontSize: 13,
                                      //           fontWeight:
                                      //           FontWeight.w700,
                                      //           color: Color(
                                      //               0xFF1565C0))),
                                      // ),
                                      SizedBox(
                                        // width: 70,
                                        child: Text('Action',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight:
                                                FontWeight.w700,
                                                color: Color(
                                                    0xFF1565C0))),
                                      ),
                                    ],
                                  ),
                                ),
                                ..._teachingPoints
                                    .asMap()
                                    .entries
                                    .map((e) => _buildTeachingRow(
                                    e.key, e.value)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // ── Update + Back Buttons ───────────────
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: _isSaving ? null : _update,
                        icon: _isSaving
                            ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                            AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        )
                            : const Icon(Icons.update),
                        label: const Text('Update'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF1976D2),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () =>
                            Navigator.of(context).pop(false),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF9800),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(8)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      String title, IconData icon, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(icon, size: 18, color: const Color(0xFF1565C0)),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 210,
            child: TextField(
              controller: controller,
              maxLines: 4,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                hintText: 'Enter details...',
                isDense: true,
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachingRow(int index, TeachingPointData point) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: TextField(
              controller: point.dateController,
              readOnly: true,
              decoration: const InputDecoration(
                hintText: 'DD/MM/YYYY',
                hintStyle: TextStyle(fontSize: 10),
                suffixIcon: Icon(Icons.calendar_today, size: 14),
                border: OutlineInputBorder(),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                isDense: true,
              ),
              style: const TextStyle(fontSize: 12),
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2030),
                );
                if (date != null) {
                  point.dateController.text =
                  '${date.day}/${date.month}/${date.year}';
                  setState(() {});
                }
              },
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 160,
            child: TextField(
              controller: point.pointController,
              maxLines: 2,
              decoration: const InputDecoration(
                hintText: 'Enter teaching point...',
                border: OutlineInputBorder(),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                isDense: true,
              ),
              style: const TextStyle(fontSize: 12),
            ),
          ),

          SizedBox(
            width: 60,
            child: IconButton(
              onPressed: () {
                if (_teachingPoints.length > 1) {
                  setState(() => _teachingPoints.removeAt(index));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('At least one teaching point is required'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.delete_outline,
                  size: 20, color: Color(0xFFE53935)),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoChip(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF1565C0)),
          const SizedBox(width: 4),
          Text(
            '$label: $value',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Color(0xFF1565C0),
            ),
          ),
        ],
      ),
    );
  }

  IconData _headingIcon(int headingId) {
    switch (headingId) {
      case 2: return Icons.track_changes;
      case 3: return Icons.menu_book;
      case 4: return Icons.edit;
      case 5: return Icons.military_tech;
      case 6: return Icons.groups;
      case 7: return Icons.home_work;
      case 8: return Icons.notes;
      case 9: return Icons.emoji_events;
      case 88: return Icons.format_list_bulleted;
      case 90: return Icons.calendar_view_month;
      case 93: return Icons.map_outlined;
      case 95: return Icons.format_list_numbered;
      default: return Icons.article_outlined;
    }
  }
}
Widget _buildLabel(String text, {bool required = false}) {
  return RichText(
    text: TextSpan(
      text: text,
      style: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
        letterSpacing: 0.3,
      ),
      children: required
          ? const [
        TextSpan(
          text: ' *',
          style: TextStyle(color: Color(0xFFE53935)),
        ),
      ]
          : [],
    ),
  );
}

// Supporting class for edit fields
class _EditField {
  final int lessonPlanHeadingsId;
  final String headingName;
  final TextEditingController controller;

  _EditField({
    required this.lessonPlanHeadingsId,
    required this.headingName,
    required this.controller,
  });

  void dispose() => controller.dispose();
}