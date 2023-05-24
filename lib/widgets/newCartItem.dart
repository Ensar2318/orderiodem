import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Colors.dart';

class newCartItem extends GetView<ProductController> {
  final product;
  final cartkey;

  const newCartItem({Key? key, this.product, required this.cartkey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return GetBuilder<ProductController>(
        builder: (controller) => Container(
            margin: const EdgeInsets.only(bottom: 20),
            alignment: Alignment.bottomCenter,
            width: Get.width * 0.8,
            height: 48,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
                color: MyColors.pale),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                      width: Get.width * 0.27,
                      margin: const EdgeInsets.all(12),
                      child: product.image != null
                          ? Image.network('https://cdn.orderio.de/images/products/' + product.image)
                          : Image.network(
                              'https://cdn.orderio.de/images/products/placeholder.jpg',
                            )),
                ),
                Container(
                  width: Get.width * 0.5,
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 125,
                        child: Text(product.name,
                            style: const TextStyle(
                                color: Color(0xff040413),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Gilroy",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.0),
                            textAlign: TextAlign.left),
                      ), // Snacks
                      const Text('asd',
                          style: TextStyle(
                              color: Color(0xff767676),
                              fontWeight: FontWeight.w500,
                              fontFamily: "Gilroy",
                              fontStyle: FontStyle.normal,
                              fontSize: 14.0),
                          textAlign: TextAlign.left),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () {
                                  if (controller.getQuantity(product.id) > 1) {
                                    controller.updateCart(cartkey, controller.getQuantity(product.id) - 1);
                                  } else {
                                    controller.removeFromCart(product.id);
                                  }
                                },
                                child: Container(
                                    padding: const EdgeInsets.only(left: 8, right: 8),
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(100)),
                                      border: Border.all(width: 1, color: MyColors.brownishPink),
                                    ),
                                    child: Image.asset('assets/deleteIcon.png', width: 30)),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 15, right: 15),
                                child: Text(product.quantity.toString(),
                                    style: const TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Gilroy",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 22.0),
                                    textAlign: TextAlign.left),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    int qtyNew = product.quantity + 1;
                                    controller.updateCart(cartkey, qtyNew);
                                  },
                                  child: Image.asset('assets/addCart.png', width: 40)),
                              const Spacer(),
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    style: const TextStyle(
                                        color: Color(0xff040413),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Gilroy",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0),
                                    text: "\$  " + product.price.toString())
                              ])),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )));
  }
}
