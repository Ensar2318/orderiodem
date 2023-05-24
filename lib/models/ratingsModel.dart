// To parse this JSON data, do
//
//     final ratingsModel = ratingsModelFromJson(jsonString);

import 'dart:convert';

List<RatingsModel> ratingsModelFromJson(String str) => List<RatingsModel>.from(json.decode(str).map((x) => RatingsModel.fromJson(x)));

String ratingsModelToJson(List<RatingsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// To parse this JSON data, do
//
//     final ratingsScoreModel = ratingsScoreModelFromJson(jsonString);

RatingsScoreModel ratingsScoreModelFromJson(String str) => RatingsScoreModel.fromJson(json.decode(str));

String ratingsScoreModelToJson(RatingsScoreModel data) => json.encode(data.toJson());

class RatingsModel {
  String id;

  String? orderId;
  String? customerId;
  String? active;
  String? rating;
  String? subject;
  String? comment;
  String? created;
  String? shopId;
  String? owner;
  RatingsModel({
    required this.id,
    required this.orderId,
    required this.customerId,
    required this.active,
    required this.rating,
    required this.subject,
    required this.comment,
    required this.created,
    required this.shopId,
    required this.owner,
  });

  factory RatingsModel.fromJson(Map<String, dynamic> json) => RatingsModel(
        id: json["id"] ?? "",
        orderId: json["order_id"] ?? "",
        customerId: json["customer_id"] ?? "",
        active: json["active"] ?? "",
        rating: json["rating"] ?? "",
        subject: json["subject"] ?? "",
        comment: json["comment"] ?? "",
        created: json["created"] ?? "",
        shopId: json["shop_id"] ?? "",
        owner: json["owner"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "customer_id": customerId,
        "active": active,
        "rating": rating,
        "subject": subject,
        "comment": comment,
        "created": created,
        "shop_id": shopId,
        "owner": owner,
      };
}

class RatingsScoreModel {
  String? ratingAverage;

  String? ratingCount;
  RatingsScoreModel({
    required this.ratingAverage,
    required this.ratingCount,
  });

  factory RatingsScoreModel.fromJson(Map<String, dynamic> json) => RatingsScoreModel(
        ratingAverage: json["rating_average"] ?? "",
        ratingCount: json["rating_count"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "rating_average": ratingAverage,
        "rating_count": ratingCount,
      };
}
