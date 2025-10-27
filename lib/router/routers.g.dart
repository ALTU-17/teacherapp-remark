// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routers.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $splashRoute,
      $homeShellRoute,
      $authShellRoute,
    ];

RouteBase get $splashRoute => GoRouteData.$route(
      path: '/',
      factory: _$SplashRoute._fromState,
    );

mixin _$SplashRoute on GoRouteData {
  static SplashRoute _fromState(GoRouterState state) => const SplashRoute();

  @override
  String get location => GoRouteData.$location(
        '/',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeShellRoute => ShellRouteData.$route(
      navigatorKey: HomeShellRoute.$navigatorKey,
      factory: $HomeShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/dashbaord',
          name: 'Dashboard',
          factory: _$DashboardRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'leave_application_dashboard',
              factory: _$LeaveApplicationDashboardRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'leave_application',
                  factory: _$LeaveApplicationRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'teacher_note_dashboard',
              factory: _$TeacherNoteRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'edit_add_teacher_note',
                  factory: _$EditAddTeacherNoteRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'teacher_note_view',
                  factory: _$TeacherNoteViewRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'teacher_note_viewed_by_teacher',
                  factory: _$TeacherNoteViewedByRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'homework',
              factory: _$HomeWorkRoute._fromState,
              routes: [
                GoRouteData.$route(
                  path: 'edit_add_homework',
                  factory: _$EditAddHomeWorkRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'homework_view',
                  factory: _$HomeWorkViewRoute._fromState,
                ),
                GoRouteData.$route(
                  path: 'homework_parent_view',
                  factory: _$HomeWorkParentViewRoute._fromState,
                ),
              ],
            ),
            GoRouteData.$route(
              path: 'remark',
              factory: _$RemarkRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'time_table',
              factory: _$TimeTableRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'daily_attendance',
              factory: _$DailyAttendanceRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'curriculum',
              factory: _$CurriRoute._fromState,
            ),
            GoRouteData.$route(
              path: 'smart_chat',
              factory: _$SmartChatRoute._fromState,
            ),
          ],
        ),
        GoRouteData.$route(
          path: '/calender',
          name: 'Calendar',
          factory: _$CalendarRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/change_password',
          name: 'Change Password',
          factory: _$ChangePasswordRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/aboutUs',
          name: 'About Us',
          factory: _$AboutUsScreenRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/changeAcademic',
          name: 'Change Academic Year',
          factory: _$ChangeAcademicRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/teacher_profile',
          name: 'Profile',
          factory: _$TeacherProfileRoute._fromState,
        ),
      ],
    );

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) =>
      const HomeShellRoute();
}

