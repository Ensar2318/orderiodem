import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Constants.dart';
import 'package:zwerge/widgets/buttonGlobal.dart';

import '../utils/Colors.dart';

class basketItem extends GetView<ProductController> {
  final product;
  final cartkey;
  TextEditingController noteController = TextEditingController();
  Timer _timer = Timer(Duration(seconds: 3), () => {});
  basketItem({
    Key? key,
    required this.product,
    required this.cartkey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    ProductController controller = Get.find<ProductController>();
    noteController.text = product.note;
    final FocusNode _focusNode = FocusNode();
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    Color secondaryColorOpacity = HexColor.fromHex(box.read('secondaryColorOpacity'));
    Color buttonColor = HexColor.fromHex(box.read('buttonColor'));

    noteController.addListener(() {
      product.note = noteController.text;
    });
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: Color(0x29000000)),
        ),
      ),
      padding: EdgeInsets.only(top: 30, bottom: 30, left: 20, right: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // 2x
              Container(
                margin: EdgeInsets.only(right: 15),
                child: Text(product.quantity.toString() + "x",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 16.0)),
              ),
              // Pizza Margherita -  Klein (24cm)
              Container(
                width: Get.width * 0.34,
                margin: EdgeInsets.only(right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name,
                        style: const TextStyle(
                            color: MyColors.darkText, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0),
                        textAlign: TextAlign.left),
                    SizedBox(
                      height: 2,
                    ),
                    Text(product.extras != "" ? 'mit ' + product.extras : '',
                        style: const TextStyle(
                            color: MyColors.softText, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 12.0),
                        textAlign: TextAlign.left),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      (product.total) + " €",
                      style: const TextStyle(
                          color: MyColors.watermelon, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0),
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 10,
                children: [
                  GestureDetector(
                    onTap: () => controller.removeFromCart(product.id),
                    child: ImageIcon(
                      AssetImage("assets/deletetrash.png"),
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => {
                      if (controller.activeProductCardNote == product.id)
                        {controller.activeProductCardNote = 999}
                      else
                        {controller.activeProductCardNote = product.id},
                      controller.update(),
                    },
                    child: ImageIcon(
                      AssetImage("assets/editpencil.png"),
                      color: primaryColor,
                      size: 24,
                    ),
                  ),
                ],
              ),
              Spacer(),

              // Path 3149
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () async => {
                          if (controller.getQuantity(product.id) > 1)
                            {
                              if (controller.buttonIsLoading)
                                {controller.buttonIsLoading = false, await controller.updateCart(cartkey, controller.getQuantity(product.id) - 1)}
                              //controller.updateCart(product.id, controller.getQuantity(product.id) - 1)
                            }
                          else
                            {controller.removeFromCart(product.id)}
                        },
                        child: Icon(
                          Icons.remove,
                          color: MyColors.white,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: // 5
                            Text(product.quantity.toString(),
                                style: const TextStyle(
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Avenir",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 17.0),
                                textAlign: TextAlign.center),
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (controller.buttonIsLoading) {
                            controller.buttonIsLoading = false;
                            int qtyNew = product.quantity + 1;
                            await controller.updateCart(cartkey, qtyNew);
                          }
                        },
                        child: Icon(
                          Icons.add,
                          color: MyColors.white,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  width: 80,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      boxShadow: [BoxShadow(color: secondaryColorOpacity, offset: Offset(0, 3), blurRadius: 16, spreadRadius: 0)],
                      color: buttonColor))
            ],
          ),
          if (controller.activeProductCardNote == product.id)
            SizedBox(
              height: 30,
            ),
          Visibility(
              visible: controller.activeProductCardNote == product.id ? true : false,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: MyColors.softWhite,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              style: inputText,
                              obscuringCharacter: "*",
                              maxLines: 3,
                              controller: noteController,
                              decoration: InputDecoration(
                                hintText: "notiz",
                                hintStyle: inputHintText,
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (noteController.text.length > 0) {
                          await controller.editProductNote(product.cartId.toString(), noteController.text);
                        }
                      },
                      child: buttonGlobal(
                        text: "Speichern",
                        mt: 20,
                      ),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
