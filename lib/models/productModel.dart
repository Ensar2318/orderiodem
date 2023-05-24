// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}

class Extra {
  String extraId;

  String? price;
  String label;
  String unformattedPrice;
  bool check;
  Extra({
    required this.extraId,
    required this.price,
    required this.label,
    required this.unformattedPrice,
    required this.check,
  });

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
        extraId: json["extra_id"],
        price: json["price"],
        label: json["label"],
        unformattedPrice: json["unformatted_price"],
        check: false,
      );

  Map<String, dynamic> toJson() => {
        "extra_id": extraId,
        "label": label,
        "unformatted_price": unformattedPrice,
        "check": check,
      };
}

class Option {
  String text;

  String price;
  Option({
    required this.text,
    required this.price,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        text: json["text"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "text": text,
        "price": price,
      };
}

class OptionsClass {
  String id;

  String productId;
  String title;
  List<Option> options;
  OptionsClass({
    required this.id,
    required this.productId,
    required this.title,
    required this.options,
  });

  factory OptionsClass.fromJson(Map<String, dynamic> json) => OptionsClass(
        id: json["id"],
        productId: json["product_id"],
        title: json["title"],
        options: List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "title": title,
        "options": List<dynamic>.from(options.map((x) => x.toJson())),
      };
}

class Product {
  String id;

  int cart;
  String row;
  String? name;
  String? shortdesc;
  String? price;
  String? discountedPrice;
  String? active;
  String? image;
  String? categoryId;
  String? shopId;
  List<dynamic> subProducts;
  String? unformattedPrice;
  String? unformattedDiscountedPrice;
  String? autodesc;
  dynamic options;
  List<Variant> variants;
  List<Extra>? extras;
  Product({
    required this.id,
    required this.row,
    required this.name,
    required this.shortdesc,
    required this.price,
    required this.discountedPrice,
    required this.active,
    required this.image,
    required this.categoryId,
    required this.shopId,
    required this.subProducts,
    required this.unformattedPrice,
    required this.unformattedDiscountedPrice,
    required this.autodesc,
    required this.options,
    required this.variants,
    required this.extras,
    this.cart = 0,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        row: json["row"],
        name: json["name"],
        shortdesc: json["shortdesc"] == null ? null : json["shortdesc"],
        price: json["price"],
        discountedPrice: json["discounted_price"],
        active: json["active"],
        image: json["image"],
        categoryId: json["category_id"],
        shopId: json["shop_id"],
        subProducts: List<dynamic>.from(json["sub_products"].map((x) => x)),
        unformattedPrice: json["unformatted_price"],
        unformattedDiscountedPrice: json["unformatted_discounted_price"],
        autodesc: json["autodesc"],
        options: json["options"],
        variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
        extras: json["extras"] == null ? null : List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "row": row,
        "name": name,
        "shortdesc": shortdesc == null ? null : shortdesc,
        "price": price,
        "discounted_price": discountedPrice,
        "active": active,
        "image": image,
        "category_id": categoryId,
        "shop_id": shopId,
        "sub_products": List<dynamic>.from(subProducts.map((x) => x)),
        "unformatted_price": unformattedPrice,
        "unformatted_discounted_price": unformattedDiscountedPrice,
        "autodesc": autodesc,
        "options": options,
        "variants": List<dynamic>.from(variants.map((x) => x.toJson())),
        "extras": extras == null ? null : List<dynamic>.from(extras!.map((x) => x.toJson())),
      };
}

class ProductModel {
  String id;

  String name;
  dynamic shortdesc;
  String image;
  String icon;
  List<Product> products;
  ProductModel({
    required this.id,
    required this.name,
    required this.shortdesc,
    required this.image,
    required this.icon,
    required this.products,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        shortdesc: json["shortdesc"],
        image: json["image"],
        icon: json["icon"] != null ? json["icon"] : '',
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "shortdesc": shortdesc,
        "image": image,
        "icon": icon,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Variant {
  String id;

  String productId;
  String name;
  String price;
  String discountedPrice;
  String shopId;
  String unformattedPrice;
  String unformattedDiscountedPrice;
  List<Extra> extras;
  Variant({
    required this.id,
    required this.productId,
    required this.name,
    required this.price,
    required this.discountedPrice,
    required this.shopId,
    required this.unformattedPrice,
    required this.unformattedDiscountedPrice,
    required this.extras,
  });

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
        price: json["price"],
        discountedPrice: json["discounted_price"],
        shopId: json["shop_id"],
        unformattedPrice: json["unformatted_price"],
        unformattedDiscountedPrice: json["unformatted_discounted_price"],
        extras: List<Extra>.from(json["extras"].map((x) => Extra.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
        "price": price,
        "discounted_price": discountedPrice,
        "shop_id": shopId,
        "unformatted_price": unformattedPrice,
        "unformatted_discounted_price": unformattedDiscountedPrice,
        "extras": List<dynamic>.from(extras.map((x) => x.toJson())),
      };
}
