// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      uid: json['uid'] as int?,
      displayName: json['displayName'] as String,
      role: json['role'] as String,
      relatedId: json['relatedId'] as int?,
      loginPassword: json['loginPassword'] as String,
      username: json['username'] as String,
      accountNo: json['accountNo'] as String?,
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'displayName': instance.displayName,
      'role': instance.role,
      'relatedId': instance.relatedId,
      'loginPassword': instance.loginPassword,
      'username': instance.username,
      'accountNo': instance.accountNo,
    };
