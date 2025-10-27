import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teacherapp/features/leave_application/providers/leave_provider.dart';

import '../features/auth/auth.dart';
import '../providers/api_client_provider.dart';

part 'app_startup.g.dart';

@Riverpod(keepAlive: true)
Future<void> appStartup(Ref ref) async {
  ref.onDispose(() {});
  await ref.read(apiClientProvider.future);
  //await Future.delayed(const Duration(seconds: 3));
  await ref.read(authProvider.future);
  await ref.read(leavePProvider.future);
  return;
}

/// Widget class to manage asynchronous app initialization
class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key, required this.onLoaded});
  final Widget onLoaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. eagerly initialize appStartupProvider (and all the providers it depends on)
    final appStartupState = ref.watch(appStartupProvider);
    return appStartupState.when(
      // 3. loading state
      loading: () => const AppStartupLoadingWidget(),
      // 4. error state
      error: (e, st) => AppStartupErrorWidget(
        message: e.toString(),
        // 5. invalidate the appStartupProvider
        onRetry: () => ref.invalidate(appStartupProvider),
      ),
      // 6. success - now load the main app
      data: (_) => onLoaded,
    );
  }
}

class AppStartupLoadingWidget extends StatelessWidget {
  const AppStartupLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF7CCA2),
            Color(0xFFF64784)
          ], // Define the colors for the gradient
          begin: Alignment.topLeft, // Starting point of the gradient
          end: Alignment.bottomRight, // Ending point of the gradient
        ),
        // color: color.pinkcolor,
      ),
      height: 20,
      width: double.infinity,
    );
  }
}

class AppStartupErrorWidget extends StatelessWidget {
  const AppStartupErrorWidget(
      {super.key, required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(message, style: Theme.of(context).textTheme.headlineSmall),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
