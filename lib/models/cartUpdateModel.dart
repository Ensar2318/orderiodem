// To parse this JSON data, do
//
//     final cartUpdateModel = cartUpdateModelFromJson(jsonString);

import 'dart:convert';

import 'package:zwerge/models/areaModel.dart';

CartUpdateModel cartUpdateModelFromJson(String str) => CartUpdateModel.fromJson(json.decode(str));

String cartUpdateModelToJson(CartUpdateModel data) => json.encode(data.toJson());

class CartUpdateModel {
  int status;

  String? totalAmount;
  String? amount;
  String? deliveryMin;
  String? cartQuantity;
  String? discountamount;
  AreaModel? areas;
  CartUpdateModel({
    required this.status,
    required this.areas,
    required this.totalAmount,
    required this.amount,
    required this.deliveryMin,
    required this.cartQuantity,
    required this.discountamount,
  });

  factory CartUpdateModel.fromJson(Map<String, dynamic> json) => CartUpdateModel(
        status: json["status"],
        totalAmount: json["total_amount"],
        amount: json["amount"],
        deliveryMin: json["delivery_min"],
        cartQuantity: json["cart_quantity"] ?? '0',
        discountamount: json["discountamount"],
        areas: json["areas"] != null ? AreaModel.fromJson(json["areas"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "total_amount": totalAmount,
        "amount": amount,
        "delivery_min": deliveryMin,
        "cart_quantity": cartQuantity,
        "discountamount": discountamount,
        "areas": areas != null ? areas!.toJson() : '',
      };
}
