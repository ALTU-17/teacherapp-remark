import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:teacherapp/features/auth/providers/auth_provider.dart';
import 'package:teacherapp/features/home/providers/academic_year_provider.dart';

class CalendarView extends ConsumerStatefulWidget {
  const CalendarView({super.key});

  @override
  ConsumerState<CalendarView> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarView> {
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<Event>> _events = {};
  List<Event> _selectedEvents = [];
  DateTime? _academicYearStart;
  DateTime? _academicYearEnd;
  List<Event> _monthlyEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents(_focusedDay);
  }

  @override
  Widget build(BuildContext context) {
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
                Color.fromARGB(255, 80, 148, 203)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                          _selectedEvents =
                              _events[_normalizeDate(selectedDay)] ?? [];
                        });
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {
                          _focusedDay = focusedDay;
                        });
                        _fetchEvents(focusedDay);
                      },
                      eventLoader: (day) {
                        return _events[_normalizeDate(day)] ?? [];
                      },
                      headerStyle: const HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._selectedEvents.map((event) => Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Color(
                            int.parse(event.color.replaceAll("#", "0xFF"))),
                        child: ListTile(
                          leading:
                              const Icon(Icons.info, color: Colors.black54),
                          title: Text(
                            '${DateFormat('dd-MM-yyyy').format(event.date)}  ${event.title}',
                            style: const TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  Future<void> _fetchAcademicYearRange() async {
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final url1 = Uri.parse(
        'https://sms.arnoldcentralschool.org/SACSv4test/index.php/AdminApi/get_academic_yr_from_to_dates');
    final response = await http.post(url1, body: {
      'short_name': 'SACS', //TODO CHANGE THIS
      'academic_yr': acdYear,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0];
      setState(() {
        _academicYearStart = DateTime.parse(data['academic_yr_from']);
        _academicYearEnd = DateTime.parse(data['academic_yr_to']);
      });
    }
  }

  Future<void> _fetchEvents(DateTime focusedDay) async {
    final acdYear = ref.read(academicYearProvider).requireValue.selectedYear;
    final auth = ref.read(authProvider).requireValue;
    final url2 = Uri.parse(
        'https://sms.arnoldcentralschool.org/SACSv4test/index.php/AdminApi/get_all_published_events');
    final response = await http.post(url2, body: {
      'short_name': 'SACS',
      'academic_yr': acdYear,
      'month': focusedDay.month.toString(),
      'year': focusedDay.year.toString(),
      'reg_id': auth.regId, //TODO CHANGE THIS
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(json.decode(response.body));
      setState(() {
        _events.clear();
        _monthlyEvents = [];
        _addEvents(data['Events'], '#6da8d6');
        _addEvents(data['Homework'], '#90ee90');
        _addEvents(data['Holidays'], '#e57368');
        _selectedEvents = _monthlyEvents;
      });
    }
  }

  void _addEvents(List<dynamic> events, String color) {
    for (final event in events) {
      final date = DateFormat('dd-MM-yyyy').parse(event['start_date']);
      final eventData = Event(
        title: event['title'],
        description: event['event_desc'],
        color: color,
        date: date,
      );

      final normalizedDate = _normalizeDate(date);
      _events.putIfAbsent(normalizedDate, () => []).add(eventData);
      _monthlyEvents.add(eventData);
    }
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                exit(0);
              },
              child: const Text('Exit'),
            ),
          ],
        );
      },
    );
  }
}

class Event {
  final String title;
  final String description;
  final String color;
  final DateTime date;

  Event({
    required this.title,
    required this.description,
    required this.color,
    required this.date,
  });
}
