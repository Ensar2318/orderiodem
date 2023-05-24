import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/screens/checkout.dart';
import 'package:zwerge/widgets/myButton.dart';

class CheckoutBottom extends GetView<ProductController> {
  final String total;
  final String label;
  final int type;
  CheckoutBottom({required this.total, required this.label, required this.type}) : super();

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return Container(
        color: Colors.black,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.699999988079071,
                  child: Text("Total",
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Gilroy",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0),
                      textAlign: TextAlign.left),
                ),
                SizedBox(
                  height: 3,
                ),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w600,
                          fontFamily: "Gilroy",
                          fontStyle: FontStyle.normal,
                          fontSize: 20.0),
                      text: "\$  " + total.toString())
                ])),
              ],
            ),
            GestureDetector(
                onTap: () async {
                  if (type == 1) {
                    if (total == '0.00') {
                      Get.snackbar('Warnung', 'Bitte Produkt in den Warenkorb legen.');
                    } else {
                      Get.to(Checkout());
                    }
                  } else if (type == 2) {
                    /* controller.initPaymentSheet();
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      controller.confirmPayment();
                    }); */
                  }
                },
                child: MyButton(label: label, width: Get.width * 0.4))
          ],
        ));
  }
}
