// To parse this JSON data, do
//
//     final cartModel = cartModelFromJson(jsonString);

import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  String amount;

  String discountamount;
  String giftamount;
  String total;
  String totalUnformatted;
  List<CartProduct> products;
  CartModel({
    required this.amount,
    required this.discountamount,
    required this.giftamount,
    required this.total,
    required this.products,
    required this.totalUnformatted,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        amount: json["amount"],
        discountamount: json["discountamount"],
        giftamount: json["giftamount"],
        total: json["total"],
        totalUnformatted: json["total_unformatted"].toString(),
        products: List<CartProduct>.from(json["products"].map((x) => CartProduct.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "discountamount": discountamount,
        "giftamount": giftamount,
        "total": total,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class CartProduct {
  int id;

  int variantId;
  String name;
  String? image;
  int quantity;
  String price;
  String total;
  String? extras;
  List<dynamic>? extrasArray;
  String? note;
  int cartId;
  String? discountPrice;
  String? extraSelectionKey;
  String? extraSelection;
  List<dynamic>? subProducts;
  CartProduct({
    required this.id,
    required this.variantId,
    required this.name,
    required this.image,
    required this.quantity,
    required this.price,
    required this.total,
    required this.extras,
    required this.extrasArray,
    required this.note,
    required this.cartId,
    required this.discountPrice,
    required this.extraSelectionKey,
    required this.extraSelection,
    required this.subProducts,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        id: json["id"],
        variantId: json["variant_id"],
        name: json["name"] ?? "",
        image: json["image"],
        quantity: json["quantity"],
        price: json["price"],
        total: json["total"],
        extras: json["extras"],
        extrasArray: json["extras_array"] != null ? List<dynamic>.from(json["extras_array"].map((x) => x)) : null,
        note: json["note"] ?? "",
        cartId: json["cart_id"],
        discountPrice: json["discount_price"],
        extraSelectionKey: json["extra_selection_key"],
        extraSelection: json["extra_selection"],
        subProducts: List<dynamic>.from(json["sub_products"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "variant_id": variantId,
        "name": name,
        "image": image,
        "quantity": quantity,
        "price": price,
        "total": total,
        "extras": extras,
        "extras_array": List<dynamic>.from(extrasArray!.map((x) => x)),
        "note": note,
        "cart_id": cartId,
        "discount_price": discountPrice,
        "extra_selection_key": extraSelectionKey,
        "extra_selection": extraSelection,
        "sub_products": List<dynamic>.from(subProducts!.map((x) => x)),
      };
}
