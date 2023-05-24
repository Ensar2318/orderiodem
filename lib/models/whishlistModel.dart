// To parse this JSON data, do
//
//     final whishlistModel = whishlistModelFromJson(jsonString);

import 'dart:convert';

List<WhishlistModel> whishlistModelFromJson(String str) => List<WhishlistModel>.from(json.decode(str).map((x) => WhishlistModel.fromJson(x)));

String whishlistModelToJson(List<WhishlistModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WhishlistModel {
  WhishlistModel({
    required this.id,
    required this.productId,
    required this.customerId,
    required this.shopId,
    required this.createdAt,
    required this.row,
    required this.name,
    required this.shortdesc,
    required this.price,
    this.discountedPrice,
    required this.active,
    this.image,
    required this.categoryId,
    this.subProducts,
  });

  String id;
  String productId;
  String customerId;
  String shopId;
  DateTime createdAt;
  String row;
  String name;
  String shortdesc;
  String price;
  dynamic? discountedPrice;
  String active;
  String? image;
  String categoryId;
  dynamic subProducts;

  factory WhishlistModel.fromJson(Map<String, dynamic> json) => WhishlistModel(
        id: json["id"],
        productId: json["product_id"],
        customerId: json["customer_id"],
        shopId: json["shop_id"],
        createdAt: DateTime.parse(json["created_at"]),
        row: json["row"],
        name: json["name"],
        shortdesc: json["shortdesc"],
        price: json["price"] ?? '',
        discountedPrice: json["discounted_price"],
        active: json["active"],
        image: json["image"],
        categoryId: json["category_id"],
        subProducts: json["sub_products"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "customer_id": customerId,
        "shop_id": shopId,
        "created_at": createdAt.toIso8601String(),
        "row": row,
        "name": name,
        "shortdesc": shortdesc,
        "price": price,
        "discounted_price": discountedPrice,
        "active": active,
        "image": image,
        "category_id": categoryId,
        "sub_products": subProducts,
      };
}
