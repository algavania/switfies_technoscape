import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_model.freezed.dart';
part 'auth_model.g.dart';

@freezed
class AuthModel with _$AuthModel {
  const factory AuthModel({
    int? uid,
    String? ktpId,
    String? username,
    String? loginPassword,
    String? phoneNumber,
    String? birthDate,
    dynamic gender,
    String? email,
  }) = _AuthModel;

  factory AuthModel.fromJson(Map<String, Object?> json)
  => _$AuthModelFromJson(json);
}