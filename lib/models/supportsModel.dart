// To parse this JSON data, do
//
//     final support = supportFromJson(jsonString);

import 'dart:convert';

List<Support> supportFromJson(String str) => List<Support>.from(json.decode(str).map((x) => Support.fromJson(x)));

String supportToJson(List<Support> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Support {
  String id;

  String subject;
  String message;
  String customerId;
  String responseTo;
  String shopId;
  String created;
  List<Support>? responses;
  Support({
    required this.id,
    required this.subject,
    required this.message,
    required this.customerId,
    required this.responseTo,
    required this.shopId,
    required this.created,
    this.responses,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
        id: json["id"],
        subject: json["subject"] == null ? '' : json["subject"] ?? '',
        message: json["message"],
        customerId: json["customer_id"],
        responseTo: json["response_to"],
        shopId: json["shop_id"],
        created: json["created"],
        responses: json["responses"] == null ? null : List<Support>.from(json["responses"].map((x) => Support.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject == null ? null : subject,
        "message": message,
        "customer_id": customerId,
        "response_to": responseTo,
        "shop_id": shopId,
        "created": created,
        "responses": responses == null ? null : List<dynamic>.from(responses!.map((x) => x.toJson())),
      };
}
