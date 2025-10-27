import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/router/app_startup.dart';

import '../features/auth/providers/providers.dart';
import 'routers.dart';
part 'router.g.dart';

/// Exposes a [GoRouter] that uses a [Listenable] to refresh its internal state.
///
/// With Riverpod, we can't register a dependency via an Inherited Widget,
/// thus making this implementation the "leanest" possible
///
/// To sync our app state with this our router, we simply update our listenable via `ref.listen`,
/// and pass it to GoRouter's `refreshListenable`.
/// In this example, this will trigger redirects on any authentication change.
///
/// Obviously, more logic could be implemented here, but again, this is meant to be a simple example.
/// You can always build more listenables and even merge more than one into a more complex `ChangeNotifier`,
/// but that's up to your case and out of this scope.
@riverpod
GoRouter router(Ref ref) {
  final apState = ref.watch(appStartupProvider);
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());
  ref
    ..onDispose(isAuth.dispose) // don't forget to clean after yourselves (:
    // update the listenable, when some provider value changes
    // here, we are just interested in wheter the user's logged in
    ..listen(
      authProvider.select(
        (v) => v.whenData(
          (v) => v.userId == null ? false : true,
        ),
      ),
      (_, next) {
        isAuth.value = next;
      },
      fireImmediately: true,
    );

  final router = GoRouter(
    navigatorKey: routerKey,
    refreshListenable: isAuth,
    initialLocation: const DashboardRoute().location,
    debugLogDiagnostics: kDebugMode,
    routes: $appRoutes,
    redirect: (context, state) {
      final auth = ref.read(authProvider).requireValue.userId != null;
      final path = state.uri.path;
      final isSplash = state.uri.path == const SplashRoute().location;
      if (isSplash) {
        return auth
            ? const DashboardRoute().location
            : const TeacherVerificationRoute().location;
      }
      final isLoggingIn = path == const TeacherVerificationRoute().location ||
          path == const LoginRoute().location ||
          path == const ForgotPasswordRoute().location;

      if (isLoggingIn) return auth ? const DashboardRoute().location : null;

      return auth ? null : const SplashRoute().location;
    },
  );
  ref.onDispose(router.dispose); // always clean up after yourselves (:

  return router;
}
