import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/auth/providers/auth_provider.dart';
import '../../../providers/api_client_provider.dart';

class Period {
  final String period;
  final String subject;
  final String className;
  final String section;

  Period({
    required this.period,
    required this.subject,
    required this.className,
    required this.section,
  });

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        period: json['period_no'].toString(),
        subject: json['subject'] ?? "--",
        className: json['class'] ?? "-",
        section: json['section'] ?? "-",
      );
}

class TimeTableService {
  final Dio apiClient;
  final String baseUrl;
  TimeTableService(this.apiClient, this.baseUrl);

  Future<List<Period>> fetchTimetable({
    required String teacherId,
    required String short_name,
    required String day,
    required String academicYear,
  }) async {
    final response = await apiClient.post(
      '${baseUrl}AdminApi/get_teacher_timetable',
      data: {
        'teacher_id': teacherId,
        'short_name': short_name,
        'day': day,
        'acd_yr': academicYear,
      },
    );
    if (response.statusCode == 200 && response.data['status'] == true) {
      final ttData = response.data['tt_data'];
      if (ttData is! List) return [];
      Map<int, Period> map = {};
      for (var item in ttData) {
        int pNo = int.tryParse(item['period_no'].toString()) ?? 0;
        map[pNo] = Period.fromJson(item);
      }
      // Fill 1-8 with actual or default
      List<Period> periods = [];
      for (int i = 1; i <= 8; i++) {
        if (map.containsKey(i)) {
          periods.add(map[i]!);
        } else {
          periods.add(Period(
              period: i.toString(),
              subject: "--",
              className: "-",
              section: "-"));
        }
      }
      return periods;
    }
    return [];
  }
}

final timeTableServiceProvider = Provider<TimeTableService>((ref) {
  final auth = ref.read(authProvider).requireValue;
  final dio = ref.read(apiClientProvider).requireValue;
  return TimeTableService(
    dio,
    auth.teacherVerification?.teacherapkUrl ?? '',
  );
});

final timeTableProvider =
    FutureProvider.family<List<Period>, String>((ref, day) async {
  final auth = ref.read(authProvider).requireValue;
  final service = ref.read(timeTableServiceProvider);
  final academicYear = auth.academicYr ?? '';
  final teacherId = auth.regId ?? '';
  final shortName = auth.teacherVerification?.shortName ?? '';
  return service.fetchTimetable(
    teacherId: teacherId,
    short_name: shortName,
    day: day,
    academicYear: academicYear,
  );
});

class TimeTableView extends HookConsumerWidget {
  TimeTableView({super.key});

  final List<String> days = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday"
  ];
  final List<String> daysShort = ["MON", "TUE", "WED", "THU", "FRI", "SAT"];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = useState(_initialDayIndex());

    final pageController = usePageController(
      initialPage: selectedIndex.value,
    );

    void onSelectDay(int index) {
      selectedIndex.value = index;
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 40.h,
        title: Text(
          "Time Table ",
          style: TextStyle(fontSize: 20.sp, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pink, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 150.h),
            _buildDaySelector(selectedIndex.value, onSelectDay),
            Expanded(
              child: PageView.builder(
                controller: pageController,
                physics: const BouncingScrollPhysics(),
                itemCount: days.length,
                onPageChanged: (index) {
                  selectedIndex.value = index; // update selector when swiped
                },
                itemBuilder: (context, index) {
                  final asyncPeriods =
                      ref.watch(timeTableProvider(days[index]));
                  return asyncPeriods.when(
                    data: (periods) => _buildTable(periods),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (err, stack) =>
                        Center(child: Text('Failed to load.\n$err')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Return 0 for Monday, 1 for Tuesday, ... Ensures 0-5 range
  int _initialDayIndex() {
    int idx = DateTime.now().weekday - 1;
    return (idx < 0 || idx >= 6) ? 0 : idx;
  }

  Widget _buildDaySelector(int selectedIndex, void Function(int) onSelectDay) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 12.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(daysShort.length, (index) {
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () => onSelectDay(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 11.w),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color.fromARGB(255, 244, 107, 10)
                      : const Color(0xFFE4DADA),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  daysShort[index],
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTable(List<Period> periods) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTableHeader(),
          if (periods.isEmpty)
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text('No Timetable data available.'),
            ),
          ...periods.map(_buildPeriodRow),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 206, 225, 224),
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _tableHeaderCell("Period"),
              _tableHeaderCell("Subject"),
              _tableHeaderCell("Class"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableHeaderCell(String title) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPeriodRow(Period period) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _tableCell(period.period),
              _tableCellSub(period.subject),
              _tableCell('${period.className} ${period.section}'.trim()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tableCell(String text) {
    return Expanded(
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
    );
  }

  Widget _tableCellSub(String text) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}
