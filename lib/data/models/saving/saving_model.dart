import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../timestamp_converter.dart';

part 'saving_model.freezed.dart';
part 'saving_model.g.dart';

@freezed
class SavingModel with _$SavingModel {
  const factory SavingModel({
    required String title,
    required String category,
    required String frequency,
    required double savingAdviceAmount,
    required dynamic currentSaving,
    required dynamic savingTarget,
    @JsonKey(includeFromJson: false, includeToJson: false) String? id,
    @JsonKey(includeFromJson: false, includeToJson: false) DocumentSnapshot? documentSnapshot,
    @TimestampConverter() required DateTime startDate,
    @TimestampConverter() required DateTime endDate,
    @TimestampConverter() required DateTime createdAt,
  }) = _SavingModel;

  factory SavingModel.fromJson(Map<String, Object?> json)
  => _$SavingModelFromJson(json);
}