import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:teacherapp/features/auth/views/aboutUs_view.dart';
import 'package:teacherapp/features/curriculum/curriculum_dashboard.dart';
import 'package:teacherapp/features/home/views/calendar_view.dart';
import 'package:teacherapp/features/home/views/navbar.dart';
import 'package:teacherapp/features/home/views/scaffold_with_navigation.dart';
import 'package:teacherapp/splash_screen.dart';
import 'package:teacherapp/features/daily_attaindance/views/daily_attend_dash_board_view.dart';
import 'package:teacherapp/views/home/remark/remarkDashBoard.dart';
import 'package:teacherapp/views/home/timeTable/timeTableTecaher.dart';
import '../features/SmartChatWebView.dart';
import '../features/auth/views/views.dart';
import '../features/home/views/views.dart';
import '../features/homework/models/models.dart';
import '../features/homework/views/views.dart';
import '../features/leave_application/models/models.dart';
import '../features/leave_application/views/views.dart';
import '../features/teacher_note/models/models.dart';
import '../features/teacher_note/views/views.dart';

part 'routers.g.dart';

final GlobalKey<NavigatorState> shellNavKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> authShellNavKey = GlobalKey<NavigatorState>();

@TypedGoRoute<SplashRoute>(path: '/')
class SplashRoute extends GoRouteData with _$SplashRoute {
  const SplashRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashView();
  }
}

// ///////////////////// HOME ////////////////////////////////
// Remove or comment out the old HomeShellRoute and replace with:

@TypedShellRoute<HomeShellRoute>(routes: [
  TypedGoRoute<DashboardRoute>(path: DashboardRoute.path, name: "Dashboard", routes: [
    TypedGoRoute<LeaveApplicationDashboardRoute>(
        path: LeaveApplicationDashboardRoute.path,
        routes: [
          TypedGoRoute<LeaveApplicationRoute>(path: LeaveApplicationRoute.path),
        ]),
    TypedGoRoute<TeacherNoteRoute>(path: TeacherNoteRoute.path, routes: [
      TypedGoRoute<EditAddTeacherNoteRoute>(path: EditAddTeacherNoteRoute.path),
      TypedGoRoute<TeacherNoteViewRoute>(path: TeacherNoteViewRoute.path),
      TypedGoRoute<TeacherNoteViewedByRoute>(
          path: TeacherNoteViewedByRoute.path),
    ]),
    TypedGoRoute<HomeWorkRoute>(path: HomeWorkRoute.path, routes: [
      TypedGoRoute<EditAddHomeWorkRoute>(path: EditAddHomeWorkRoute.path),
      TypedGoRoute<HomeWorkViewRoute>(path: HomeWorkViewRoute.path),
      TypedGoRoute<HomeWorkParentViewRoute>(path: HomeWorkParentViewRoute.path)
    ]),
    TypedGoRoute<RemarkRoute>(path: RemarkRoute.path),
    TypedGoRoute<TimeTableRoute>(path: TimeTableRoute.path),
    TypedGoRoute<DailyAttendanceRoute>(path: DailyAttendanceRoute.path),
    TypedGoRoute<CurriRoute>(path: CurriRoute.path),
    TypedGoRoute<SmartChatRoute>(path: SmartChatRoute.path)
  ]),
  TypedGoRoute<CalendarRoute>(path: CalendarRoute.path, name: "Calendar"),
  TypedGoRoute<ChangePasswordRoute>(
      path: ChangePasswordRoute.path, name: "Change Password"),
  TypedGoRoute<AboutUsScreenRoute>(
      path: AboutUsScreenRoute.path, name: "About Us"),
  TypedGoRoute<ChangeAcademicRoute>(
      path: ChangeAcademicRoute.path, name: "Change Academic Year"),
  TypedGoRoute<TeacherProfileRoute>(
      path: TeacherProfileRoute.path, name: "Profile"),
  // Add QR Code route
  // TypedGoRoute<QRCodeRoute>(path: QRCodeRoute.path, name: "QR Code"),
])
class HomeShellRoute extends ShellRouteData {
  const HomeShellRoute();
  static final GlobalKey<NavigatorState> $navigatorKey = shellNavKey;

  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ScaffoldWithCustomNavBar(child: navigator);
  }
}

// // Add QR Code route
// class QRCodeRoute extends GoRouteData with _$QRCodeRoute {
//   const QRCodeRoute();
//   static const path = '/qr_code';
//
//   @override
//   Widget build(BuildContext context, GoRouterState state) {
//     // You'll need to get regId from your provider or pass it differently
//     return QRCodeScreen(regId: 'your_reg_id_here');
//   }
// }

class DashboardRoute extends GoRouteData with _$DashboardRoute {
  const DashboardRoute();
  static const path = '/dashbaord';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return DashboardView();
  }
}

class LeaveApplicationDashboardRoute extends GoRouteData
    with _$LeaveApplicationDashboardRoute {
  const LeaveApplicationDashboardRoute();
  static const path = 'leave_application_dashboard';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const LeaveApplicationDashBoardView();
  }
}

class LeaveApplicationRoute extends GoRouteData with _$LeaveApplicationRoute {
  const LeaveApplicationRoute();
  static const path = 'leave_application';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final l = state.extra as Leave?;
    return LeaveApplicationView(leave: l);
  }
}

