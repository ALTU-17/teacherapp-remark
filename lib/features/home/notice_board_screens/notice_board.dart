import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../router/routers.dart';
import '../views/teacher_id.dart';

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
    return TeacherReminder(
      id: json["t_remark_id"],
      subject: json["remark_subject"],
      description: json["remark_desc"],
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

final remindersProvider = FutureProvider<List<TeacherReminder>>((ref) async {
  final api = ref.watch(staffApiProvider);
  final list = await api.getTeacherReminders();
  return list.where((r) => r.publish == "Y").toList();
});

final remindersProviderCount = FutureProvider<List<TeacherReminder>>((ref) async {
  final api = ref.watch(staffApiProvider);
  final count = await api.getTeacherReminders();
  return count.where((r) => r.publish == "Y" && r.readStatus == 0).toList();
});

void _openReminders(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ReminderListSheet(),
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
      subtitle: "Lesson plans not created",
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
      title: "Reminders",
      subtitle: "Reminders for you",
      count: count,
      onTap: () => _openReminders(context, ref),
    ),
  };
}


class NoticeBoardScreen extends ConsumerWidget {
  const NoticeBoardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final noticeItems = [
      NoticeItem(
        icon: Icons.cake_rounded,
        title: "Upcoming Birthdays",
        subtitle: "View today, tomorrow & yesterday birthdays",
        count: 3,
        onTap: () => const BirthdayRoute().push(context),
      ),
      NoticeItem(
        icon: Icons.assignment_rounded,
        title: "Today's Homework",
        subtitle: "3 assignments given",
        count: 3,
        onTap: () => const TodayHomeworkRoute().push(context),
      ),
      NoticeItem(
        icon: Icons.payments_rounded,
        title: "Pending Fees",
        subtitle: "3 students with pending fees",
        count: 3,
        onTap: () => const PendFeeRoute().push(context),
      ),
      NoticeItem(
        icon: Icons.menu_book_rounded,
        title: "Weekly Lesson Plans",
        subtitle: "2 approved, 1 pending",
        count: 1,
        onTap: () => const WLPlanRoute().push(context),
      ),
      NoticeItem(
        icon: Icons.local_library_rounded,
        title: "Library – Need to Submit",
        subtitle: "2 books pending for return",
        count: 2,
        onTap: () => const LibRoute().push(context),
      ),
      NoticeItem(
        icon: Icons.notifications_active_rounded,
        title: "Reminders",
        subtitle: "Reminders for you",
        count: ref.watch(remindersProviderCount).maybeWhen(
          data: (count) => count.length,
          orElse: () => 0,
        ),
        onTap: () => _openReminders(context, ref),
      ),
    ];

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFE91E63),
              Color(0xFF9C27B0),
              Colors.blue.shade600,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.6, 1.0],
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
                      Text(
                        "Notice Board",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 6),
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
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
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
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.only(
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
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(remindersProvider);

    return Container(
      padding: EdgeInsets.only(
        top: 24,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Drag indicator
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
          SizedBox(height: 16),
          // Header
          Row(
            children: [
              // Back Arrow Button
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.grey.shade800,
                  size: 28,
                ),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reminders",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.shade100,
                            Colors.blue.shade200,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Tap to mark as read",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 8),
          Text(
            "Unread reminders will appear in gray",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
          SizedBox(height: 30),
          Expanded(
            child: async.when(
              loading: () => Center(
                child: CircularProgressIndicator(
                  color: Colors.blue.shade700,
                ),
              ),
              error: (e, _) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: Colors.red.shade400,
                      size: 48,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Error loading reminders",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              data: (list) {
                if (list.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.check_circle_outline_rounded,
                          color: Colors.green.shade400,
                          size: 64,
                        ),
                        SizedBox(height: 16),
                        Text(
                          "All caught up!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "No new reminders",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, index) {
                    final r = list[index];
                    final isUnread = r.readStatus == 0;

                    return Container(
                      margin: EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: isUnread
                            ? Colors.grey.shade300 // Gray for unread
                            : Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: isUnread
                            ? []
                            : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: Offset(0, 4),
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
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
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
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            r.description,
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
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
                            SizedBox(height: 4),
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
                          if (isUnread) {
                            final api = ref.read(staffApiProvider);
                            await api.markReminderRead(r.id);
                            ref.refresh(remindersProvider);
                            ref.refresh(remindersProviderCount);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Marked as read"),
                                backgroundColor: Colors.green.shade600,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}