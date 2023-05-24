// To parse this JSON data, do
//
//     final staticModel = staticModelFromJson(jsonString);

import 'dart:convert';

StaticModel staticModelFromJson(String str) => StaticModel.fromJson(json.decode(str));

String staticModelToJson(StaticModel data) => json.encode(data.toJson());

class StaticModel {
  StaticModel({
    required this.termsAndConditions,
    required this.privacyPolicy,
  });

  String termsAndConditions;
  String privacyPolicy;

  factory StaticModel.fromJson(Map<String, dynamic> json) => StaticModel(
        termsAndConditions: json["terms_and_conditions"] ?? '',
        privacyPolicy: json["privacy_policy"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "terms_and_conditions": termsAndConditions,
        "privacy_policy": privacyPolicy,
      };
}
