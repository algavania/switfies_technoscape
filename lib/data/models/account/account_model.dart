import 'package:freezed_annotation/freezed_annotation.dart';

part 'account_model.freezed.dart';
part 'account_model.g.dart';

@freezed
class AccountModel with _$AccountModel {
  const factory AccountModel({
    required int uid,
    required int balance,
    required String accountName,
    required String accountNo,
    required String status,
    required int createTime,
    required int updateTime,
  }) = _AccountModel;

  factory AccountModel.fromJson(Map<String, Object?> json)
  => _$AccountModelFromJson(json);
}