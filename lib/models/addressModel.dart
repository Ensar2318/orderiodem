// To parse this JSON data, do
//
//     final addressModel = addressModelFromJson(jsonString);

import 'dart:convert';

List<AddressModel> addressModelFromJson(String str) => List<AddressModel>.from(json.decode(str).map((x) => AddressModel.fromJson(x)));

String addressModelToJson(List<AddressModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AddressModel {
  String id;

  dynamic label;
  String address;
  String areaId;
  String customerId;
  String shopId;
  String def;
  String area;
  AddressModel({
    required this.id,
    required this.label,
    required this.address,
    required this.areaId,
    required this.customerId,
    required this.shopId,
    required this.def,
    required this.area,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        id: json["id"],
        label: json["label"] ?? "",
        address: json["address"] ?? "",
        areaId: json["area_id"] ?? "",
        customerId: json["customer_id"] ?? "",
        shopId: json["shop_id"] ?? "",
        def: json["def"] ?? "",
        area: json["area"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "address": address,
        "area_id": areaId,
        "customer_id": customerId,
        "shop_id": shopId,
        "def": def,
        "area": area,
      };
}
