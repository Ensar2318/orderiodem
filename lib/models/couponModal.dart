// To parse this JSON data, do
//
//     final couponModal = couponModalFromJson(jsonString);

import 'dart:convert';

CouponModal couponModalFromJson(String str) => CouponModal.fromJson(json.decode(str));

String couponModalToJson(CouponModal data) => json.encode(data.toJson());

class CouponModal {
  int? status;

  String? giftamount;
  String? tipAmount;
  String? totalAmount;
  CouponModal({
    required this.status,
    required this.giftamount,
    required this.tipAmount,
    required this.totalAmount,
  });

  factory CouponModal.fromJson(Map<String, dynamic> json) => CouponModal(
        status: json["status"],
        giftamount: json["giftamount"].toString(),
        tipAmount: json["tip_amount"].toString(),
        totalAmount: json["total_amount"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "giftamount": giftamount,
        "tip_amount": tipAmount,
        "total_amount": totalAmount,
      };
}