class TeacherNoteRoute extends GoRouteData with _$TeacherNoteRoute {
  const TeacherNoteRoute();
  static const path = 'teacher_note_dashboard';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TeacherNoteDashBoardView();
  }
}

class EditAddTeacherNoteRoute extends GoRouteData
    with _$EditAddTeacherNoteRoute {
  const EditAddTeacherNoteRoute();
  static const path = 'edit_add_teacher_note';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final n = state.extra as Note?;
    return EditAddTeacherNoteView(note: n);
  }
}

class TeacherNoteViewRoute extends GoRouteData with _$TeacherNoteViewRoute {
  const TeacherNoteViewRoute();
  static const path = 'teacher_note_view';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final n = state.extra as Note?;
    return ViewTeacherNoteView(note: n!);
  }
}

class CurriRoute extends GoRouteData with _$CurriRoute {
  const CurriRoute();
  static const path = 'curriculum';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CurriculumPage();
  }
}

class SmartChatRoute extends GoRouteData with _$SmartChatRoute {
  const SmartChatRoute();
  static const path = 'smart_chat';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SmartChatPage();
  }
}

class TeacherNoteViewedByRoute extends GoRouteData
    with _$TeacherNoteViewedByRoute {
  const TeacherNoteViewedByRoute();
  static const path = 'teacher_note_viewed_by_teacher';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final n = state.extra as Note?;
    return ViewedByTeacherNoteView(n!);
  }
}

class HomeWorkRoute extends GoRouteData with _$HomeWorkRoute {
  const HomeWorkRoute();
  static const path = 'homework';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomeworkDashboardView();
  }
}

class HomeWorkViewRoute extends GoRouteData with _$HomeWorkViewRoute {
  const HomeWorkViewRoute();
  static const path = 'homework_view';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final h = state.extra as Homework?;
    return HomeWorkView(h);
  }
}

class HomeWorkParentViewRoute extends GoRouteData
    with _$HomeWorkParentViewRoute {
  const HomeWorkParentViewRoute();
  static const path = 'homework_parent_view';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final h = state.extra as Homework?;
    return HomeworkViewByParentView(h);
  }
}

class EditAddHomeWorkRoute extends GoRouteData with _$EditAddHomeWorkRoute {
  const EditAddHomeWorkRoute();
  static const path = 'edit_add_homework';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    final h = state.extra as Homework?;
    return EditAddHomeWorkView(h);
  }
}

class RemarkRoute extends GoRouteData with _$RemarkRoute {
  const RemarkRoute();
  static const path = 'remark';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const RemarkDashBoardView();
  }
}

class TimeTableRoute extends GoRouteData with _$TimeTableRoute {
  const TimeTableRoute();
  static const path = 'time_table';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TimeTableView();
  }
}

class DailyAttendanceRoute extends GoRouteData with _$DailyAttendanceRoute {
  const DailyAttendanceRoute();
  static const path = 'daily_attendance';
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const DailyAttendDashboardView();
  }
}

class CalendarRoute extends GoRouteData with _$CalendarRoute {
  const CalendarRoute();
  static const path = '/calender';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const CalendarView();
}

class ChangePasswordRoute extends GoRouteData with _$ChangePasswordRoute {
  const ChangePasswordRoute();
  static const path = '/change_password';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChangePasswordView();
}

class AboutUsScreenRoute extends GoRouteData with _$AboutUsScreenRoute {
  const AboutUsScreenRoute();
  static const path = '/aboutUs';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const AboutUsScreen();
}

//change academic year
class ChangeAcademicRoute extends GoRouteData with _$ChangeAcademicRoute {
  const ChangeAcademicRoute();
  static const path = '/changeAcademic';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ChangeAcademicView();
}

class TeacherProfileRoute extends GoRouteData with _$TeacherProfileRoute {
  const TeacherProfileRoute();
  static const path = '/teacher_profile';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TeacherProfileView();
}

////////////////////////////////////// AUTH ////////////////////////////////////

@TypedShellRoute<AuthShellRoute>(routes: [
  TypedGoRoute<TeacherVerificationRoute>(
      path: TeacherVerificationRoute.path, name: "Teacher Verification"),
  TypedGoRoute<LoginRoute>(path: LoginRoute.path, name: "Login"),
  TypedGoRoute<ForgotPasswordRoute>(
      path: ForgotPasswordRoute.path, name: "Forgot Password"),
])
class AuthShellRoute extends ShellRouteData {
  const AuthShellRoute();
  static final GlobalKey<NavigatorState> $navigatorKey = authShellNavKey;
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return ScaffoldWithNavigationAuth(child: navigator);
  }
}

class TeacherVerificationRoute extends GoRouteData
    with _$TeacherVerificationRoute {
  const TeacherVerificationRoute();
  static const path = '/teacher_verification';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const TeacherVerificationView();
}

class LoginRoute extends GoRouteData with _$LoginRoute {
  const LoginRoute();
  static const path = '/login';

  @override
  Widget build(BuildContext context, GoRouterState state) => const LoginView();
}

class ForgotPasswordRoute extends GoRouteData with _$ForgotPasswordRoute {
  const ForgotPasswordRoute();
  static const path = '/forgot_password';

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ForgotPasswordView();
}
