// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SavingModel _$$_SavingModelFromJson(Map<String, dynamic> json) =>
    _$_SavingModel(
      title: json['title'] as String,
      category: json['category'] as String,
      frequency: json['frequency'] as String,
      savingAdviceAmount: (json['savingAdviceAmount'] as num).toDouble(),
      currentSaving: json['currentSaving'],
      savingTarget: json['savingTarget'],
      startDate:
          const TimestampConverter().fromJson(json['startDate'] as Timestamp),
      endDate:
          const TimestampConverter().fromJson(json['endDate'] as Timestamp),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
    );

Map<String, dynamic> _$$_SavingModelToJson(_$_SavingModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'category': instance.category,
      'frequency': instance.frequency,
      'savingAdviceAmount': instance.savingAdviceAmount,
      'currentSaving': instance.currentSaving,
      'savingTarget': instance.savingTarget,
      'startDate': const TimestampConverter().toJson(instance.startDate),
      'endDate': const TimestampConverter().toJson(instance.endDate),
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
    };
