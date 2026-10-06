import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:teacherapp/features/auth/providers/auth_provider.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';
import 'package:teacherapp/providers/api_client_provider.dart';

// ─────────────────────────────────────────────────────────────────
// MODELS
// ─────────────────────────────────────────────────────────────────

class CalendarEvent {
  final String title;
  final String description;
  final String color;
  final DateTime date;

  CalendarEvent({
    required this.title,
    required this.description,
    required this.color,
    required this.date,
  });
}

class CalendarMonthData {
  final List<CalendarEvent> events; // all events for the month
  final Map<DateTime, List<CalendarEvent>> byDay; // normalized date => events

  CalendarMonthData({
    required this.events,
    required this.byDay,
  });

  static CalendarMonthData empty() =>
      CalendarMonthData(events: const [], byDay: const {});
}

// ─────────────────────────────────────────────────────────────────
// SERVICE
// ─────────────────────────────────────────────────────────────────

class CalendarService {
  final Dio apiClient;
  final String baseUrl;

  CalendarService(this.apiClient, this.baseUrl);

  /// ✅ focusedDay is the parameter — exactly like _fetchEvents(focusedDay)
  Future<CalendarMonthData> fetchEvents({
    required String shortName,
    required String academicYear,
    required DateTime focusedDay,
    required String regId,
  }) async {
    try {
      final response = await apiClient.post(
        '${baseUrl}AdminApi/get_all_published_events',
        data: FormData.fromMap({
          'short_name': shortName,
          'academic_yr': academicYear,
          'month': focusedDay.month.toString(),
          'year': focusedDay.year.toString(),
          'reg_id': regId,
        }),
      );

      if (response.statusCode != 200) return CalendarMonthData.empty();

      // ⚠️ Original code did jsonDecode(json.decode(response.body))
      //    because http returns String. Dio already decodes → handle both.
      final decoded = _decode(response.data);
      if (decoded is! Map) return CalendarMonthData.empty();

      final byDay = <DateTime, List<CalendarEvent>>{};
      final all = <CalendarEvent>[];

      _addEvents(decoded['Events'] ?? [], '#6da8d6', byDay, all);
      _addEvents(decoded['Homework'] ?? [], '#90ee90', byDay, all);
      _addEvents(decoded['Holidays'] ?? [], '#e57368', byDay, all);

      return CalendarMonthData(events: all, byDay: byDay);
    } catch (e) {
      debugPrint('CalendarService.fetchEvents error: $e');
      return CalendarMonthData.empty();
    }
  }
  /// Fetches upcoming events across the current and next N months.
  /// Returns a flat list sorted by date (ascending), only future events.
  Future<List<CalendarEvent>> fetchUpcomingEvents({
    required String shortName,
    required String academicYear,
    required String regId,
    int monthsAhead = 3, // how many months ahead to look
  }) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final futures = <Future<CalendarMonthData>>[];
    for (int i = 0; i < monthsAhead; i++) {
      final monthDate = DateTime(now.year, now.month + i, 1);
      futures.add(fetchEvents(
        shortName: shortName,
        academicYear: academicYear,
        focusedDay: monthDate,
        regId: regId,
      ));
    }

    final results = await Future.wait(futures);
    print('results events body: ${results}');

    // Flatten all events, filter future-only, sort by date
    final all = <CalendarEvent>[];
    for (final r in results) {
      all.addAll(r.events);
    }

    final upcoming = all
        .where((e) => !e.date.isBefore(today)) // today or later
        .toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return upcoming;
  }
  dynamic _decode(dynamic data) {
    debugPrint('_decode input type: ${data.runtimeType}');
    dynamic result = data;
    int safety = 0;
    while (result is String && safety < 5) {
      debugPrint('_decode pass ${safety + 1}: still String');
      try {
        result = jsonDecode(result);
      } catch (e) {
        debugPrint('_decode break: $e');
        break;
      }
      safety++;
    }
    debugPrint('_decode output type: ${result.runtimeType}');
    return result;
  }

  void _addEvents(
      List<dynamic> events,
      String color,
      Map<DateTime, List<CalendarEvent>> byDay,
      List<CalendarEvent> all,
      ) {
    for (final e in events) {
      try {
        final date =
        DateFormat('dd-MM-yyyy').parse(e['start_date'].toString());
        final event = CalendarEvent(
          title: e['title']?.toString() ?? '',
          description: e['event_desc']?.toString() ?? '',
          color: color,
          date: date,
        );
        final key = DateTime(date.year, date.month, date.day);
        byDay.putIfAbsent(key, () => []).add(event);
        all.add(event);
      } catch (err) {
        debugPrint('Skipping invalid event: $e -> $err');
      }
    }
  }
}

