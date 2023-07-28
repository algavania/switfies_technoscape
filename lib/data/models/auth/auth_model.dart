import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    required String ktpId,
    required String username,
    required String loginPassword,
    required String phoneNumber,
    required String birthDate,
    required int gender,
    required String email,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, Object?> json)
  => _$AuthModelFromJson(json);
}