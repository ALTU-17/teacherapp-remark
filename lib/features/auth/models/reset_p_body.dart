// To parse this JSON data, do
//
//     final ResetPBody = ResetPBodyFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'reset_p_body.freezed.dart';
part 'reset_p_body.g.dart';

@freezed
abstract class ResetPBody with _$ResetPBody {
  const factory ResetPBody({
    @JsonKey(name: "short_name") String? shortName,
    @JsonKey(name: "user_id") String? userId,
    @JsonKey(name: "answer_one") String? answerOne,
    @JsonKey(name: "dob") String? dob,
    @Default('T') @JsonKey(name: "role_id") String? roleID,
  }) = _ResetPBody;

  factory ResetPBody.fromJson(Map<String, dynamic> json) =>
      _$ResetPBodyFromJson(json);
}

// short_name:SACS
// user_id:kavita@arnolds
// answer_one:Meena
// dob:2025-05-20
// role_id:T
