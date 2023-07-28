import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
class TransactionModel with _$TransactionModel {
  const factory TransactionModel({
    required int uid,
    required int amount,
    required int createTime,
    required String senderAccountNo,
    required String traxType,
    required String receiverAccountNo,
    required String senderName,
    required String receiverName,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, Object?> json)
  => _$TransactionModelFromJson(json);
}