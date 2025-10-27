// {
//     "status": true,
//     "subject_name": [
//         {
//             "sm_id": "11",
//             "name": "G.K"
//         }
//     ]
// }

import 'package:freezed_annotation/freezed_annotation.dart';

part 'multi_sub.freezed.dart';
part 'multi_sub.g.dart';

@freezed
abstract class MultiSub with _$MultiSub {
  const factory MultiSub({
    @JsonKey(name: "sm_id") String? id,
    @JsonKey(name: "name") String? name,
  }) = _MultiSub;

  factory MultiSub.fromJson(Map<String, dynamic> json) =>
      _$MultiSubFromJson(json);
}
