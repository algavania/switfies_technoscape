// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthModel _$$_AuthModelFromJson(Map<String, dynamic> json) => _$_AuthModel(
      uid: json['uid'] as int?,
      ktpId: json['ktpId'] as String?,
      username: json['username'] as String?,
      loginPassword: json['loginPassword'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      birthDate: json['birthDate'] as String?,
      gender: json['gender'],
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$_AuthModelToJson(_$_AuthModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'ktpId': instance.ktpId,
      'username': instance.username,
      'loginPassword': instance.loginPassword,
      'phoneNumber': instance.phoneNumber,
      'birthDate': instance.birthDate,
      'gender': instance.gender,
      'email': instance.email,
    };
