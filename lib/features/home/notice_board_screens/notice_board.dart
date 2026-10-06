import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../router/routers.dart';
import '../views/teacher_id.dart';
import '../../../common/textSanitizer.dart';

class DashboardNoticeConfig {
  final String key;
  final int value;
  final int show;
  final int priority;

  DashboardNoticeConfig({
    required this.key,
    required this.value,
    required this.show,
    required this.priority,
  });

  factory DashboardNoticeConfig.fromJson(Map<String, dynamic> json) {
    return DashboardNoticeConfig(
      key: json['key'],
      value: json['value'] ?? 0,
      show: json['show'] ?? 0,
      priority: json['priority'] ?? 999,
    );
  }
}

class NoticeItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final int count;
  final VoidCallback? onTap;

  NoticeItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.count,
    this.onTap,
  });
}

class NoticeCard extends StatelessWidget {
  final NoticeItem item;
  const NoticeCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: item.onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.grey.shade50,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            )
          ],
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.shade100,
                    Colors.blue.shade200,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Icon(
                item.icon,
                color: Colors.blue.shade800,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            if (item.count > 0)
              Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade500,
                      Colors.red.shade600,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    )
                  ],
                ),
                child: Text(
                  item.count.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey.shade500,
            ),
          ],
        ),
      ),
    );
  }
}

class TeacherReminderResponse {
  final List<TeacherReminder> reminders;
  final AttendanceReminder? attendance;

  TeacherReminderResponse({
    required this.reminders,
    required this.attendance,
  });
}

class PendingAttendance {
  final String date;
  final String day;

  PendingAttendance({
    required this.date,
    required this.day,
  });

  factory PendingAttendance.fromJson(Map<String, dynamic> json) {
    return PendingAttendance(
      date: json['date']?.toString() ?? '',
      day: json['day']?.toString() ?? '',
    );
  }
}

class AttendanceReminder {
  final bool isClassTeacher;
  final String className;
  final String sectionName;
  final bool isAttendanceMarkedToday;
  final List<PendingAttendance> pendingAttendance;

  AttendanceReminder({
    required this.isClassTeacher,
    required this.className,
    required this.sectionName,
    required this.isAttendanceMarkedToday,
    required this.pendingAttendance,
  });

  factory AttendanceReminder.fromJson(Map<String, dynamic> json) {
    final pending = json['pending_attendance'];

    return AttendanceReminder(
      isClassTeacher: json['is_class_teacher'] == true,
      className: json['class_name']?.toString() ?? '',
      sectionName: json['section_name']?.toString() ?? '',
      isAttendanceMarkedToday:
      json['is_attendance_marked_today'] == true,
      pendingAttendance: pending is List
          ? pending
          .map(
            (e) => PendingAttendance.fromJson(
          Map<String, dynamic>.from(e),
        ),
      )
          .toList()
          : [],
    );
  }
}

class TeacherReminder {
  final int id;
  final String subject;
  final String description;
  final String remarkDate;
  final String publish;
  int readStatus;

  TeacherReminder({
    required this.id,
    required this.subject,
    required this.description,
    required this.remarkDate,
    required this.publish,
    required this.readStatus,
  });

  factory TeacherReminder.fromJson(Map<String, dynamic> json) {
    String rawDescription = json['remark_desc'] ?? '';
    String cleanedDescription = TextSanitizer.cleanText(rawDescription);

    return TeacherReminder(
      id: json["t_remark_id"],
      subject: json["remark_subject"],
      description: json['remark_desc'],
      remarkDate: json["remark_date"],
      publish: json["publish"],
      readStatus: json["read_status"],
    );
  }
}

final dashboardNoticeProvider =
FutureProvider<List<DashboardNoticeConfig>>((ref) async {
  final api = ref.watch(staffApiProvider);
  return api.getTeacherMobileDashboard();
});

final teacherReminderResponseProvider =
FutureProvider<TeacherReminderResponse>((ref) async {
  final api = ref.watch(staffApiProvider);

  return api.getTeacherReminders();
});

final remindersProvider =
FutureProvider<List<TeacherReminder>>((ref) async {
  final response =
  await ref.watch(teacherReminderResponseProvider.future);

  return response.reminders
      .where(
        (r) => r.publish == "Y" && r.readStatus == 0,
  )
      .toList();
});

final attendanceReminderProvider =
FutureProvider<AttendanceReminder?>((ref) async {
  final response =
  await ref.watch(teacherReminderResponseProvider.future);

  return response.attendance;
});

final remindersProviderCount =
FutureProvider<List<TeacherReminder>>((ref) async {

  final response =
  await ref.watch(teacherReminderResponseProvider.future);

  return response.reminders
      .where(
        (r) => r.publish == "Y" && r.readStatus == 0,
  )
      .toList();
});

void _openReminders(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ReminderListSheet(),
  );
}
void _Attendance(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AttendanceListSheet(),
  );
}

