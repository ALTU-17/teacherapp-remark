import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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

  DateTime? _selectedWeekStart;
  DateTime? _selectedWeekEnd;
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
      // Fetch all 3 in parallel
      final results = await Future.wait([
        _apiService.getLessonPlanHeadingNonDaily(),
        _apiService.getLessonPlanDetails(
          classId: widget.record.classId,
          sectionId: widget.record.sectionId,
          smId: widget.record.subjectId,
          chapterId: widget.record.chapterId,
        ),
        _apiService.getLessonPlanByUnqId(widget.record.unqId),
      ]);

      final headingsResponse = results[0] as LessonPlanHeadingNonDailyResponse;
      final detailsResponse = results[1] as LessonPlanDetailsResponse;
      final savedResponse = results[2] as Map<String, dynamic>;

      print('Saved Response: $savedResponse');

      final details = detailsResponse.data;
      _lesPlnTempId = details.lesPlnTempId;
      _unqId = details.unqId;
      _lessonPlanId = widget.record.lessonPlanId;

      // Populate periods and date from record
      periodsController.text = widget.record.noOfPeriods;
      dateController.text = widget.record.weekDate;

      // ── Build description map from saved data ──────────
      final Map<int, String> descriptionMap = {};

      if (savedResponse['data'] != null) {
        final savedData = savedResponse['data'];
        final savedDetails = savedData['details'] as List? ?? [];

        for (var item in savedDetails) {
          final headingId = item['lesson_plan_headings_id'] as int?;
          final description = item['description'] as String?;
          if (headingId != null && description != null && description.isNotEmpty) {
            descriptionMap[headingId] = description;
          }
        }
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

      // ── Parse teaching points from saved data ──────────
      _teachingPoints.clear();

      if (savedResponse['data'] != null) {
        final savedData = savedResponse['data'];
        final savedDetails = savedData['details'] as List? ?? [];

        // Get teaching points from heading_id: 1
        final teachingPointItems = savedDetails
            .where((item) =>
        item['lesson_plan_headings_id'] == 1 &&
            item['description'] != null &&
            item['description'].toString().isNotEmpty)
            .toList();

        if (teachingPointItems.isNotEmpty) {
          for (var item in teachingPointItems) {
            final point = TeachingPointData();
            point.pointController.text = item['description']?.toString() ?? '';

            final startDate = item['start_date'] as String?;
            if (startDate != null && startDate.isNotEmpty) {
              final dateParts = startDate.split('-');
              if (dateParts.length == 3) {
                point.dateController.text =
                '${dateParts[2]}/${dateParts[1]}/${dateParts[0]}';
              }
            }

            _teachingPoints.add(point);
          }
        }

        // If no teaching points found with heading_id 1, check other IDs
        if (_teachingPoints.isEmpty) {
          final otherTeachingPoints = savedDetails
              .where((item) =>
          [88, 90, 93, 95].contains(item['lesson_plan_headings_id']) &&
              item['description'] != null &&
              item['description'].toString().isNotEmpty)
              .toList();

          if (otherTeachingPoints.isNotEmpty) {
            for (var item in otherTeachingPoints) {
              final point = TeachingPointData();
              point.pointController.text = item['description']?.toString() ?? '';

              final startDate = item['start_date'] as String?;
              if (startDate != null && startDate.isNotEmpty) {
                final dateParts = startDate.split('-');
                if (dateParts.length == 3) {
                  point.dateController.text =
                  '${dateParts[2]}/${dateParts[1]}/${dateParts[0]}';
                }
              }

              _teachingPoints.add(point);
            }
          }
        }
      }

      // Fallback: at least one empty row
      if (_teachingPoints.isEmpty) {
        _teachingPoints.add(TeachingPointData());
      }

      // Parse week range for date picker restriction
      _parseAndStoreWeekRange(widget.record.weekDate);

    } catch (e) {
      _error = e.toString();
      print('Error loading edit data: $e');
      print('Stack trace: ${StackTrace.current}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _parseAndStoreWeekRange(String weekDate) {
    try {
      if (weekDate.isEmpty) return;

      final parts = weekDate.split(' / ');
      if (parts.length == 2) {
        final startDateStr = parts[0].trim();
        final endDateStr = parts[1].trim();

        final start = _parseDateFromDDMMYYYY(startDateStr);
        final end = _parseDateFromDDMMYYYY(endDateStr);

        if (start != null && end != null) {
          _selectedWeekStart = start;
          _selectedWeekEnd = end;
          print('Week range parsed: $_selectedWeekStart - $_selectedWeekEnd');
        }
      }
    } catch (e) {
      print('Error parsing week date: $e');
      _selectedWeekStart = null;
      _selectedWeekEnd = null;
    }
  }

  DateTime? _parseDateFromDDMMYYYY(String dateStr) {
    try {
      final parts = dateStr.split('-');
      if (parts.length == 3) {
        final day = int.tryParse(parts[0].trim());
        final month = int.tryParse(parts[1].trim());
        final year = int.tryParse(parts[2].trim());

        if (day != null && month != null && year != null) {
          return DateTime(year, month, day);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  bool _validate() {
    bool valid = true;
    setState(() {
      _periodsError = periodsController.text.trim().isEmpty ? 'Required' : null;
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
        if (field.controller.text.trim().isNotEmpty) {
          descriptions['description_${field.lessonPlanHeadingsId}_1'] =
              field.controller.text;
        }
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

        if (point.pointController.text.trim().isNotEmpty) {
          dcDescriptions['dc_description_1_$row'] = point.pointController.text;
        }
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
        Navigator.of(context).pop(true);
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
            Icon(icon, color: Colors.white, size: 20.w),
            SizedBox(width: 10.w),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
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
            icon: Icon(Icons.arrow_back_rounded, color: Colors.white, size: 24.w),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          title: Text(
            'Edit Lesson Plan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: false,
        ),
        body: _isLoading
            ? Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3.w,
          ),
        )
            : _error != null
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.white, size: 48.w),
              SizedBox(height: 12.h),
              Text(
                _error!,
                style: TextStyle(color: Colors.white, fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: _loadEditData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.blue.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: const Text('Retry'),
              ),
            ],
          ),
        )
            : SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Info Chips Card ──────────────────────────
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
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
                              child: Icon(
                                Icons.edit_note_rounded,
                                color: Colors.blue.shade700,
                                size: 20.w,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Text(
                              'Lesson Plan Details',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 14.h),
                        // Info Chips
                        Wrap(
                          spacing: 8.w,
                          runSpacing: 8.h,
                          children: [
                            _buildInfoChip(
                              Icons.home_work_rounded,
                              widget.record.fullClassName,
                              Colors.purple,
                            ),
                            _buildInfoChip(
                              Icons.menu_book_rounded,
                              widget.record.subName,
                              Colors.blue,
                            ),
                            _buildInfoChip(
                              Icons.edit_note_rounded,
                              widget.record.name,
                              Colors.green,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.h),
                        // ── Periods + Date ──────────────
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: _buildTextField(
                                controller: periodsController,
                                label: 'No. of Periods',
                                hint: 'Enter number',
                                keyboardType: TextInputType.number,
                                errorText: _periodsError,
                                icon: Icons.numbers_rounded,
                                onChanged: (_) => setState(() {
                                  _periodsError = null;
                                }),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              flex: 3,
                              child: _buildDatePickerField(
                                controller: dateController,
                                label: 'Week Date',
                                hint: 'Select week',
                                errorText: _dateError,
                                onTap: () async {
                                  final result = await _showWeekPickerDialog();
                                  if (result != null) {
                                    dateController.text = result.label;
                                    _selectedWeekStart = result.start;
                                    _selectedWeekEnd = result.end;
                                    // Clear teaching point dates
                                    for (var p in _teachingPoints) {
                                      p.dateController.clear();
                                    }
                                    setState(() => _dateError = null);
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                // ── Teaching Details ──────────────────────
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.menu_book_rounded,
                              color: Colors.blue.shade700,
                              size: 18.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Teaching Details',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              // Header
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
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
                                      width: 140.w,
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
                              // Rows
                              ..._fields.map((field) {
                                return _buildDetailRow(
                                  field.headingName,
                                  _headingIcon(field.lessonPlanHeadingsId),
                                  field.controller,
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12.h),

                // ── Teaching Points ─────────────────────
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.list_alt_rounded,
                              color: Colors.blue.shade700,
                              size: 18.w,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Teaching Points',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            const Spacer(),
                            FloatingActionButton.small(
                              onPressed: () => setState(() =>
                                  _teachingPoints.add(TeachingPointData())),
                              backgroundColor: Colors.blue.shade700,
                              child: Icon(
                                Icons.add_rounded,
                                color: Colors.white,
                                size: 18.w,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              // Header
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 10.h),
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
                                      width: 130.w,
                                      child: Text(
                                        'Start Date*',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Teaching Point*',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.blue.shade700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                      child: Text(
                                        'Action',
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
                              // Rows
                              ..._teachingPoints.asMap().entries.map(
                                    (e) => _buildTeachingRow(e.key, e.value),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.h),

                // ── Update + Back Buttons ───────────────
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton.icon(
                        onPressed: _isSaving ? null : _update,
                        icon: _isSaving
                            ? SizedBox(
                          height: 18.w,
                          width: 18.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.w,
                            valueColor:
                            const AlwaysStoppedAnimation<Color>(
                                Colors.white),
                          ),
                        )
                            : Icon(Icons.update_rounded, size: 18.w),
                        label: Text(
                          'Update',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.of(context).pop(false),
                        icon: Icon(Icons.arrow_back_rounded, size: 18.w),
                        label: Text(
                          'Back',
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.grey.shade700,
                          side: BorderSide(color: Colors.grey.shade400),
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ── Helper Widgets ──────────────────────────────────────────

  Widget _buildInfoChip(IconData icon, String label, MaterialColor color) {
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? errorText,
    IconData? icon,
    required void Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 4.h),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
            prefixIcon: icon != null
                ? Icon(icon, size: 18.w, color: Colors.grey.shade500)
                : null,
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.blue.shade700,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            isDense: true,
            fillColor: Colors.white,
            filled: true,
          ),
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildDatePickerField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? errorText,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 4.h),
        TextField(
          controller: controller,
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade500),
            suffixIcon: Icon(
              Icons.calendar_today_rounded,
              size: 18.w,
              color: Colors.grey.shade500,
            ),
            errorText: errorText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey.shade300,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.grey.shade300,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(
                color: errorText != null ? Colors.red : Colors.blue.shade700,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            isDense: true,
            fillColor: Colors.white,
            filled: true,
          ),
          style: TextStyle(fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildDetailRow(
      String title,
      IconData icon,
      TextEditingController controller,
      ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140.w,
            child: Row(
              children: [
                Icon(icon, size: 16.w, color: Colors.blue.shade700),
                SizedBox(width: 6.w),
                Expanded(
                  child: Text(
                    title,
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
              controller: controller,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                hintText: 'Enter details...',
                isDense: true,
              ),
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeachingRow(int index, TeachingPointData point) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        color: index.isEven ? Colors.white : Colors.grey.shade50,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130.w,
            child: TextField(
              controller: point.dateController,
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'DD/MM/YYYY',
                hintStyle: TextStyle(fontSize: 11.sp),
                suffixIcon: Icon(
                  Icons.calendar_today_rounded,
                  size: 14.w,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: point.dateError != null ? Colors.red : Colors.grey.shade300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: point.dateError != null ? Colors.red : Colors.grey.shade300,
                  ),
                ),
                errorText: point.dateError,
                contentPadding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 8.h),
                isDense: true,
              ),
              style: TextStyle(fontSize: 12.sp),
              onTap: () async {
                if (_selectedWeekStart == null || _selectedWeekEnd == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(Icons.warning_amber_rounded,
                              color: Colors.white, size: 20.w),
                          SizedBox(width: 10.w),
                          const Text('Please select a week first'),
                        ],
                      ),
                      backgroundColor: const Color(0xFFC62828),
                      behavior: SnackBarBehavior.floating,
                      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  return;
                }

                final date = await showDatePicker(
                  context: context,
                  initialDate: _selectedWeekStart!,
                  firstDate: _selectedWeekStart!,
                  lastDate: _selectedWeekEnd!,
                );

                if (date != null) {
                  point.dateController.text =
                  '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
                  point.dateError = null;
                  setState(() {});
                }
              },
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: TextField(
              controller: point.pointController,
              maxLines: 2,
              onChanged: (_) {
                point.pointError = null;
              },
              decoration: InputDecoration(
                hintText: 'Enter teaching point...',
                hintStyle: TextStyle(fontSize: 12.sp),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: point.pointError != null ? Colors.red : Colors.grey.shade300,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(
                    color: point.pointError != null ? Colors.red : Colors.grey.shade300,
                  ),
                ),
                errorText: point.pointError,
                contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                isDense: true,
              ),
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
          SizedBox(
            width: 50.w,
            child: Center(
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
                icon: Icon(
                  Icons.delete_outline_rounded,
                  size: 20.w,
                  color: Colors.red.shade700,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Week Picker Dialog ──────────────────────────────────────

  Future<WeekRange?> _showWeekPickerDialog() async {
    return await showDialog<WeekRange>(
      context: context,
      builder: (context) => const _WeekPickerDialog(),
    );
  }

  // ── Helper Methods ──────────────────────────────────────────

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
}

// ── Week Picker Dialog Widget ────────────────────────────────

class _WeekPickerDialog extends StatefulWidget {
  const _WeekPickerDialog();

  @override
  State<_WeekPickerDialog> createState() => _WeekPickerDialogState();
}

class _WeekPickerDialogState extends State<_WeekPickerDialog> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Row(
        children: [
          Icon(Icons.calendar_view_week_rounded, color: Colors.blue.shade700),
          SizedBox(width: 8.w),
          Text(
            'Select Week',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: 300.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month - 1,
                        1,
                      );
                    });
                  },
                  icon: Icon(Icons.chevron_left_rounded, size: 24.w),
                ),
                Text(
                  '${_selectedDate.year} - ${_selectedDate.month.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _selectedDate = DateTime(
                        _selectedDate.year,
                        _selectedDate.month + 1,
                        1,
                      );
                    });
                  },
                  icon: Icon(Icons.chevron_right_rounded, size: 24.w),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Simple week selector - shows current week
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    'Current Week',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _getWeekRange(_selectedDate),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Week navigation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedDate = _selectedDate.subtract(const Duration(days: 7));
                    });
                  },
                  icon: Icon(Icons.chevron_left_rounded, size: 16.w),
                  label: const Text('Previous'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                OutlinedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedDate = _selectedDate.add(const Duration(days: 7));
                    });
                  },
                  icon: Icon(Icons.chevron_right_rounded, size: 16.w),
                  label: const Text('Next'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade400),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final start = _getWeekStart(_selectedDate);
            final end = start.add(const Duration(days: 6));
            final label =
                '${start.day.toString().padLeft(2, '0')}-${start.month.toString().padLeft(2, '0')}-${start.year} / '
                '${end.day.toString().padLeft(2, '0')}-${end.month.toString().padLeft(2, '0')}-${end.year}';
            Navigator.pop(
              context,
              WeekRange(label: label, start: start, end: end),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue.shade700,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: const Text('Select Week'),
        ),
      ],
    );
  }

  String _getWeekRange(DateTime date) {
    final start = _getWeekStart(date);
    final end = start.add(const Duration(days: 6));
    return '${start.day.toString().padLeft(2, '0')}-${start.month.toString().padLeft(2, '0')}-${start.year} to '
        '${end.day.toString().padLeft(2, '0')}-${end.month.toString().padLeft(2, '0')}-${end.year}';
  }

  DateTime _getWeekStart(DateTime date) {
    final dayOfWeek = date.weekday;
    return date.subtract(Duration(days: dayOfWeek - 1));
  }
}

// ── Supporting Models ────────────────────────────────────────

class WeekRange {
  final String label;
  final DateTime start;
  final DateTime end;

  WeekRange({required this.label, required this.start, required this.end});
}

class TeachingPointData {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController pointController = TextEditingController();
  String? dateError;
  String? pointError;

  void dispose() {
    dateController.dispose();
    pointController.dispose();
  }
}

// ── Supporting class for edit fields ────────────────────────

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