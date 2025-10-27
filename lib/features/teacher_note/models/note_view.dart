//  {
//           "roll_no": "0",
//           "first_name": "SHRAVYA",
//           "mid_name": "SHREEYASH",
//           "last_name": "MIRAJKAR",
//           "read_status": "0",
//           "student_id": "21733"
//       },

import 'package:freezed_annotation/freezed_annotation.dart';

part 'note_view.freezed.dart';
part 'note_view.g.dart';

@freezed
abstract class NoteView with _$NoteView {
  const factory NoteView({
    @JsonKey(name: 'roll_no') String? rollNo,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'mid_name') String? midName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'read_status') String? readStatus,
    @JsonKey(name: 'student_id') String? studentId,
  }) = _NoteView;

  factory NoteView.fromJson(Map<String, dynamic> json) =>
      _$NoteViewFromJson(json);
}
