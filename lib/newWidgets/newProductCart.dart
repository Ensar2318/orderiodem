import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/models/productModel.dart';
import 'package:zwerge/screens/productDetail.dart';

import '../utils/Colors.dart';

class newProductCart extends GetView<ProductController> {
  final Product data;
  final int index;
  final List<Product>? other;
  final String catname;
  newProductCart({
    Key? key,
    required this.data,
    required this.index,
    this.other,
    required this.catname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));

    var variantnames = "";
    for (var element in data.variants) {
      variantnames += element.name + ", ";
    }

    return GestureDetector(
      onTap: () {
        print("add to cart");

        if (data.variants.length > 0 || data.options.length > 0) {
          Get.to(ProductDetail(data, catname, other, index));
        } else {
          if (controller.buttonIsLoading) {
            controller.buttonIsLoading = false;
            controller.addToCart(data, null, false);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.01),
        margin: EdgeInsets.only(left: Get.width * 0.03, top: Get.width * 0.03, right: Get.width * 0.03),
        width: Get.width,
        height: Get.width * 0.67,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(19)),
            border: Border.all(color: const Color(0xfff7f6f6), width: 1),
            boxShadow: [BoxShadow(color: const Color(0x17000000), offset: Offset(0, 0), blurRadius: 15, spreadRadius: 0)],
            color: const Color(0xffffffff)),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Container(
                    width: Get.width * 0.56,
                    child: Text(data.name!,
                        style: const TextStyle(
                            color: MyColors.darkText, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 16.0),
                        textAlign: TextAlign.left),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    onTap: () async {
                      await controller.getProductInfo(int.parse(data.id.toString()));
                      Get.bottomSheet(
                        Container(
                          height: Get.height * 0.585,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20, right: 12, top: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Produktinfo
                                    Text("Produktinfo",
                                        style: const TextStyle(
                                            color: MyColors.darkText,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: "Avenir",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18.0),
                                        textAlign: TextAlign.left),
                                    // Ellipse 115
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Container(
                                          child: Icon(
                                            Icons.close,
                                            color: MyColors.darkText,
                                          ),
                                          width: 32,
                                          height: 32,
                                          decoration:
                                              BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(32)), color: const Color(0xfff5f5f5))),
                                    )
                                  ],
                                ),
                              )
                              // Path 4237
                              ,
                              Container(height: 0, decoration: BoxDecoration(border: Border.all(color: const Color(0xfff5f5f5), width: 1))),
                              Container(
                                margin: EdgeInsets.all(12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    // Rectangle 677
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9)), color: const Color(0xfffafafa)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Allergene
                                          Text("Allergene",
                                              style: const TextStyle(
                                                  color: MyColors.darkText,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: "Avenir",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Antioxidationsmittel, geschwarzt
                                          if (controller.productInfo != null)
                                            Row(
                                              children: [
                                                for (var data in controller.productInfo.allergens)
                                                  Text(data.toString() + ", ",
                                                      style: const TextStyle(
                                                          color: MyColors.darkText,
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: "Avenir",
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: 16.0)),
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9)), color: const Color(0xfffafafa)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Allergene
                                          Text("Zusatzstoffe",
                                              style: const TextStyle(
                                                  color: MyColors.darkText,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: "Avenir",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0)),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          // Antioxidationsmittel, geschwarzt
                                          if (controller.productInfo != null)
                                            Row(
                                              children: [
                                                for (var data in controller.productInfo.additives)
                                                  Text(data.toString() + ", ",
                                                      style: const TextStyle(
                                                          color: MyColors.darkText,
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: "Avenir",
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: 16.0)),
                                              ],
                                            )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9)), color: const Color(0xfffff2cf)),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Antioxidationsmittel, geschwarzt
                                          // Wenden Sie sich telefonisch (02361 849 45 74) an uns, wenn Allergien und Intoleranzen vorliegen und
                                          Text(
                                              "Wenden Sie sich telefonisch (02361 849 45 74)an uns, wenn Allergien und Intoleranzen vorliegen und Sie Fragen zu bestimmten Speisen auf der Karte Haben.",
                                              style: const TextStyle(
                                                  color: const Color(0xff846315),
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: "Avenir",
                                                  fontStyle: FontStyle.normal,
                                                  height: 1.4,
                                                  fontSize: 14.0))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        isScrollControlled: true,
                      );
                    },
                    child: Text("Produktinfo",
                        style: const TextStyle(
                            color: const Color(0xff999999),
                            fontWeight: FontWeight.w900,
                            fontFamily: "Avenir",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.left),
                  )
                ],
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(18)), color: primaryColor),
                child: Center(
                  child: Text(
                    '+',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  /*   Text("€",
                      style: const TextStyle(
                          color: MyColors.watermelon, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0),
                      textAlign: TextAlign.left),
                  SizedBox(width: 5), */
                  Text(data.price.toString(),
                      style: const TextStyle(
                          color: MyColors.darkText, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 22.0),
                      textAlign: TextAlign.left)
                ],
              ),
              data.image != null
                  ? CachedNetworkImage(
                      width: Get.width * 0.3,
                      imageUrl: 'https://cdn.orderio.de/images/products/' + data.image!,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) {
                        // return Image.network('https://cdn.orderio.de/images/products/placeholder.jpg');
                        return Container();
                      },
                      fit: BoxFit.contain,
                    )
                  : Container(),
            ],
          ),
          Container(width: 349, height: 0, decoration: BoxDecoration(border: Border.all(color: const Color(0xfff4f4f4), width: 1))),
          Text(data.shortdesc != null ? data.shortdesc! : "",
              style: const TextStyle(
                  color: MyColors.darkText, fontWeight: FontWeight.w500, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0),
              textAlign: TextAlign.left),
          if (variantnames != "")
            Text("Wahl aus: " + variantnames,
                style: const TextStyle(
                    color: MyColors.darkText, fontWeight: FontWeight.w400, fontFamily: "ZurichCnBT", fontStyle: FontStyle.normal, fontSize: 14.0),
                textAlign: TextAlign.left)
        ]),
      ),
    );
  }
}
