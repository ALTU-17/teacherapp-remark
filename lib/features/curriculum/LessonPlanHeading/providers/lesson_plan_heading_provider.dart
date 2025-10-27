import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/lesson_plan_heading.dart'; // For auth
import 'package:teacherapp/features/auth/auth.dart';
import 'package:teacherapp/providers/api_client_provider.dart';

import '../services/lesson_plan_heading_service.dart';

final lessonPlanHeadingProvider = FutureProvider<List<LessonPlanHeading>>((ref) async {
  final auth = ref.read(authProvider).requireValue;
  final dio = await ref.read(apiClientProvider.future);
  final service = LessonPlanHeadingService(dio, auth.teacherVerification?.teacherapkUrl ?? '');
  return service.getHeadings(auth.teacherVerification?.shortName ?? '');
});

// For delete
final lessonPlanHeadingServiceProvider = Provider<LessonPlanHeadingService>((ref) {
  final auth = ref.read(authProvider).requireValue;
  final dio = ref.read(apiClientProvider).requireValue;
  return LessonPlanHeadingService(dio, auth.teacherVerification?.teacherapkUrl ?? '');
});

final lessonPlanHeadingCreateProvider = Provider<LessonPlanHeadingService>((ref) {
  final auth = ref.read(authProvider).requireValue;
  final dio = ref.read(apiClientProvider).requireValue;
  return LessonPlanHeadingService(
    dio, auth.teacherVerification?.teacherapkUrl ?? '',
  );
});
