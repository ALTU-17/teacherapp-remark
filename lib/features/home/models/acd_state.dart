import 'package:freezed_annotation/freezed_annotation.dart';
import 'acd_year.dart';
part 'acd_state.freezed.dart';

@freezed
abstract class AcdState with _$AcdState {
  const factory AcdState({
    @Default([]) List<AcdYear> academicYrs,
    @Default('2025-2026') String selectedYear,
  }) = _AcdState;
}
