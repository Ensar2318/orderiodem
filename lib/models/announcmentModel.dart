// To parse this JSON data, do
//
//     final announcmentModel = announcmentModelFromJson(jsonString);

import 'dart:convert';

List<AnnouncmentModel> announcmentModelFromJson(String str) => List<AnnouncmentModel>.from(json.decode(str).map((x) => AnnouncmentModel.fromJson(x)));

String announcmentModelToJson(List<AnnouncmentModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnnouncmentModel {
  String? id;
  String? row;
  String? content;
  String? startdate;
  String? enddate;
  String? active;
  String? shopId;

  AnnouncmentModel({
    required this.id,
    required this.row,
    required this.content,
    required this.startdate,
    required this.enddate,
    required this.active,
    required this.shopId,
  });

  factory AnnouncmentModel.fromJson(Map<String, dynamic> json) => AnnouncmentModel(
        id: json["id"],
        row: json["row"],
        content: json["content"],
        startdate: json["startdate"].toString(),
        enddate: json["enddate"].toString(),
        active: json["active"],
        shopId: json["shop_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "row": row,
        "content": content,
        "startdate": startdate.toString(),
        "enddate": enddate.toString(),
        "active": active,
        "shop_id": shopId,
      };
}
