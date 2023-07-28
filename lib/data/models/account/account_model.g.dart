// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AccountModel _$$_AccountModelFromJson(Map<String, dynamic> json) =>
    _$_AccountModel(
      uid: json['uid'] as int,
      balance: json['balance'] as int,
      accountName: json['accountName'] as String,
      accountNo: json['accountNo'] as String,
      status: json['status'] as String,
      createTime: json['createTime'] as int,
      updateTime: json['updateTime'] as int,
    );

Map<String, dynamic> _$$_AccountModelToJson(_$_AccountModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'balance': instance.balance,
      'accountName': instance.accountName,
      'accountNo': instance.accountNo,
      'status': instance.status,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
    };