Map<String, NoticeItem Function(int)> noticeCardFactory(
    BuildContext context, WidgetRef ref) {
  return {
    "birthDayCard": (count) => NoticeItem(
      icon: Icons.cake_rounded,
      title: "Upcoming Birthdays",
      subtitle: "Today's birthdays",
      count: count,
      onTap: () => const BirthdayRoute().push(context),
    ),

    "homeworkCard": (count) => NoticeItem(
      icon: Icons.assignment_rounded,
      title: "Today's Homework",
      subtitle: "Homework due today",
      count: count,
      onTap: () => const TodayHomeworkRoute().push(context),
    ),

    "lessonPlan": (count) => NoticeItem(
      icon: Icons.menu_book_rounded,
      title: "Weekly Lesson Plans",
      subtitle: "Upcoming Lesson plans",
      count: count,
      onTap: () => const WLPlanRoute().push(context),
    ),

    "pendingBooks": (count) => NoticeItem(
      icon: Icons.local_library_rounded,
      title: "Library – Need to Submit",
      subtitle: "Books pending",
      count: count,
      onTap: () => const LibRoute().push(context),
    ),

    "defaulterCount": (count) => NoticeItem(
      icon: Icons.currency_rupee_sharp,
      title: "Pending Fees",
      subtitle: "Students with pending fees",
      count: count,
      onTap: () => const PendFeeRoute().push(context),
    ),
    "Reminder": (count) => NoticeItem(
      icon: Icons.notifications_active_rounded,
      title: "Notifications",
      subtitle: "Notifications for you",
      count: count,
      onTap: () => _openReminders(context, ref),
    ),
    "MissedAttendance": (count) => NoticeItem(
      icon: Icons.notifications_active_rounded,
      title: "Pending Attendance",
      subtitle: "Pending Attendance Reminder",
      count: count,
      onTap: () => _Attendance(context, ref),
    ),
  };
}


class NoticeBoardScreen extends HookConsumerWidget {
  const NoticeBoardScreen({super.key}); // 👈 Added missing semicolon here

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Re-fetch APIs every time this screen opens
    useEffect(() {
      Future.microtask(() {
        ref.invalidate(dashboardNoticeProvider);
        ref.invalidate(teacherReminderResponseProvider);
      });
      return null;
    }, const []);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFFE91E63),
              const Color(0xFF9C27B0),
              Colors.blue.shade600,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.6, 1.0],
          ),
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 20,
                bottom: 20,
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Notice Board",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Stay updated with important notices",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            // Cards List
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Consumer(
                  builder: (context, ref, _) {
                    final async = ref.watch(dashboardNoticeProvider);

                    return async.when(
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (_, __) => const Center(child: Text("Failed to load dashboard")),
                      data: (configs) {
                        final factory = noticeCardFactory(context, ref);

                        // 1️⃣ Filter visible cards
                        final visible = configs;

                        // 2️⃣ Sort by priority
                        visible.sort((a, b) => a.priority.compareTo(b.priority));

                        // 3️⃣ Build NoticeItems
                        final cards = visible
                            .where((e) => factory.containsKey(e.key))
                            .map((e) => factory[e.key]!(e.value))
                            .toList();

                        if (cards.isEmpty) {
                          return const Center(child: Text("No notices available"));
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            return NoticeCard(item: cards[index]);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReminderListSheet extends ConsumerWidget {
  const ReminderListSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remindersAsync = ref.watch(remindersProvider);

    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.grey.shade800,
                  size: 28,
                ),
              ),

              const SizedBox(width: 8),

              Expanded(
                child: Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(teacherReminderResponseProvider);

                await ref.read(
                  teacherReminderResponseProvider.future,
                );
              },
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  remindersAsync.when(
                    loading: () => const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                    error: (error, stack) =>
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              "Error loading notifications",
                            ),
                          ),
                        ),

                    data: (list) {
                      if (list.isEmpty) {
                        return const SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              "No unread notifications",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        );
                      }

                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                              (context, index) {
                            final reminder = list[index];

                            return _buildPrincipalRemarkCard(
                              context,
                              ref,
                              reminder,
                            );
                          },
                          childCount: list.length,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



  // ============================================================
  // PRINCIPAL REMARK CARD
  // ============================================================

  Widget _buildPrincipalRemarkCard(
      BuildContext context,
      WidgetRef ref,
      TeacherReminder r,
      ) {
    final isUnread = r.readStatus == 0;

    final cleanedDescription =
    TextSanitizer.cleanText(r.description);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isUnread
            ? Colors.grey.shade300
            : Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: isUnread
            ? []
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: isUnread
              ? Colors.grey.shade400
              : Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 1,
        ),

        leading: Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: isUnread
                ? Colors.grey.shade400
                : Colors.blue.shade100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            isUnread
                ? Icons.mark_email_unread_rounded
                : Icons.mark_email_read_rounded,
            color: isUnread
                ? Colors.grey.shade700
                : Colors.blue.shade700,
          ),
        ),

        title: Text(
          r.subject,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
            color: isUnread
                ? Colors.grey.shade800
                : Colors.grey.shade700,
          ),
        ),

        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            cleanedDescription,
            style: TextStyle(
              color: isUnread
                  ? Colors.grey.shade600
                  : Colors.grey.shade500,
            ),
          ),
        ),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            if (isUnread)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "NEW",
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.red.shade700,
                  ),
                ),
              ),

            const SizedBox(height: 4),

            Text(
              r.remarkDate,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade500,
              ),
            ),
          ],
        ),

        onTap: () async {
          if (!isUnread) return;

          try {
            final api = ref.read(staffApiProvider);

            await api.markReminderRead(r.id);

            // Refresh the main API response
            ref.invalidate(
              teacherReminderResponseProvider,
            );

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  "Marked as read",
                ),
                backgroundColor: Colors.green.shade600,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Unable to mark reminder as read",
                ),
              ),
            );
          }
        },
      ),
    );
  }

  // ============================================================
  // DATE FORMAT
  // 2026-07-23 -> 23 Jul 2026
  // ============================================================

  String _formatAttendanceDate(String date) {
    try {
      final parsed = DateTime.parse(date);

      const months = [
        "",
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];

      return "${parsed.day} ${months[parsed.month]} ${parsed.year}";
    } catch (_) {
      return date;
    }
  }

