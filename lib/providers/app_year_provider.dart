import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'app_year_provider.g.dart';

@Riverpod(keepAlive: true)
class AppYear extends _$AppYear {
  @override
  String build() => "";

  String changeYear(String year) => state = year;
}
