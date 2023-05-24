// To parse this JSON data, do
//
//     final discountsModel = discountsModelFromJson(jsonString);

import 'dart:convert';

List<DiscountsModel> discountsModelFromJson(String str) => List<DiscountsModel>.from(json.decode(str).map((x) => DiscountsModel.fromJson(x)));

String discountsModelToJson(List<DiscountsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DiscountsModel {
  String? id;

  String? label;
  String? active;
  String? type;
  String? value;
  String? quantity;
  String? perUser;
  String? validFor;
  String? selections;
  String? startdate;
  String? enddate;
  String? starttime;
  String? endtime;
  String? day;
  String? code;
  String? shopId;
  String? content;
  DiscountsModel({
    required this.id,
    required this.label,
    required this.active,
    required this.type,
    required this.value,
    required this.quantity,
    required this.perUser,
    required this.validFor,
    required this.selections,
    required this.startdate,
    required this.enddate,
    required this.starttime,
    required this.endtime,
    required this.day,
    required this.code,
    required this.shopId,
    required this.content,
  });

  factory DiscountsModel.fromJson(Map<String, dynamic> json) => DiscountsModel(
        id: json["id"],
        label: json["label"],
        active: json["active"],
        type: json["type"],
        value: json["value"],
        quantity: json["quantity"],
        perUser: json["per_user"],
        validFor: json["valid_for"],
        selections: json["selections"],
        startdate: json["startdate"],
        enddate: json["enddate"],
        starttime: json["starttime"],
        endtime: json["endtime"],
        day: json["day"],
        code: json["code"],
        shopId: json["shop_id"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label": label,
        "active": active,
        "type": type,
        "value": value,
        "quantity": quantity,
        "per_user": perUser,
        "valid_for": validFor,
        "selections": selections,
        "startdate": startdate,
        "enddate": enddate,
        "starttime": starttime,
        "endtime": endtime,
        "day": day,
        "code": code,
        "shop_id": shopId,
        "content": content,
      };
}
