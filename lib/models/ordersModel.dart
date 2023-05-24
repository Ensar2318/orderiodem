// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

List<OrdersModel> ordersModelFromJson(String str) => List<OrdersModel>.from(json.decode(str).map((x) => OrdersModel.fromJson(x)));

String ordersModelToJson(List<OrdersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
  String? id;

  String? transactionId;
  String? customerId;
  String? name;
  String? address;
  String? postal;
  String? city;
  String? email;
  String? phone;
  String? company;
  String? status;
  String? amount;
  String? deliveryAmount;
  String? discountAmount;
  String? giftAmount;
  String? tipAmount;
  String? totalAmount;
  String? paymentMethod;
  String? deliveryTime;
  String? note;
  dynamic couponCode;
  String? ip;
  String? sessionid;
  String? shopId;
  String? created;
  String? tableId;
  List<Product> products;
  int rated;
  OrdersModel({
    required this.id,
    required this.transactionId,
    required this.customerId,
    required this.name,
    required this.address,
    required this.postal,
    required this.city,
    required this.email,
    required this.phone,
    required this.company,
    required this.status,
    required this.amount,
    required this.deliveryAmount,
    required this.discountAmount,
    required this.giftAmount,
    required this.tipAmount,
    required this.totalAmount,
    required this.paymentMethod,
    required this.deliveryTime,
    required this.note,
    required this.couponCode,
    required this.ip,
    required this.sessionid,
    required this.shopId,
    required this.created,
    required this.tableId,
    required this.products,
    required this.rated,
  });

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        id: json["id"],
        transactionId: json["transaction_id"],
        customerId: json["customer_id"],
        name: json["name"],
        address: json["address"],
        postal: json["postal"],
        city: json["city"],
        email: json["email"],
        phone: json["phone"],
        company: json["company"],
        status: json["status"],
        amount: json["amount"],
        deliveryAmount: json["delivery_amount"],
        discountAmount: json["discount_amount"],
        giftAmount: json["gift_amount"],
        tipAmount: json["tip_amount"],
        totalAmount: json["total_amount"],
        paymentMethod: json["payment_method"],
        deliveryTime: json["delivery_time"],
        note: json["note"],
        couponCode: json["coupon_code"],
        ip: json["ip"],
        sessionid: json["sessionid"],
        shopId: json["shop_id"],
        created: json["created"],
        tableId: json["table_id"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
        rated: json["rated"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "customer_id": customerId,
        "name": name,
        "address": address,
        "postal": postal,
        "city": city,
        "email": email,
        "phone": phone,
        "company": company,
        "status": status,
        "amount": amount,
        "delivery_amount": deliveryAmount,
        "discount_amount": discountAmount,
        "gift_amount": giftAmount,
        "tip_amount": tipAmount,
        "total_amount": totalAmount,
        "payment_method": paymentMethod,
        "delivery_time": deliveryTime,
        "note": note,
        "coupon_code": couponCode,
        "ip": ip,
        "sessionid": sessionid,
        "shop_id": shopId,
        "created": created,
        "table_id": tableId,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
        "rated": rated,
      };
}

class Product {
  String? id;

  String? orderId;
  String? productId;
  String? variantId;
  String? name;
  dynamic image;
  String? quantity;
  String? price;
  dynamic stripePriceId;
  String? total;
  dynamic subProducts;
  dynamic extras;
  dynamic note;
  dynamic extraSelection;
  Product({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.variantId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.stripePriceId,
    required this.total,
    required this.subProducts,
    required this.extras,
    required this.note,
    required this.extraSelection,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        variantId: json["variant_id"],
        name: json["name"],
        image: json["image"],
        quantity: json["quantity"],
        price: json["price"],
        stripePriceId: json["stripe_price_id"],
        total: json["total"],
        subProducts: json["sub_products"],
        extras: json["extras"],
        note: json["note"],
        extraSelection: json["extra_selection"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "variant_id": variantId,
        "name": name,
        "image": image,
        "quantity": quantity,
        "price": price,
        "stripe_price_id": stripePriceId,
        "total": total,
        "sub_products": subProducts,
        "extras": extras,
        "note": note,
        "extra_selection": extraSelection,
      };
}
