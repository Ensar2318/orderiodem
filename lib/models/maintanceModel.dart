// To parse this JSON data, do
//
//     final maintanceModel = maintanceModelFromJson(jsonString);

import 'dart:convert';

List<MaintanceModel> maintanceModelFromJson(String str) => List<MaintanceModel>.from(json.decode(str).map((x) => MaintanceModel.fromJson(x)));

String maintanceModelToJson(List<MaintanceModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaintanceModel {
  MaintanceModel({
    required this.appMaintenance,
    required this.appMaintenanceMessage,
  });

  String appMaintenance;
  String appMaintenanceMessage;

  factory MaintanceModel.fromJson(Map<String, dynamic> json) => MaintanceModel(
        appMaintenance: json["app_maintenance"] ?? '0',
        appMaintenanceMessage: json["app_maintenance_message"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "app_maintenance": appMaintenance,
        "app_maintenance_message": appMaintenanceMessage,
      };
}