// ─────────────────────────────────────────────────────────────────
// PROVIDERS
// ─────────────────────────────────────────────────────────────────

final calendarServiceProvider = Provider<CalendarService>((ref) {
  final auth = ref.read(authProvider).requireValue;
  final dio = ref.read(apiClientProvider).requireValue;
  return CalendarService(
    dio,
    auth.teacherVerification?.teacherapkUrl ?? '',
  );
});

/// ✅ Family keyed by DateTime (focusedDay).
/// Provider auto-refetches whenever focusedDay.month/year changes.
final calendarEventsProvider =
FutureProvider.family<CalendarMonthData, DateTime>((ref, focusedDay) async {
  final auth = ref.read(authProvider).requireValue;
  final service = ref.read(calendarServiceProvider);
  final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;

  return service.fetchEvents(
    shortName: auth.teacherVerification?.shortName ?? '',
    academicYear: acdYear.isNotEmpty ? acdYear : (auth.academicYr ?? ''),
    focusedDay: focusedDay, // 👈 DateTime passed here
    regId: auth.regId ?? '',
  );
});

// ─────────────────────────────────────────────────────────────────
// UI
// ─────────────────────────────────────────────────────────────────

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({super.key});

  @override
  ConsumerState<CalendarView> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarView> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    // 👇 Watch events for the currently focused month.
    //    Whenever user swipes to a new month, _focusedDay changes,
    //    the family key changes, and the provider auto-refetches.
    final asyncMonth = ref.watch(calendarEventsProvider(_focusedDay));

    return WillPopScope(
      onWillPop: () async {
        _showExitConfirmation(context);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 13, 76),
                Color.fromARGB(255, 80, 148, 203),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: asyncMonth.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
              error: (err, _) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Failed to load events.\n$err',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              data: (data) {
                final eventsByDay = data.byDay;
                final selectedEvents = _selectedDay == null
                    ? data.events
                    : (eventsByDay[_normalizeDate(_selectedDay!)] ?? []);

                return SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        margin: EdgeInsets.zero,
                        color: Colors.white,
                        child: TableCalendar(
                          firstDay: DateTime.utc(2020, 1, 1),
                          lastDay: DateTime.utc(2030, 12, 31),
                          focusedDay: _focusedDay,
                          calendarFormat: _calendarFormat,
                          selectedDayPredicate: (day) =>
                              isSameDay(_selectedDay, day),
                          onDaySelected: (selectedDay, focusedDay) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          },
                          onPageChanged: (focusedDay) {
                            setState(() {
                              _focusedDay = focusedDay;
                              _selectedDay = null;
                            });
                            // ✅ Provider auto-refetches because key changed.
                          },
                          eventLoader: (day) =>
                          eventsByDay[_normalizeDate(day)] ?? [],
                          headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                            titleCentered: true,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      if (selectedEvents.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(24),
                          child: Center(
                            child: Text(
                              'No events for this day.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      else
                        ...selectedEvents.map(
                              (event) => Card(
                            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            color: Color(int.parse(event.color.replaceAll("#", "0xFF"))),
                            child: InkWell(  // 👈 make card tappable
                              borderRadius: BorderRadius.circular(10),
                              onTap: () => _showEventDetails(event),
                              child: ListTile(
                                leading: const Icon(Icons.info, color: Colors.black54),
                                title: Text(
                                  '${DateFormat('dd-MM-yyyy').format(event.date)}  ${event.title}',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: const Icon(Icons.chevron_right, color: Colors.black54),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
  void _showEventDetails(CalendarEvent event) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final plainDesc = _stripHtml(event.description);
        return Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drag handle
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Date
              Row(
                children: [
                  const Icon(Icons.calendar_today,
                      size: 16, color: Colors.black54),
                  const SizedBox(width: 8),
                  Text(
                    DateFormat('dd-MM-yyyy').format(event.date),
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Title
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 12),

              // Description
              if (plainDesc.isNotEmpty) ...[
                const Text(
                  'Description',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  plainDesc,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                ),
              ] else
                const Text(
                  'No description available.',
                  style: TextStyle(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),

              const SizedBox(height: 20),

              // Close button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    Color(int.parse(event.color.replaceAll("#", "0xFF"))),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text(
                    'Close',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _stripHtml(String input) {
    if (input.isEmpty) return '';
    return input
    // line-break tags ko newline me convert karo
        .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
        .replaceAll(RegExp(r'</p>', caseSensitive: false), '\n')
    // baaki sab tags hatao
        .replaceAll(RegExp(r'<[^>]*>'), '')
    // HTML entities decode karo
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&lt;', '<')
        .replaceAll('&gt;', '>')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'")
        .trim();
  }

  DateTime _normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Are you sure you want to exit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              exit(0);
            },
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }
}