class AttendanceListSheet extends ConsumerWidget {
  const AttendanceListSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync =
    ref.watch(attendanceReminderProvider);

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      child: attendanceAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),

        error: (error, stack) => Center(
          child: Text(
            "Error loading attendance",
          ),
        ),

        data: (attendance) {
          if (attendance == null ||
              !attendance.isClassTeacher ||
              attendance.pendingAttendance.isEmpty) {
            return const Center(
              child: Text(
                "No missed attendance",
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () =>
                        Navigator.of(context).pop(),
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                    ),
                  ),

                  const SizedBox(width: 8),

                  const Expanded(
                    child: Text(
                      "Missed Attendance",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),

                  Text(
                    "${attendance.pendingAttendance.length}",
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Text(
                "Class ${attendance.className}-${attendance.sectionName}",
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 15),

              Expanded(
                child: ListView.separated(
                  itemCount:
                  attendance.pendingAttendance.length,
                  separatorBuilder: (_, __) =>
                  const Divider(),

                  itemBuilder: (context, index) {
                    final item =
                    attendance.pendingAttendance[index];

                    return ListTile(
                      leading: const Icon(
                        Icons.calendar_today,
                        color: Colors.orange,
                      ),
                      title: Text(item.day),
                      subtitle: Text(
                        _formatAttendanceDate(item.date),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          borderRadius:
                          BorderRadius.circular(8),
                        ),
                        child: Text(
                          "MISSED",
                          style: TextStyle(
                            color: Colors.red.shade700,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatAttendanceDate(String date) {
    try {
      final parsed = DateTime.parse(date);

      const months = [
        "",
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];

      return "${parsed.day} "
          "${months[parsed.month]} "
          "${parsed.year}";
    } catch (_) {
      return date;
    }
  }
}

  // ============================================================
  // ATTENDANCE DATE CARD
  // ============================================================

  Widget _buildCompactAttendanceRow(
      PendingAttendance item, {
        bool showDivider = true,
      }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          child: Row(
            children: [

              // Small date icon
              Icon(
                Icons.calendar_today_rounded,
                size: 20,
                color: Colors.orange.shade700,
              ),

              const SizedBox(width: 9),

              // Day
              SizedBox(
                width: 78,
                child: Text(
                  item.day,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800,
                  ),
                ),
              ),

              // Date
              Expanded(
                child: Text(
                  _formatAttendanceDate(item.date),
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              // Missed badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 7,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  "MISSED",
                  style: TextStyle(
                    color: Colors.red.shade700,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),

        if (showDivider)
          Divider(
            height: 1,
            thickness: 0.6,
            indent: 36,
            color: Colors.grey.shade200,
          ),
      ],
    );
  }

  // ============================================================
  // PRINCIPAL REMARK CARD
  // ============================================================

class MissedAttendanceCard extends ConsumerWidget {
  final VoidCallback? onTap;

  const MissedAttendanceCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attendanceAsync = ref.watch(attendanceReminderProvider);

    return attendanceAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (attendance) {
        if (attendance == null ||
            !attendance.isClassTeacher ||
            attendance.pendingAttendance.isEmpty) {
          return const SizedBox.shrink();
        }

        final count = attendance.pendingAttendance.length;

        return NoticeCard(
          item: NoticeItem(
            icon: Icons.notifications_active_rounded,
            title: "Pending Attendance",
            subtitle: "$count attendance entries pending",
            count: count,
            onTap: onTap ?? () => _Attendance(context, ref),
          ),
        );
      },
    );
  }
}

