## Teacher App — Developer Guide (KT)

### Overview
- **Purpose**: Teacher-facing Flutter app for homework, leave management, attendance, curriculum, teacher notes, timetable, calendar, and SmartChat.
- **Architecture**: Feature-first structure; services → providers → views → widgets.
- **Key libs**: Riverpod, GoRouter (typed), Dio, Hive, Freezed, Json Serializable, ScreenUtil.

### Tech Stack
- **Dart/Flutter**: Dart SDK ^3.6.2
- **State**: flutter_riverpod, hooks_riverpod, riverpod_annotation
- **Routing**: go_router + codegen (typed routes)
- **Networking**: dio (+ pretty_dio_logger)
- **Models/Codegen**: freezed, json_serializable, build_runner
- **Storage**: hive_ce, hive_ce_flutter
- **UI**: flutter_hooks, flutter_screenutil, table_calendar
- **Other**: http, download, webview_flutter, flutter_form_builder

### Project Structure
- `lib/main.dart`: App entry; Hive init, adapters, `ProviderScope`, router wiring, `ScreenUtilInit`.
- `lib/router/`: Typed routes in `routers.dart`; router config and auth redirects in `router.dart`; startup orchestration in `app_startup.dart`.
- `lib/features/`: Feature modules (homework, leave_application, daily_attendance, curriculum, teacher_note, auth, home, etc.) each with models/providers/services/views/widgets.
- `lib/providers/`: Shared providers like `api_client_provider.dart`, academic year, etc.
- `assets/`: App images and icons (declared in `pubspec.yaml`).

### Setup
1. Install Flutter and Dart (matching SDK in `pubspec.yaml`).
2. Fetch deps:
```bash
flutter pub get
```
3. Generate code (models, routes, providers):
```bash
dart run build_runner build --delete-conflicting-outputs
```
4. iOS first-time (if needed):
```bash
cd ios && pod install && cd ..
```

### Run & Build
- Run app:
```bash
flutter run
```
- Android APK:
```bash
flutter build apk --split-per-abi -vv
```
- iOS (from macOS):
```bash
cd ios
rm -rf Pods Podfile.lock build .symlinks
flutter clean && flutter pub get
pod deintegrate && pod update && pod install
cd ..
flutter build ipa
```

### Routing
- Typed routes live in `lib/router/routers.dart`. After editing routes, re-run build_runner.
- Navigate via generated route classes:
```dart
context.push(const LeaveApplicationRoute().location, extra: leave);
```
- Auth redirects handled in `lib/router/router.dart` based on `authProvider`.

### State Management
- Riverpod with hooks: Use `HookConsumerWidget` where hooks + providers are needed.
- Feature providers usually in `features/<feature>/providers/` and expose fetch/mutation APIs.
- Preloading critical providers is done in `app_startup.dart`.

### Networking
- Base Dio client via `lib/providers/api_client_provider.dart`.
- Feature services wrap endpoints, e.g. `features/leave_application/services/leave_services.dart`.
- Base URL comes from authenticated user’s teacher verification (`teacherapkUrl`).

### Local Storage
- Hive used for caching auth/user data. Adapters registered in `main.dart` and box `teacherUserCache` is opened at startup.

### Feature Highlights
- **Leave Application**
  - Service: `features/leave_application/services/leave_services.dart`
  - Provider: `features/leave_application/providers/leave_provider.dart`
  - Views: dashboard (`leave_applic_dashobard_view.dart`), create/edit (`leave_application_view.dart`)
  - Status mapping: A=Applied, P=Approved, H=Hold, R=Rejected (reflected in UI labels and colors).
  - Save button is single-click safe with loading state.
- **Homework**
  - Attachments listed via service call; downloads supported.
  - Per-student status managed from `HomeworkVCard` and provider.
- **Daily Attendance, Curriculum, Teacher Note**
  - Follow same pattern: models → services → providers → views.

### Common Commands
```bash
# Dependencies
flutter pub get

# Codegen (models/routes/providers)
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs

# Launcher icons (if configured)
flutter pub run flutter_launcher_icons:main
```

### Conventions
- Use `ScreenUtil` units (`.w`, `.h`, `.sp`) for responsive UI.
- Prefer `StatelessWidget` / `HookConsumerWidget`; use `StatefulWidget` only when needed.
- Group code by feature (models, providers, services, views, widgets).
- Use `Utils.toast` for user feedback; `Utils.debLog` for debug logs.

### Troubleshooting
- Route not found: verify route in `routers.dart` and run build_runner.
- Codegen conflicts: add `--delete-conflicting-outputs`.
- API base URL empty: ensure login/verification returns `teacherapkUrl`.
- iOS CocoaPods issues: clean pods and reinstall (see iOS steps above).

### Notes
- Assets are declared in `pubspec.yaml` under `assets/`.
- Academic year context is managed under `features/home/providers/academic_year_provider.dart` and used across modules.

---

For deeper dives (e.g., adding a new endpoint, creating a new feature module, or enhancing a specific screen), follow the established pattern: Service → Provider → View, add typed route, and regenerate code.