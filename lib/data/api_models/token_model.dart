import 'dart:convert';

TokenModel tokenModelFromJson(String str) => TokenModel.fromJson(json.decode(str));

String tokenModelToJson(TokenModel data) => json.encode(data.toJson());

class TokenModel {
  final String traceId;
  final Data data;
  final bool success;

  TokenModel({
    required this.traceId,
    required this.data,
    required this.success,
  });

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    traceId: json["traceId"],
    data: Data.fromJson(json["data"]),
    success: json["success"],
  );

  Map<String, dynamic> toJson() => {
    "traceId": traceId,
    "data": data.toJson(),
    "success": success,
  };
}

class Data {
  final String accessToken;

  Data({
    required this.accessToken,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["accessToken"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
  };
}
