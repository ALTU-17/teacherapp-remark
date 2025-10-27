// To parse this JSON data, do
//
//     final forgotPBody = forgotPBodyFromJson(jsonString);

import 'package:freezed_annotation/freezed_annotation.dart';

part 'forgot_p_body.freezed.dart';
part 'forgot_p_body.g.dart';

@freezed
abstract class ForgotPBody with _$ForgotPBody {
  const factory ForgotPBody({
    @JsonKey(name: "short_name") String? shortName,
    @JsonKey(name: "user_id") String? userId,
    @JsonKey(name: "answerone") String? answerOne,
    @JsonKey(name: "password_re") String? passwordRe,
    @JsonKey(name: "password_old") String? passwordOld,
    @JsonKey(name: "password_new") String? passwordNew,
  }) = _ForgotPBody;

  factory ForgotPBody.fromJson(Map<String, dynamic> json) =>
      _$ForgotPBodyFromJson(json);
}
