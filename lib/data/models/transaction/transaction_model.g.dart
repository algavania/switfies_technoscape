// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TransactionModel _$$_TransactionModelFromJson(Map<String, dynamic> json) =>
    _$_TransactionModel(
      uid: json['uid'] as int?,
      amount: (json['amount'] as num).toDouble(),
      createTime: json['createTime'] as int?,
      senderAccountNo: json['senderAccountNo'] as String,
      traxType: json['traxType'] as String,
      receiverAccountNo: json['receiverAccountNo'] as String,
      senderName: json['senderName'] as String?,
      receiverName: json['receiverName'] as String?,
      isApproved: json['isApproved'] as bool?,
      relatedId: json['relatedId'] as int?,
    );

Map<String, dynamic> _$$_TransactionModelToJson(_$_TransactionModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'amount': instance.amount,
      'createTime': instance.createTime,
      'senderAccountNo': instance.senderAccountNo,
      'traxType': instance.traxType,
      'receiverAccountNo': instance.receiverAccountNo,
      'senderName': instance.senderName,
      'receiverName': instance.receiverName,
      'isApproved': instance.isApproved,
      'relatedId': instance.relatedId,
    };
