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
    // Add alongside existing fields
    List<LessonPlanHeadingDaily> _dailyHeadings = [];
    final List<_EditTeachingPoint> _teachingPoints = [];

    final periodsController = TextEditingController();
    final dateController = TextEditingController();
    String? _periodsError;
    String? _dateError;

    // Dynamic heading fields
    List<_EditField> _fields = [];
// Replace the dc_description building block in _update():
    final List<String> startDates = [];
    final Map<String, dynamic> dcDescriptions = {};



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
        // ✅ Fetch all 4 in parallel
        final results = await Future.wait([
          _apiService.getLessonPlanHeadingNonDaily(),
          _apiService.getLessonPlanDetails(
            classId: widget.record.classId,
            sectionId: widget.record.sectionId,
            smId: widget.record.subjectId,
            chapterId: widget.record.chapterId,
          ),
          _apiService.getLessonPlanByUnqId(widget.record.unqId),
          _apiService.getLessonPlanHeadingDaily(),
        ]);

        final headingsResponse = results[0] as LessonPlanHeadingNonDailyResponse;
        final detailsResponse = results[1] as LessonPlanDetailsResponse;
        final savedResponse = results[2] as Map<String, dynamic>;
        final dailyResponse = results[3] as LessonPlanHeadingDailyResponse;

        print('Saved Response: $savedResponse');

        final details = detailsResponse.data;
        _lesPlnTempId = details!.lesPlnTempId;
        _unqId = details.unqId;
        _lessonPlanId = widget.record.lessonPlanId;

        // ✅ Store daily headings first (needed for filtering below)
        _dailyHeadings = dailyResponse.success ? dailyResponse.data : [];

        // Populate periods and date from record
        periodsController.text = widget.record.noOfPeriods;
        dateController.text = widget.record.weekDate;

        // ── Build description map (non-daily headings only) ──────
        final Map<int, String> descriptionMap = {};
        if (savedResponse['data'] != null) {
          final savedData = savedResponse['data'];
          final savedDetails = savedData['details'] as List? ?? [];

          // ✅ Exclude daily heading IDs from description map
          final dailyHeadingIds =
          _dailyHeadings.map((h) => h.lessonPlanHeadingsId).toSet();

          for (var item in savedDetails) {
            final headingId = item['lesson_plan_headings_id'] as int?;
            final description = item['description'] as String?;
            if (headingId != null &&
                description != null &&
                description.isNotEmpty &&
                !dailyHeadingIds.contains(headingId)) {
              // ✅ Only non-daily headings go into Teaching Details
              descriptionMap[headingId] = description;
            }
          }
        }

        // ── Build Teaching Details fields ────────────────────────
        _fields = headingsResponse.data.map((heading) {
          return _EditField(
            lessonPlanHeadingsId: heading.lessonPlanHeadingsId,
            headingName: heading.name,
            controller: TextEditingController(
              text: descriptionMap[heading.lessonPlanHeadingsId] ?? '',
            ),
          );
        }).toList();

        // ── Parse teaching points with dynamic columns ───────────
        _teachingPoints.clear();

        if (savedResponse['data'] != null) {
          final savedData = savedResponse['data'];
          final savedDetails = savedData['details'] as List? ?? [];

          // ✅ Get daily heading IDs for filtering
          final dailyHeadingIds =
          _dailyHeadings.map((h) => h.lessonPlanHeadingsId).toSet();

          // ✅ Filter only daily heading items
          final dailyItems = savedDetails
              .where((item) =>
              dailyHeadingIds.contains(item['lesson_plan_headings_id']))
              .toList();

          if (dailyItems.isNotEmpty) {
            // ✅ Group by start_date — items sharing same start_date = same row
            // LinkedHashMap preserves insertion order
            final Map<String, List<dynamic>> groupedByDate = {};

            for (var item in dailyItems) {
              final startDate = item['start_date']?.toString() ?? '';
              groupedByDate.putIfAbsent(startDate, () => []).add(item);
            }

            // ✅ Build one _EditTeachingPoint per group
            for (var entry in groupedByDate.entries) {
              final rawDate = entry.key; // "2026-08-05" or ""
              final items = entry.value;

              final point = _EditTeachingPoint();

              // Init all dynamic controllers first
              for (var h in _dailyHeadings) {
                point.dynamicControllers[h.lessonPlanHeadingsId] =
                    TextEditingController();
              }

              // Set start date (convert YYYY-MM-DD → DD/MM/YYYY)
              if (rawDate.isNotEmpty && rawDate != 'null') {
                final parts = rawDate.split('-');
                if (parts.length == 3) {
                  point.dateController.text =
                  '${parts[2]}/${parts[1]}/${parts[0]}';
                }
              }

              // ✅ Map each item's description to correct heading controller
              for (var item in items) {
                final headingId = item['lesson_plan_headings_id'] as int?;
                final description = item['description']?.toString() ?? '';
                if (headingId != null &&
                    point.dynamicControllers.containsKey(headingId)) {
                  point.dynamicControllers[headingId]!.text = description;
                }
              }

              _teachingPoints.add(point);
            }
          }
        }

        // ✅ Fallback: at least one empty row
        if (_teachingPoints.isEmpty) {
          final point = _EditTeachingPoint();
          for (var h in _dailyHeadings) {
            point.dynamicControllers[h.lessonPlanHeadingsId] =
                TextEditingController();
          }
          _teachingPoints.add(point);
        }

        // ✅ Parse week range for date picker restriction
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

          // ✅ Dynamic: one key per daily heading per row
          for (var h in _dailyHeadings) {
            final ctrl = point.dynamicControllers[h.lessonPlanHeadingsId];
            dcDescriptions['dc_description_${h.lessonPlanHeadingsId}_$row'] =
                ctrl?.text ?? '';
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
      for (var f in _fields) f.dispose();
      for (var p in _teachingPoints) p.dispose();
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
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            centerTitle: false,

          ),
          body: _isLoading
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3.w,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Loading lesson plan...',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          )
              : _error != null
              ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.white, size: 56.w),
                SizedBox(height: 16.h),
                Text(
                  _error!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: _loadEditData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF667eea),
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 2,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.refresh_rounded, size: 18.w),
                      SizedBox(width: 8.w),
                      Text(
                        'Retry',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
              : SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Info Chips Card ──────────────────────────
                  Card(
                    elevation: 8,
                    shadowColor: Colors.black.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFF667eea),
                                      const Color(0xFF764ba2),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Icon(
                                  Icons.edit_note_rounded,
                                  color: Colors.white,
                                  size: 22.w,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Lesson Plan Details',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800,
                                    ),
                                  ),
                                  Text(
                                    'Class • Subject • Plan',
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          // Info Chips
                          Wrap(
                            spacing: 10.w,
                            runSpacing: 10.h,
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
                          SizedBox(height: 20.h),
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
                  SizedBox(height: 16.h),

                  // ── Teaching Details ──────────────────────
                  Card(
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.08),
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
                                  Icons.menu_book_rounded,
                                  color: Colors.blue.shade700,
                                  size: 18.w,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Teaching Details',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  '${_fields.length} fields',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: MediaQuery.of(context).size.width - 64.w,
                                  ),
                                  child: Column(
                                    children: [
                                      // Header
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 16.w,
                                          vertical: 12.h,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blue.shade50,
                                              Colors.blue.shade100.withOpacity(0.5),
                                            ],
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 160.w,
                                              child: Text(
                                                'Field',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blue.shade700,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 280.w,
                                              child: Text(
                                                'Content',
                                                style: TextStyle(
                                                  fontSize: 13.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blue.shade700,
                                                  letterSpacing: 0.5,
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),

                  // ── Teaching Points ─────────────────────
                  Card(
                    elevation: 4,
                    shadowColor: Colors.black.withOpacity(0.08),
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
                                  Icons.list_alt_rounded,
                                  color: Colors.blue.shade700,
                                  size: 18.w,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Teaching Points',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey.shade800,
                                ),
                              ),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Text(
                                  '${_teachingPoints.length} entries',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.w),
                              FloatingActionButton.small(
                                onPressed: () {
                                  setState(() {
                                    final point = _EditTeachingPoint();
                                    for (var h in _dailyHeadings) {
                                      point.dynamicControllers[
                                      h.lessonPlanHeadingsId] =
                                          TextEditingController();
                                    }
                                    _teachingPoints.add(point);
                                  });
                                },
                                backgroundColor: const Color(0xFF667eea),
                                child: Icon(
                                  Icons.add_rounded,
                                  color: Colors.white,
                                  size: 20.w,
                                ),
                                elevation: 2,
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade200,
                                width: 1.5,
                              ),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12.r),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: ConstrainedBox(
                                  constraints: BoxConstraints(
                                    minWidth: MediaQuery.of(context).size.width - 64.w,
                                  ),
                                  child: Column(
                                    children: [
                                      // ── Header ──────────────────────
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.w,
                                          vertical: 12.h,
                                        ),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blue.shade50,
                                              Colors.blue.shade100.withOpacity(0.5),
                                            ],
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            // Fixed: Start Date column
                                            SizedBox(
                                              width: 140.w,
                                              child: Text(
                                                'Start Date*',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blue.shade700,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 8.w),
                                            // Dynamic heading columns
                                            ..._dailyHeadings.map(
                                                  (h) => SizedBox(
                                                width: 200.w,
                                                child: Text(
                                                  '${h.name}*',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.blue.shade700,
                                                    letterSpacing: 0.5,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            // Fixed: Delete column
                                            SizedBox(
                                              width: 60.w,
                                              child: Text(
                                                'Delete',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.blue.shade700,
                                                  letterSpacing: 0.5,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // ── Rows ─────────────────────────────
                                      ..._teachingPoints.asMap().entries.map(
                                            (e) => _buildTeachingRow(e.key, e.value),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // ── Update + Back Buttons ───────────────
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: ElevatedButton.icon(
                          onPressed: _isSaving ? null : _update,
                          icon: _isSaving
                              ? SizedBox(
                            height: 20.w,
                            width: 20.w,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5.w,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Colors.white),
                            ),
                          )
                              : Icon(Icons.update_rounded, size: 20.w),
                          label: Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 14.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            elevation: 4,
                            shadowColor: const Color(0xFF667eea).withOpacity(0.3),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => Navigator.of(context).pop(false),
                          icon: Icon(Icons.arrow_back_rounded, size: 18.w),
                          label: Text(
                            'Back',
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.grey.shade700,
                            side: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1.5,
                            ),
                            padding: EdgeInsets.symmetric(
                              vertical: 14.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
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

// ── Updated Helper Widgets ──────────────────────────────────────────

    Widget _buildInfoChip(IconData icon, String label, MaterialColor color) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.shade50,
              color.shade100.withOpacity(0.5),
            ],
          ),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: color.shade200, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16.w, color: color.shade700),
            SizedBox(width: 6.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
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
          Row(
            children: [
              if (icon != null) ...[
                Icon(icon, size: 14.w, color: Colors.grey.shade600),
                SizedBox(width: 4.w),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                ' *',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.red.shade400,
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(fontSize: 13.sp, color: Colors.grey.shade400),
              errorText: errorText,
              errorStyle: TextStyle(fontSize: 11.sp),
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
                  color: errorText != null ? Colors.red : const Color(0xFF667eea),
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade100),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 160.w,
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Icon(icon, size: 16.w, color: Colors.blue.shade700),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 280.w,
              child: TextField(
                controller: controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: Colors.grey.shade300),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(color: const Color(0xFF667eea), width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  hintText: '• Enter details...',
                  hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey.shade400),
                  isDense: true,
                  fillColor: Colors.white,
                  filled: true,
                ),
                style: TextStyle(fontSize: 13.sp),
                onTap: () {
                  if (controller.text.isEmpty) {
                    controller.value = const TextEditingValue(
                      text: '• ',
                      selection: TextSelection.collapsed(offset: 2),
                    );
                  }
                },
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    _applyBulletFormatting(controller);
                  }
                },
              ),
            ),
          ],
        ),
      );
    }
    // Auto-bullet: ensures every non-empty line starts with "• "
    void _applyBulletFormatting(TextEditingController controller) {
      final text = controller.text;
      final selection = controller.selection;

      final lines = text.split('\n');
      final formattedLines = lines.map((line) {
        if (line.isEmpty) return line;
        if (line == '• ') return line; // don't double-bullet empty bullet lines
        if (line.startsWith('• ')) return line;
        return '• $line';
      }).toList();

      final newText = formattedLines.join('\n');

      if (newText != text) {
        // Calculate new cursor position accounting for added "• " prefixes
        int cursorPos = selection.baseOffset;

        // Count how many "• " were added before cursor
        int addedChars = 0;
        int charCount = 0;
        for (int i = 0; i < lines.length; i++) {
          final line = lines[i];
          final lineEnd = charCount + line.length;

          if (cursorPos <= lineEnd) break;

          // This line is fully before cursor
          if (line.isNotEmpty && !line.startsWith('• ')) {
            addedChars += 2; // added "• "
          }
          charCount += line.length + 1; // +1 for '\n'
        }

        // Check if current line (where cursor is) also got a bullet added
        final currentLineStart = text.lastIndexOf('\n', cursorPos - 1) + 1;
        final currentLine = text.substring(currentLineStart,
            text.indexOf('\n', cursorPos) == -1 ? text.length : text.indexOf('\n', cursorPos));
        if (currentLine.isNotEmpty && !currentLine.startsWith('• ')) {
          addedChars += 2;
        }

        final newCursor = (cursorPos + addedChars).clamp(0, newText.length);

        controller.value = TextEditingValue(
          text: newText,
          selection: TextSelection.collapsed(offset: newCursor),
        );
      }
    }

    // Called on Enter key — adds bullet on new line
    void _handleBulletEnter(TextEditingController controller) {
      final text = controller.text;
      final selection = controller.selection;
      if (!selection.isValid) return;

      final cursorPos = selection.baseOffset;
      final newText = '${text.substring(0, cursorPos)}\n• ${text.substring(cursorPos)}';
      final newCursor = cursorPos + 3; // '\n• ' = 3 chars

      controller.value = TextEditingValue(
        text: newText,
        selection: TextSelection.collapsed(offset: newCursor.clamp(0, newText.length)),
      );
    }

    Widget _buildTeachingRow(int index, _EditTeachingPoint point) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          border: Border(
            bottom: index < _teachingPoints.length - 1
                ? BorderSide(color: Colors.grey.shade200)
                : BorderSide.none,
          ),
          color: index.isEven ? Colors.white : Colors.grey.shade50,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Start Date ──────────────────────────────
            SizedBox(
              width: 140.w,
              child: TextField(
                controller: point.dateController,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'DD/MM/YYYY',
                  hintStyle: TextStyle(fontSize: 11.sp, color: Colors.grey.shade400),
                  suffixIcon: Icon(
                    Icons.calendar_today_rounded,
                    size: 16.w,
                    color: Colors.grey.shade600,
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
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide(
                      color: point.dateError != null ? Colors.red : const Color(0xFF667eea),
                      width: 2,
                    ),
                  ),
                  errorText: point.dateError,
                  errorStyle: TextStyle(fontSize: 10.sp),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                  isDense: true,
                  fillColor: Colors.white,
                  filled: true,
                ),
                style: TextStyle(fontSize: 12.sp),
                onTap: () async {
                  if (_selectedWeekStart == null || _selectedWeekEnd == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                color: Colors.white, size: 20),
                            SizedBox(width: 10),
                            Text('Please select a week first'),
                          ],
                        ),
                        backgroundColor: const Color(0xFFC62828),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
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
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          colorScheme: const ColorScheme.light(
                            primary: Color(0xFF667eea),
                            onPrimary: Colors.white,
                            onSurface: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
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
            SizedBox(width: 8.w),

            // ── Dynamic columns ─────────────────────────
            ..._dailyHeadings.map((heading) {
              final ctrl = point.dynamicControllers.putIfAbsent(
                heading.lessonPlanHeadingsId,
                    () => TextEditingController(),
              );
              final isFirst =
                  heading.lessonPlanHeadingsId == _dailyHeadings.first.lessonPlanHeadingsId;

              return SizedBox(
                width: 200.w,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: heading == _dailyHeadings.last ? 0 : 8.w,
                  ),
                  child: TextField(
                    controller: ctrl,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: '• ${heading.name}...',
                      hintStyle: TextStyle(fontSize: 11.sp, color: Colors.grey.shade400),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: isFirst && point.pointError != null
                              ? Colors.red
                              : Colors.grey.shade300,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: isFirst && point.pointError != null
                              ? Colors.red
                              : Colors.grey.shade300,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: isFirst && point.pointError != null
                              ? Colors.red
                              : const Color(0xFF667eea),
                          width: 2,
                        ),
                      ),
                      errorText: isFirst ? point.pointError : null,
                      errorStyle: TextStyle(fontSize: 10.sp),
                      contentPadding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
                      isDense: true,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    style: TextStyle(fontSize: 12.sp),
                    onTap: () {
                      if (ctrl.text.isEmpty) {
                        ctrl.value = const TextEditingValue(
                          text: '• ',
                          selection: TextSelection.collapsed(offset: 2),
                        );
                      }
                    },
                    onChanged: (value) {
                      if (value.isNotEmpty) _applyBulletFormatting(ctrl);
                      if (isFirst) {
                        point.pointError = null;
                        setState(() {});
                      }
                    },
                  ),
                ),
              );
            }),

            // ── Delete ──────────────────────────────────
            SizedBox(
              width: 60.w,
              child: Center(
                child: IconButton(
                  onPressed: () {
                    if (_teachingPoints.length > 1) {
                      setState(() => _teachingPoints.removeAt(index));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'At least one teaching point is required',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: 20.w,
                    color: Colors.red.shade400,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  splashRadius: 20,
                ),
              ),
            ),
          ],
        ),
      );
    }
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

  // Replace TeachingPointData inside edit_lesson_plan_screen.dart
  class _EditTeachingPoint {
    final TextEditingController dateController = TextEditingController();
    final Map<int, TextEditingController> dynamicControllers = {};
    String? dateError;
    String? pointError;

    // Convenience getter for first heading's controller (backward compat)
    TextEditingController? get pointController =>
        dynamicControllers.isEmpty ? null : dynamicControllers.values.first;

    void dispose() {
      dateController.dispose();
      for (var c in dynamicControllers.values) {
        c.dispose();
      }
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