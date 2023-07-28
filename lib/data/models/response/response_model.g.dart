// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ResponseModel _$$_ResponseModelFromJson(Map<String, dynamic> json) =>
    _$_ResponseModel(
      traceId: json['traceId'] as String,
      data: json['data'],
      errCode: json['errCode'] as String?,
      success: json['success'] as bool,
      errMsg: json['errMsg'] as String?,
    );

Map<String, dynamic> _$$_ResponseModelToJson(_$_ResponseModel instance) =>
    <String, dynamic>{
      'traceId': instance.traceId,
      'data': instance.data,
      'errCode': instance.errCode,
      'success': instance.success,
      'errMsg': instance.errMsg,
    };
