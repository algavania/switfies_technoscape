import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_model.freezed.dart';
part 'response_model.g.dart';

@freezed
class ResponseModel with _$ResponseModel {
  const factory ResponseModel({
    required String traceId,
    required dynamic data,
    String? errCode,
    required bool success,
    String? errMsg,
  }) = _ResponseModel;

  factory ResponseModel.fromJson(Map<String, Object?> json)
  => _$ResponseModelFromJson(json);
}