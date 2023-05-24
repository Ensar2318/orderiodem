// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.id,
    required this.firstname,
    required this.surname,
    required this.email,
    required this.phone,
    required this.pword,
    this.playerId,
    required this.shopId,
    required this.created,
  });

  String id;
  String firstname;
  String surname;
  String email;
  String phone;
  String pword;
  dynamic playerId;
  String shopId;
  DateTime created;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json["id"],
        firstname: json["firstname"],
        surname: json["surname"],
        email: json["email"],
        phone: json["phone"],
        pword: json["pword"],
        playerId: json["playerId"],
        shopId: json["shop_id"],
        created: DateTime.parse(json["created"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "surname": surname,
        "email": email,
        "phone": phone,
        "pword": pword,
        "playerId": playerId,
        "shop_id": shopId,
        "created": created.toIso8601String(),
      };
}
