// To parse this JSON data, do
//
//     final areaModel = areaModelFromJson(jsonString);

import 'dart:convert';

List<AreaModel> areaModelFromJson(String str) => List<AreaModel>.from(json.decode(str).map((x) => AreaModel.fromJson(x)));
AreaModel areaModelFromJson2(String str) => AreaModel.fromJson(json.decode(str));

String areaModelToJson(List<AreaModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AreaModel {
  String id;

  String shopId;
  String postal;
  String city;
  String minAmount;
  String deliveryAmount;
  String? distance;
  AreaModel({
    required this.id,
    required this.shopId,
    required this.postal,
    required this.city,
    required this.minAmount,
    required this.deliveryAmount,
    required this.distance,
  });

  factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
        id: json["id"],
        shopId: json["shop_id"],
        postal: json["postal"] ?? '',
        city: json["city"] ?? '',
        minAmount: json["min_amount"],
        deliveryAmount: json["delivery_amount"],
        distance: json["distance"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_id": shopId,
        "postal": postal,
        "city": city,
        "min_amount": minAmount,
        "delivery_amount": deliveryAmount,
        "distance": distance,
      };
}
