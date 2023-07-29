import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    int? uid,
    required String displayName,
    required String role,
    int? relatedId,
    required String loginPassword,
    required String username,
    String? accountNo,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json)
  => _$UserModelFromJson(json);
}