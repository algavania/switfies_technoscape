// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserModel _$$_UserModelFromJson(Map<String, dynamic> json) => _$_UserModel(
      name: json['name'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      city: json['city'] as String,
      role: json['role'] as String,
      address: json['address'] as String?,
      photoUrl: json['photoUrl'] as String?,
      hasSentFeedback: json['hasSentFeedback'] as bool?,
      birthdate:
          const TimestampConverter().fromJson(json['birthdate'] as Timestamp),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$_UserModelToJson(_$_UserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'username': instance.username,
      'email': instance.email,
      'city': instance.city,
      'role': instance.role,
      'address': instance.address,
      'photoUrl': instance.photoUrl,
      'hasSentFeedback': instance.hasSentFeedback,
      'birthdate': const TimestampConverter().toJson(instance.birthdate),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
