import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:teacherapp/router/routers.dart';

import '../../auth/providers/providers.dart';
import '../../auth/widgets/drawer_dialog.dart';
import '../providers/academic_year_provider.dart';

class ScaffoldWithNavigation extends HookConsumerWidget {
  final Widget child;

  const ScaffoldWithNavigation({required this.child, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final acdYear = ref.watch(academicYearProvider).requireValue;
    final academicYr =
        auth.whenOrNull(data: (data) => data.academicYr) ?? 'N/A';

    final navItems = <BottomNavigationBarItem>[
      CustomBottomNavigationBarItem.create(
        icon: Icon(Icons.dashboard),
        name: "Dashboard",
      ),
      CustomBottomNavigationBarItem.create(
        icon: Icon(Icons.calendar_month),
        name: "Calendar",
      ),
      CustomBottomNavigationBarItem.create(
        icon: Icon(Icons.people),
        name: "Profile",
      ),
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,

      ///  extendBody: true,
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
                //  text: "Class Teacher of: ${auth.teacherDetails?.classs?},
                // text: "  ${auth.teacherDetails}', Smart Teacher App $academicYr",
                text:
                    "${auth.value?.teacherVerification?.shortName ?? ""} Smart Teacher App ${acdYear.selectedYear}",
              ),
            ],
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      drawer: DrawerPage(),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:
            const Color.fromARGB(255, 57, 128, 190).withOpacity(0.8),
        elevation: 0.0,
        items: navItems,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int idx) => _onItemTapped(idx, context),
        enableFeedback: true,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 171, 83, 76),
        unselectedItemColor: Colors.white70,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(DashboardRoute().location)) {
      return 0;
    }
    if (location.startsWith(CalendarRoute().location)) {
      return 1;
    }
    if (location.startsWith(TeacherProfileRoute().location)) {
      return 2;
    }

    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go(DashboardRoute().location);
        break;
      case 1:
        GoRouter.of(context).go(CalendarRoute().location);
        break;
      case 2:
        GoRouter.of(context).go(TeacherProfileRoute().location);
    }
  }
}

class CustomBottomNavigationBarItem {
  static BottomNavigationBarItem create({
    required Icon icon,
    required String name,
  }) {
    return BottomNavigationBarItem(
      label: name,
      icon: icon,
    );
  }
}

class CustomNavigationRailDestination {
  static NavigationRailDestination create({
    required String assetPath,
  }) {
    return NavigationRailDestination(
      label: const Text(''),
      icon: Center(
        child: Image.asset(
          assetPath,
          width: 25.r,
          height: (25.r),
        ),
      ),
    );
  }
}
