import 'dart:convert';

ShopCotactModel shopCotactModelFromJson(String str) => ShopCotactModel.fromJson(json.decode(str));

String shopCotactModelToJson(ShopCotactModel data) => json.encode(data.toJson());

class ShopCotactModel {
  String? name;

  String? owner;
  String? address;
  String? postal;
  String? city;
  String? telefon;
  String? web;
  String? email;
  String? finanzamt;
  String? steuernummer;
  String? paypalSecret;
  String? paypalClientId;
  String? details;
  ShopCotactModel({
    required this.name,
    required this.owner,
    required this.address,
    required this.postal,
    required this.city,
    required this.telefon,
    required this.web,
    required this.email,
    required this.finanzamt,
    required this.steuernummer,
    required this.paypalSecret,
    required this.paypalClientId,
    required this.details,
  });

  factory ShopCotactModel.fromJson(Map<String, dynamic> json) => ShopCotactModel(
        name: json["name"] ?? '',
        owner: json["owner"] ?? '',
        address: json["address"] ?? '',
        postal: json["postal"] ?? '',
        city: json["city"] ?? '',
        telefon: json["telefon"] ?? '',
        web: json["web"] ?? '',
        email: json["email"] ?? '',
        finanzamt: json["finanzamt"] ?? '',
        steuernummer: json["steuernummer"] ?? '',
        paypalSecret: json["paypal_client_secret"] ?? '',
        paypalClientId: json["paypal_client_id"] ?? '',
        details: json["details"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "owner": owner,
        "address": address,
        "postal": postal,
        "city": city,
        "telefon": telefon,
        "web": web,
        "email": email,
        "finanzamt": finanzamt,
        "steuernummer": steuernummer,
        "paypal_client_secret": paypalSecret,
        "paypal_client_id": paypalClientId,
        "details": details,
      };
}
