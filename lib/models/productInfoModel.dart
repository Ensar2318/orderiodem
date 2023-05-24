// To parse this JSON data, do
//
//     final productInfoModel = productInfoModelFromJson(jsonString);

import 'dart:convert';

ProductInfoModel productInfoModelFromJson(String str) => ProductInfoModel.fromJson(json.decode(str));

String productInfoModelToJson(ProductInfoModel data) => json.encode(data.toJson());

class ProductInfoModel {
  ProductInfoModel({
    required this.allergens,
    required this.additives,
  });

  List<String> allergens;
  List<String> additives;

  factory ProductInfoModel.fromJson(Map<String, dynamic> json) => ProductInfoModel(
        allergens: List<String>.from(json["allergens"].map((x) => x)),
        additives: List<String>.from(json["additives"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "allergens": List<dynamic>.from(allergens.map((x) => x)),
        "additives": List<dynamic>.from(additives.map((x) => x)),
      };
}
