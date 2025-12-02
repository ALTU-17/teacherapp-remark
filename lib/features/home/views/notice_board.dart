import 'package:flutter/material.dart';

class NoticeItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final int count;

  NoticeItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.count,
  });
}


final List<NoticeItem> noticeItems = [
  NoticeItem(
    icon: Icons.currency_rupee,
    title: "Pending Fees",
    subtitle: "3 students with pending fees",
    count: 3,
  ),
  NoticeItem(
    icon: Icons.book,
    title: "Weekly Lesson Plans",
    subtitle: "2 approved, 1 pending",
    count: 1,
  ),
  NoticeItem(
    icon: Icons.edit_document,
    title: "Today's Homework",
    subtitle: "3 assignments given",
    count: 3,
  ),
  NoticeItem(
    icon: Icons.cake,
    title: "Upcoming Birthday",
    subtitle: "Riya Sharma's birthday tomorrow 🎉",
    count: 1,
  ),
  NoticeItem(
    icon: Icons.library_books,
    title: "Library – Need to Submit",
    subtitle: "2 books pending for return",
    count: 2,
  ),
  // NoticeItem(
  //   icon: Icons.picture_as_pdf,
  //   title: "Question Paper",
  //   subtitle: "Latest question paper uploaded",
  //   count: 1,
  // ),
  // NoticeItem(
  //   icon: Icons.school,
  //   title: "Upcoming Exam",
  //   subtitle: "Maths Unit Test on Monday",
  //   count: 1,
  // ),
];


class NoticeCard extends StatelessWidget {
  final NoticeItem item;
  const NoticeCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            spreadRadius: 1,
          )
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.blue.shade50,
            child: Icon(item.icon, color: Colors.blue),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
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

          // Notification Badge
          if (item.count > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                item.count.toString(),
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),

          const SizedBox(width: 10),

          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

class NoticeBoardScreen extends StatelessWidget {
  const NoticeBoardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

        child: ListView.builder(
          itemCount: noticeItems.length,
          itemBuilder: (context, index) {
            return NoticeCard(item: noticeItems[index]);
          },
        ),
      ),
    );
  }
}
