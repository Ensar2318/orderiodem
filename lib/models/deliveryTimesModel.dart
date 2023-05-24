// To parse this JSON data, do
//
//     final deliveryTimesModel = deliveryTimesModelFromJson(jsonString);

import 'dart:convert';

List<DeliveryTimesModel> deliveryTimesModelFromJson(String str) =>
    List<DeliveryTimesModel>.from(json.decode(str).map((x) => DeliveryTimesModel.fromJson(x)));

String deliveryTimesModelToJson(List<DeliveryTimesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DeliveryTimesModel {
  String date;

  List<Time> times;
  DeliveryTimesModel({
    required this.date,
    required this.times,
  });

  factory DeliveryTimesModel.fromJson(Map<String, dynamic> json) => DeliveryTimesModel(
        date: json["date"],
        times: List<Time>.from(json["times"].map((x) => Time.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "times": List<dynamic>.from(times.map((x) => x.toJson())),
      };
}

class Time {
  String fulltime;

  String time;
  Time({
    required this.fulltime,
    required this.time,
  });

  factory Time.fromJson(Map<String, dynamic> json) => Time(
        fulltime: json["fulltime"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "fulltime": fulltime,
        "time": time,
      };
}
