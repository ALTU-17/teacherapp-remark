import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/router/routers.dart';
import '../../auth/providers/providers.dart';
import '../../auth/widgets/drawer_dialog.dart';
import '../providers/academic_year_provider.dart';
import 'notice_board.dart';

class ScaffoldWithCustomNavBar extends HookConsumerWidget {
  final Widget child;
  const ScaffoldWithCustomNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final acdYear = ref.watch(academicYearProvider).requireValue;
    final academicYr = auth.whenOrNull(data: (data) => data.academicYr) ?? 'N/A';

    final String location = GoRouterState.of(context).matchedLocation;
    final int currentIndex = _calculateSelectedIndex(location);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text.rich(
          TextSpan(
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: "${auth.value?.teacherVerification?.shortName ?? ""} Smart Teacher App ${acdYear.selectedYear}",
              ),
            ],
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      drawer: DrawerPage(), // Your existing drawer
      body: child,
      backgroundColor: const Color.fromARGB(255, 57, 128, 190),
      bottomNavigationBar: _buildMyNavBar(currentIndex, context),
    );
  }

  Widget _buildMyNavBar(int currentIndex, BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 10, 12, 8),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, -3))],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
                icon: Icons.dashboard,
                label: 'Dashboard',
                index: 0,
                currentIndex: currentIndex,
                context: context
            ),
            _buildNavItem(
                icon: Icons.calendar_month,
                label: 'Events',
                index: 1,
                currentIndex: currentIndex,
                context: context
            ),

            _buildNavItem(
                icon: Icons.person,
                label: 'Profile',
                index: 2,
                currentIndex: currentIndex,
                context: context
            ),

            _buildNavItem(
                icon: Icons.developer_board_outlined,
                label: 'Notice Board',
                index: 3,
                currentIndex: currentIndex,
                context: context
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    required int currentIndex,
    required BuildContext context
  }) {
    bool isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () {

          _navigateToPage(index, context);

      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
              icon,
              color: isSelected ?
              Colors.blue.shade400 : // Selected color from old nav
              Colors.grey,
              size: 26
          ),
          SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ?
              Colors.blue.shade400 : // Selected color from old nav
              Colors.grey,
              fontSize: 10.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCenterNavItem({
    required IconData icon,
    required int index,
    required BuildContext context
  }) {
    return GestureDetector(
      onTap: () {
        // Handle center icon tap if needed
        print('Center icon tapped');
        // You can add navigation for center icon here if needed
        // context.go('/some_route');
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 171, 83, 76), // Using your selected color
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }

  void _navigateToPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(DashboardRoute().location);
        break;
      case 1:
        context.go(CalendarRoute().location);
        break;
      case 2:
        context.go(TeacherProfileRoute().location);
        break;
        case 3:
        context.go(NoticeBoardScreenRoute().location);
        break;
    // Add more cases as needed for other pages
    }
  }

  // Keep your existing method to calculate selected index
  static int _calculateSelectedIndex(String location) {
    if (location.startsWith(DashboardRoute().location)) {
      return 0;
    }
    if (location.startsWith(CalendarRoute().location)) {
      return 1;
    }
    if (location.startsWith(TeacherProfileRoute().location)) {
      return 2;
    }
    if (location.startsWith(NoticeBoardScreenRoute().location)) {
      return 3;
    }
    // Add QR code route if needed
    if (location.startsWith('/qr_code')) {
      return 4;
    }

    return 0;
  }
}