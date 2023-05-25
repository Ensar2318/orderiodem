import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/newWidgets/newBasketItem.dart';
import 'package:zwerge/screens/checkout.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/utils/helper.dart';

import '../screens/home.dart';
import '../widgets/buttonGlobal.dart';

class mySlideUpPanel extends GetView<ProductController> {
  const mySlideUpPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    UserController userController = Get.find<UserController>();
    final box = GetStorage();
    Color buttonColor = HexColor.fromHex(box.read('buttonColor'));
    var checkoutValid = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Add Your Code here.
      checkoutValid = controller.homeCheckoutControl();
    });
    _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

    TextStyle marketText =
        TextStyle(color: Color(0xff7c7c7c), fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 16.0);
    TextStyle marketPriceText =
        TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 18.0);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Color(0x29000000)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Warenkorb
                    Text("Warenkorb",
                        style: const TextStyle(
                            color: MyColors.darkText,
                            fontWeight: FontWeight.w900,
                            fontFamily: "Avenir",
                            fontStyle: FontStyle.normal,
                            fontSize: 18.0)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  controller.pc.animatePanelToPosition(0.0);
                  Future.delayed(Duration(milliseconds: 500), () {
                    controller.update();
                  });
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                      margin: EdgeInsets.only(right: 5, top: 5),
                      height: 30,
                      width: 30,
                      child: Icon(
                        Icons.close_rounded,
                        color: MyColors.white,
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(19)), color: MyColors.softGrey)),
                ),
              ),
            ],
          ),
          // controller.cartItems!.products
          Expanded(
            child: controller.cartItems != null
                ? controller.cartItems!.products.isNotEmpty
                    ? SingleChildScrollView(
                        child: Wrap(
                            direction: Axis.vertical,
                            children: controller.cartItems!.products
                                .map((item) => basketItem(
                                      product: item,
                                      cartkey: item.cartId,
                                    ))
                                .toList()),
                      )
                    : itemNoCarts()
                : itemNoCarts(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: Color(0x29000000)),
                bottom: BorderSide(width: 1, color: Color(0x29000000)),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Zwischensumme
                    Text("Zwischensumme", style: marketText),
                    // 0,00 €
                    Text(controller.cartItems?.total != null ? "${(controller.cartItems?.amount.toString().replaceAll(".", ","))} €" : "0,00 €",
                        style: marketPriceText)
                  ],
                ),
                if (controller.cartItems != null && controller.cartItems!.discountamount != "0.00") SizedBox(height: 10),
                if (controller.cartItems != null && controller.cartItems!.discountamount != "0.00")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Zwischensumme
                      Text("Aktionsrabatt", style: marketText),
                      // 0,00 €
                      Text(
                          controller.cartItems?.amount != null
                              ? "-${controller.cartItems?.discountamount.toString().replaceAll(".", ",")} €"
                              : "0,00 €",
                          style: marketPriceText)
                    ],
                  ),
                if (controller.isCouponApplied) SizedBox(height: 10),
                if (controller.isCouponApplied)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Zwischensumme
                      Text("Gutscheinrabatt", style: marketText),
                      // 0,00 €
                      Text(controller.cartItems?.amount != null ? "-${controller.cartItems?.giftamount} €" : "0,00 €", style: marketPriceText)
                    ],
                  ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Zwischensumme
                    Text("Lieferkosten", style: marketText),
                    // 0,00 €
                    Text(
                        userController.selectedArea != null
                            ? userController.selectedArea!.deliveryAmount.toString() == "0"
                                ? "0,00 €"
                                : userController.selectedArea!.deliveryAmount.toString().replaceAll(".", ",") + "€"
                            : "0" + " €",
                        style: marketPriceText)
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Zwischensumme
                    Text("Gesamt", style: marketText),
                    // 0,00 €
                    Text(
                        controller.cartItems?.total != null && userController.selectedArea != null
                            ? priceFormat((double.parse(controller.cartItems!.totalUnformatted) +
                                    double.parse(userController.selectedArea!.deliveryAmount.toString()))) +
                                " €"
                            : "0,00 €",
                        style: marketPriceText)
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Wählen Sie bitte eine Lieferadresse aus, damit Sie fortfahren können.
                Text(
                    controller.cartItems != null
                        ? userController.selectedArea != null
                            ? (double.parse(userController.selectedArea!.minAmount.replaceAll(",", ".")) <=
                                    double.parse(controller.cartItems!.amount.replaceAll(",", ".")))
                                ? "Sie haben den Mindestbestellwert von ${userController.selectedArea!.minAmount} € erreicht und können jetzt fortfahren."
                                : "Leider können Sie noch nicht bestellen. Wir liefern erst ab einem Mindestbestellwert von ${userController.selectedArea!.minAmount} € (exkl. Lieferkosten)."
                            : "Wählen Sie bitte eine Lieferadresse aus, damit Sie fortfahren können."
                        : "",
                    style: const TextStyle(
                        color: const Color(0xff7c7c7c),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Avenir",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                    textAlign: TextAlign.center),
                SizedBox(height: 25),

                GestureDetector(
                  onTap: () async {
                    if (checkoutValid) {
                      if (!_isThereCurrentDialogShowing(context)) {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                                contentPadding: EdgeInsets.zero,
                                content: Container(
                                  width: screenW(0.9, context),
                                  padding: const EdgeInsets.all(20),
                                  height: screenH(0.3, context),
                                  child: Column(
                                    children: <Widget>[
                                      Center(
                                        child: Container(
                                          //  margin: const EdgeInsets.all(10),
                                          width: 50,
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(25)),
                                              boxShadow: [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
                                              color: Color(0xffdbdbdb)),
                                          child: const Center(
                                            child: Text("❗️",
                                                style: TextStyle(
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: "Gilroy",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 28.0),
                                                textAlign: TextAlign.left),
                                          ),
                                        ),
                                      ), // Hello there
                                      const SizedBox(height: 10),
                                      const Text("Fehler",
                                          style: TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Gilroy",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 24.0),
                                          textAlign: TextAlign.left),
                                      const SizedBox(height: 10),
                                      Text(
                                          "Leider können Sie noch nicht bestellen. Wir liefern erst ab einem Mindestbestellwert von ${userController.selectedArea!.minAmount} € (exkl. Lieferkosten).",
                                          style: TextStyle(
                                            color: Color(0xff767676),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Gilroy",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 16.0,
                                          ),
                                          textAlign: TextAlign.center),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                      // Get.snackbar('Warnung', 'Bitte Produkt in den Warenkorb legen.');
                    } else {
                      Get.to(Checkout());
                    }
                  },
                  child: buttonGlobal(
                    text: "Bestellen",
                    textColor: checkoutValid ? Color(0xff868686) : MyColors.white,
                    color: checkoutValid ? Color(0xfff0f0f0) : buttonColor,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