mixin _$DashboardRoute on GoRouteData {
  static DashboardRoute _fromState(GoRouterState state) =>
      const DashboardRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$LeaveApplicationDashboardRoute on GoRouteData {
  static LeaveApplicationDashboardRoute _fromState(GoRouterState state) =>
      const LeaveApplicationDashboardRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/leave_application_dashboard',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$LeaveApplicationRoute on GoRouteData {
  static LeaveApplicationRoute _fromState(GoRouterState state) =>
      const LeaveApplicationRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/leave_application_dashboard/leave_application',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TeacherNoteRoute on GoRouteData {
  static TeacherNoteRoute _fromState(GoRouterState state) =>
      const TeacherNoteRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/teacher_note_dashboard',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$EditAddTeacherNoteRoute on GoRouteData {
  static EditAddTeacherNoteRoute _fromState(GoRouterState state) =>
      const EditAddTeacherNoteRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/teacher_note_dashboard/edit_add_teacher_note',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TeacherNoteViewRoute on GoRouteData {
  static TeacherNoteViewRoute _fromState(GoRouterState state) =>
      const TeacherNoteViewRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/teacher_note_dashboard/teacher_note_view',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TeacherNoteViewedByRoute on GoRouteData {
  static TeacherNoteViewedByRoute _fromState(GoRouterState state) =>
      const TeacherNoteViewedByRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/teacher_note_dashboard/teacher_note_viewed_by_teacher',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$HomeWorkRoute on GoRouteData {
  static HomeWorkRoute _fromState(GoRouterState state) => const HomeWorkRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/homework',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$EditAddHomeWorkRoute on GoRouteData {
  static EditAddHomeWorkRoute _fromState(GoRouterState state) =>
      const EditAddHomeWorkRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/homework/edit_add_homework',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$HomeWorkViewRoute on GoRouteData {
  static HomeWorkViewRoute _fromState(GoRouterState state) =>
      const HomeWorkViewRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/homework/homework_view',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$HomeWorkParentViewRoute on GoRouteData {
  static HomeWorkParentViewRoute _fromState(GoRouterState state) =>
      const HomeWorkParentViewRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/homework/homework_parent_view',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$RemarkRoute on GoRouteData {
  static RemarkRoute _fromState(GoRouterState state) => const RemarkRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/remark',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TimeTableRoute on GoRouteData {
  static TimeTableRoute _fromState(GoRouterState state) =>
      const TimeTableRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/time_table',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$DailyAttendanceRoute on GoRouteData {
  static DailyAttendanceRoute _fromState(GoRouterState state) =>
      const DailyAttendanceRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/daily_attendance',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$CurriRoute on GoRouteData {
  static CurriRoute _fromState(GoRouterState state) => const CurriRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/curriculum',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$SmartChatRoute on GoRouteData {
  static SmartChatRoute _fromState(GoRouterState state) =>
      const SmartChatRoute();

  @override
  String get location => GoRouteData.$location(
        '/dashbaord/smart_chat',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$CalendarRoute on GoRouteData {
  static CalendarRoute _fromState(GoRouterState state) => const CalendarRoute();

  @override
  String get location => GoRouteData.$location(
        '/calender',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ChangePasswordRoute on GoRouteData {
  static ChangePasswordRoute _fromState(GoRouterState state) =>
      const ChangePasswordRoute();

  @override
  String get location => GoRouteData.$location(
        '/change_password',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$AboutUsScreenRoute on GoRouteData {
  static AboutUsScreenRoute _fromState(GoRouterState state) =>
      const AboutUsScreenRoute();

  @override
  String get location => GoRouteData.$location(
        '/aboutUs',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ChangeAcademicRoute on GoRouteData {
  static ChangeAcademicRoute _fromState(GoRouterState state) =>
      const ChangeAcademicRoute();

  @override
  String get location => GoRouteData.$location(
        '/changeAcademic',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$TeacherProfileRoute on GoRouteData {
  static TeacherProfileRoute _fromState(GoRouterState state) =>
      const TeacherProfileRoute();

  @override
  String get location => GoRouteData.$location(
        '/teacher_profile',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authShellRoute => ShellRouteData.$route(
      navigatorKey: AuthShellRoute.$navigatorKey,
      factory: $AuthShellRouteExtension._fromState,
      routes: [
        GoRouteData.$route(
          path: '/teacher_verification',
          name: 'Teacher Verification',
          factory: _$TeacherVerificationRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/login',
          name: 'Login',
          factory: _$LoginRoute._fromState,
        ),
        GoRouteData.$route(
          path: '/forgot_password',
          name: 'Forgot Password',
          factory: _$ForgotPasswordRoute._fromState,
        ),
      ],
    );

extension $AuthShellRouteExtension on AuthShellRoute {
  static AuthShellRoute _fromState(GoRouterState state) =>
      const AuthShellRoute();
}

mixin _$TeacherVerificationRoute on GoRouteData {
  static TeacherVerificationRoute _fromState(GoRouterState state) =>
      const TeacherVerificationRoute();

  @override
  String get location => GoRouteData.$location(
        '/teacher_verification',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$LoginRoute on GoRouteData {
  static LoginRoute _fromState(GoRouterState state) => const LoginRoute();

  @override
  String get location => GoRouteData.$location(
        '/login',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ForgotPasswordRoute on GoRouteData {
  static ForgotPasswordRoute _fromState(GoRouterState state) =>
      const ForgotPasswordRoute();

  @override
  String get location => GoRouteData.$location(
        '/forgot_password',
      );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
