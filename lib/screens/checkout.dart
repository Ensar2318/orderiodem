import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/screens/addresses.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/utils/Constants.dart';
import 'package:zwerge/utils/helper.dart';
import 'package:zwerge/widgets/buttonGlobal.dart';
import 'package:zwerge/widgets/inputGlobal.dart';
import 'package:zwerge/widgets/myAddressSlideUpCollapsed.dart';
import 'package:zwerge/widgets/myAddressSlideUpPane.dart';

import 'Paymentt.dart';

class addresItem extends GetView<ProductController> {
  final String title;
  final String phone;
  final String adres;
  final int id;
  final data;

  const addresItem({
    Key? key,
    required this.title,
    required this.phone,
    required this.adres,
    required this.id,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));

    return GestureDetector(
      onTap: () {
        UserController userController = Get.find<UserController>();
        controller.selectedAddressId = id;
        userController.selectedAddress = data;
        userController.selectedArea = userController.areas!.where((element) => element.id == userController.selectedAddress!.areaId).first;
        controller.update();
        userController.update();
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.only(left: 0, top: 20, bottom: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    children: [
                      Radio(
                          activeColor: primaryColor,
                          value: id,
                          groupValue: controller.selectedAddressId,
                          onChanged: (newValue) {
                            controller.selectedAddressId = newValue;
                            controller.update();
                          }),
                      // Ev
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title,
                              style: TextStyle(
                                  color: MyColors.charcoal,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "Avenir",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 15.0)),
                          SizedBox(
                            height: 5,
                          ),
                          // (319) 555-0115
                          Text(phone,
                              style: TextStyle(
                                  color: const Color(0xffacacac),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Avenir",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0)),
                          // 1749 Wheeler Ridge
                          SizedBox(
                            height: 5,
                          ),
                          Text(adres,
                              style: const TextStyle(
                                  color: const Color(0xffacacac),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Avenir",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 14.0)),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: (() => {
                      Get.to(Addresses()),
                    }),
                child: Icon(
                  Icons.edit_outlined,
                  color: primaryColor,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
              border: Border.all(color: controller.selectedAddressId == id ? primaryColor : Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(18)),
              boxShadow: [BoxShadow(color: const Color(0xffe6e6e6), offset: Offset(0, 15), blurRadius: 30, spreadRadius: 0)],
              gradient: LinearGradient(
                  begin: Alignment(0.08409727364778519, 0.43446260690689087),
                  end: Alignment(0.46691903471946716, 0.45219510793685913),
                  colors: [const Color(0xffffffff), const Color(0xffffffff)]))),
    );
  }
}

class basketItems extends StatelessWidget {
  final product;
  final controller;
  final cartkey;
  const basketItems({
    Key? key,
    required this.product,
    required this.controller,
    required this.cartkey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    width: Get.width * 0.35,
                    child: product.image != null
                        ? CachedNetworkImage(
                            width: Get.width * 0.3,
                            imageUrl: 'https://cdn.orderio.de/images/products/' + product.image!,
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) {
                              return Image.network('https://cdn.orderio.de/images/products/placeholder.jpg');
                            },
                            fit: BoxFit.contain,
                          )
                        : CachedNetworkImage(
                            width: Get.width * 0.3,
                            imageUrl: 'https://cdn.orderio.de/images/products/placeholder.jpg',
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) {
                              return Image.network('https://cdn.orderio.de/images/products/placeholder.jpg');
                            },
                            fit: BoxFit.contain,
                          )),
                Expanded(
                    child: Wrap(
                  spacing: 5,
                  direction: Axis.vertical,
                  children: [
                    // Special Hamburger
                    Container(
                      width: Get.width * 0.5,
                      child: Text(
                        product?.name ?? "Special Hamburger",
                        style: const TextStyle(
                            color: MyColors.charcoal, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 15.0),
                      ),
                    ),

                    // Burgerking
                    Container(
                      width: Get.width * 0.5,
                      child: Text(product?.extras,
                          style: const TextStyle(
                              color: const Color(0xffc1c1c1),
                              fontWeight: FontWeight.w500,
                              fontFamily: "Avenir",
                              fontStyle: FontStyle.normal,
                              fontSize: 11.0)),
                    ),
                    // 9.54
                    Text(product?.total.replaceAll(".", ",") + " €",
                        style: const TextStyle(
                            color: const Color(0xff22292b),
                            fontWeight: FontWeight.w900,
                            fontFamily: "Avenir",
                            fontStyle: FontStyle.normal,
                            fontSize: 22.0))
                  ],
                ))
              ],
            ),
            Positioned(
              bottom: 12,
              right: 12,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => {
                          if (controller.getQuantity(product.id) > 1)
                            {controller.updateCart(cartkey, controller.getQuantity(product.id) - 1)}
                          else
                            {controller.removeFromCart(product.id)}
                        },
                        child: Icon(
                          Icons.remove,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: // 5
                            Text(product.quantity.toString(),
                                style: const TextStyle(
                                    color: MyColors.charcoal,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Avenir",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 17.0),
                                textAlign: TextAlign.center),
                      ),
                      GestureDetector(
                        onTap: () {
                          int qtyNew = product.quantity + 1;
                          controller.updateCart(cartkey, qtyNew);
                        },
                        child: Icon(
                          Icons.add,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                  width: 80,
                  height: 32,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      boxShadow: [BoxShadow(color: const Color(0x1f000000), offset: Offset(0, 3), blurRadius: 6, spreadRadius: 0)],
                      color: const Color(0xffffffff))),
            )
          ],
        ),
        height: 115,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(23)),
            boxShadow: [BoxShadow(color: const Color(0x89cecece), offset: Offset(0, 1), blurRadius: 6, spreadRadius: 0)],
            gradient: LinearGradient(
                begin: Alignment(0.08409727364778519, 0.43446260690689087),
                end: Alignment(0.46691903471946716, 0.45219510793685913),
                colors: [const Color(0xffffffff), const Color(0xffffffff)])));
  }
}

class Checkout extends GetView<ProductController> {
  const Checkout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    UserController userController = Get.find<UserController>();
    final box = GetStorage();

    List<DropdownMenuItem<String>> deliveryItems = [
      DropdownMenuItem<String>(
        value: "current",
        child: Text("Schnellstmöglich"),
      )
    ];

    controller.deliveryTimes.forEach((delivery) {
      deliveryItems.add(DropdownMenuItem<String>(
        enabled: false,
        value: delivery.date.toString(),
        child: IgnorePointer(child: Text(delivery.date.toString(), style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold))),
      ));
      if (delivery.times.length > 0) {
        delivery.times.forEach((time) {
          deliveryItems.add(DropdownMenuItem<String>(
            value: time.fulltime.toString(),
            child: Text(time.time.toString()),
          ));
        });
      }
    });

    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    controller.getCartList();
    return Scaffold(
      backgroundColor: Colors.black,
      body: GetBuilder<ProductController>(builder: (controller) {
        if (controller.isLoading) {
          return Container(
              child: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          ));
        } else {
          return SlidingUpPanel(
            controller: controller.pcAddress,
            color: Colors.transparent,
            renderPanelSheet: false,
            panel: controller.slideUpAddressVisibilty == true ? myAddressSlideUpPanel() : Container(),
            collapsed: controller.slideUpAddressVisibilty == true ? myAddressSlideUpCollapsed() : Container(),
            body: Container(
              color: Colors.black,
              child: SafeArea(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      topSideWidget(
                        count: controller.totalItems,
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Container(
                          width: Get.width,
                          color: Colors.white,
                          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          padding: EdgeInsets.only(bottom: 100),
                          child: Wrap(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Sepetteki Ürünler
                                  Text(
                                    "Produkte im Warenkorb",
                                    style: const TextStyle(
                                        color: MyColors.charcoal,
                                        fontWeight: FontWeight.w900,
                                        fontFamily: "Avenir",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Rectangle 19
                                  controller.cartItems != null
                                      ? Container(
                                          child: Column(children: [
                                            for (var i = 0; i < controller.cartItems!.products.length; i++)
                                              basketItems(controller: controller, product: controller.cartItems!.products[i], cartkey: i),
                                          ]),
                                        )
                                      : Container(),

                                  SizedBox(
                                    height: 20,
                                  ),

                                  // Teslimat Adresi
                                  if (userController.isLogin == true && false)
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Lieferadresse",
                                            style: const TextStyle(
                                                color: MyColors.charcoal,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "Avenir",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 18.0)),
                                        // Yeni Adres Ekle
                                        GestureDetector(
                                          onTap: () => Get.to(Addresses()),
                                          child: Text("Neue Adresse hinzufügen",
                                              style: TextStyle(
                                                  color: primaryColor,
                                                  fontWeight: FontWeight.w900,
                                                  fontFamily: "Avenir",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13.0),
                                              textAlign: TextAlign.left),
                                        )
                                      ],
                                    ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  userController.isLogin == true
                                      ? false
                                          ? GetBuilder<UserController>(builder: (userController) {
                                              return userController.addresses.length != 0
                                                  ? Container(
                                                      child: Column(
                                                      children: [
                                                        for (var i in userController.addresses)
                                                          addresItem(
                                                            title: i.label,
                                                            phone: i.area,
                                                            adres: i.address,
                                                            id: int.parse(i.id),
                                                            data: i,
                                                          )
                                                      ],
                                                    ))
                                                  : Container();
                                            })
                                          : Column(
                                              children: [
                                                if (controller.addressText != 'Abholung')
                                                  inputGlobal(
                                                    searchController: controller.addressController,
                                                    readonly: box.read('coordinateActive') != "1" ? false : true,
                                                    hint: "Adresse*",
                                                    label: "Adresse",
                                                    radius: 4,
                                                    area: "checkout",
                                                  ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                inputGlobal(
                                                  hint: "Name*",
                                                  label: "Name*",
                                                  radius: 4,
                                                  area: "checkout",
                                                  searchController: controller.nameController,
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                inputGlobal(
                                                    hint: "E-Mail-Adresse*",
                                                    label: "E-Mail-Adresse*",
                                                    radius: 4,
                                                    area: "checkout",
                                                    searchController: controller.emailController),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                inputGlobal(
                                                    hint: "Telefonnummer*",
                                                    label: "Telefonnummer*",
                                                    radius: 4,
                                                    area: "checkout",
                                                    numberType: true,
                                                    searchController: controller.phoneController),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                inputGlobal(
                                                    hint: "Name der Firma",
                                                    label: "Name der Firma",
                                                    radius: 4,
                                                    area: "checkout",
                                                    searchController: controller.companyController),
                                              ],
                                            )
                                      : Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            if (controller.addressText != 'Abholung')
                                              Text("Wohin soll Ihre Bestellung geliefert werden?",
                                                  style: const TextStyle(
                                                      color: MyColors.charcoal,
                                                      fontWeight: FontWeight.w900,
                                                      fontFamily: "Avenir",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 18.0)),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            controller.addressText != 'Abholung'
                                                ? Column(
                                                    children: [
                                                      if (controller.addressText != 'Abholung')
                                                        inputGlobal(
                                                          searchController: controller.addressController,
                                                          readonly: box.read('coordinateActive') != "1" ? false : true,
                                                          hint: "Adresse*",
                                                          label: "Adresse",
                                                          radius: 4,
                                                          area: "checkout",
                                                        ), //Bitte gib deine Hausnummer an
                                                      false && box.read('coordinateActive') == "1"
                                                          ? inputGlobal(
                                                              searchController: controller.addressHomeNoController,
                                                              hint: "Bitte gib deine Hausnummer an*",
                                                              label: "Bitte gib deine Hausnummer an",
                                                              radius: 4,
                                                              area: "checkout",
                                                            )
                                                          : Container(),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                              children: [
                                                                Text(
                                                                  "Postleitzahl",
                                                                  style: inputLabelText,
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                                                  decoration: BoxDecoration(
                                                                    color: MyColors.softWhite,
                                                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                                                  ),
                                                                  child: Text(
                                                                    userController.selectedArea!.postal.toString(),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                                              children: [
                                                                Text(
                                                                  "Stadt",
                                                                  style: inputLabelText,
                                                                ),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                Container(
                                                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                                                                  decoration: BoxDecoration(
                                                                    color: MyColors.softWhite,
                                                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                                                  ),
                                                                  child: Text(userController.selectedArea!.city.toString()),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                    ],
                                                  )
                                                : Container(),
                                            Text("Wie können wir dich erreichen?",
                                                style: const TextStyle(
                                                    color: MyColors.charcoal,
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 18.0)),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            inputGlobal(
                                              hint: "Name*",
                                              label: "Name*",
                                              radius: 4,
                                              area: "checkout",
                                              searchController: controller.nameController,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            inputGlobal(
                                                hint: "E-Mail-Adresse*",
                                                label: "E-Mail-Adresse*",
                                                radius: 4,
                                                area: "checkout",
                                                searchController: controller.emailController),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            inputGlobal(
                                                hint: "Telefonnummer*",
                                                label: "Telefonnummer*",
                                                radius: 4,
                                                area: "checkout",
                                                numberType: true,
                                                searchController: controller.phoneController),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            inputGlobal(
                                                hint: "Name der Firma",
                                                label: "Name der Firma",
                                                radius: 4,
                                                area: "checkout",
                                                searchController: controller.companyController),
                                          ],
                                        ),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  inputGlobal(
                                    height: 130,
                                    hint: "Notiz",
                                    label: "Notiz",
                                    radius: 4,
                                    searchController: controller.noteController,
                                    maxLines: 8,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Gutschein",
                                          style: const TextStyle(
                                              color: MyColors.charcoal,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Avenir",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18.0)),
                                      GestureDetector(
                                        onTap: () async {
                                          if (!controller.isCouponApplied) {
                                            await controller.discountCheck(controller.couponController!.text.toString());
                                          } else {
                                            await controller.discountRemove();
                                          }
                                        },
                                        child: Text(!controller.isCouponApplied ? "Hinzufügen" : "Entfernen",
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "Avenir",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 13.0),
                                            textAlign: TextAlign.left),
                                      )
                                      // Yeni Adres Ekle
                                    ],
                                  ),
                                  !controller.isCouponApplied
                                      ? inputGlobal(
                                          hint: "Gutscheincode",
                                          label: "",
                                          searchController: controller.couponController,
                                          radius: 4,
                                          mt: 14,
                                        )
                                      : inputGlobal(
                                          hint: "Sie haben " + controller.couponModal!.giftamount.toString() + " € Rabatt erhalten.",
                                          label: "",
                                          readonly: true,
                                          radius: 4,
                                          mt: 14,
                                        ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text("Wählen Sie eine Lieferzeit",
                                      style: const TextStyle(
                                          color: MyColors.charcoal,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "Avenir",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18.0)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  true
                                      ? Container(
                                          margin: const EdgeInsets.only(top: 5, right: 2, left: 2),
                                          width: Get.width * 0.9,
                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              boxShadow: <BoxShadow>[
                                                BoxShadow(color: Colors.black54, blurRadius: 4.0, offset: Offset(0.0, 1.2)),
                                              ],
                                              color: Colors.white),
                                          child: DropdownButton<String>(
                                            value: controller.selectedDeliveryTime,
                                            hint: const Text('Wählen Sie eine Lieferzeit',
                                                style: TextStyle(
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Gilroy",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.left),
                                            onChanged: (String? newValue) {
                                              controller.selectedDeliveryTime = newValue!;
                                              controller.update();
                                            },
                                            items: deliveryItems,
                                            // add extra sugar..
                                            icon: Image.asset(
                                              'assets/downArrow.png',
                                              width: 15,
                                            ),
                                            isExpanded: true,
                                            iconSize: 42,
                                            underline: const SizedBox(),
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 20,
                                  ),

                                  Text("Wie möchten Sie bezahlen?",
                                      style: const TextStyle(
                                          color: MyColors.charcoal,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "Avenir",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18.0)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Wrap(
                                    spacing: 10,
                                    children: [
                                      pricingCard(
                                        id: 0,
                                      ),
                                      pricingCard(
                                        id: 1,
                                        title: "Paypal",
                                        image: "assets/paypal.png",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                      checkoutDetailWidget()
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      }),
    );
  }

  Row newCalculationRow(String label, String preValue, String value, Color color) {
    return Row(
      children: [
        // Total
        Opacity(
          opacity: 0.699999988079071,
          child: Text(label,
              style: const TextStyle(
                  color: const Color(0xff040413), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 16.0),
              textAlign: TextAlign.left),
        ),
        Spacer(),
        RichText(
            text: TextSpan(children: [
          TextSpan(
              style: TextStyle(color: color, fontWeight: FontWeight.w400, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 18.0),
              text: preValue),
          TextSpan(
              style: TextStyle(color: color, fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 18.0),
              text: value)
        ]))
      ],
    );
  }

  GestureDetector newTip(String label, bool selected, int price) {
    return GestureDetector(
      onTap: (() {
        controller.selectedTip = price;

        controller.update();
      }),
      child: Container(
          margin: const EdgeInsets.all(10),
          padding: EdgeInsets.only(top: 8, bottom: 8, left: selected ? 10 : 15, right: selected ? 10 : 15),
          alignment: Alignment.bottomCenter,
          height: 35,
          decoration: BoxDecoration(
            color: selected ? Colors.black : Colors.white,
            border: Border.all(color: const Color(0xffdbdbdb), width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5)),
          ),
          child: // None
              Text(label,
                  style: TextStyle(
                      color: selected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Gilroy",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0),
                  textAlign: TextAlign.left)),
    );
  }
}

class checkoutDetailWidget extends GetView<ProductController> {
  const checkoutDetailWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    UserController userController = Get.find<UserController>();
    final box = GetStorage();
    Color buttonColor = HexColor.fromHex(box.read('buttonColor'));
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    // money format

    final formatCurrency = new NumberFormat("#,##0.00", "de_DE");

    return Container(
        child: Column(
          children: [
            rowFlatText(label: "Zwischensumme", value: (controller.cartItems!.amount)),
            if (controller.cartItems != null && controller.cartItems!.discountamount != "0.00")
              rowFlatText(
                label: "Aktionsrabatt",
                value: controller.cartItems!.discountamount.toString(),
                negative: true,
              ),
            rowFlatText(label: "Lieferkosten", value: formatCurrency.format(int.parse(userController.selectedArea!.deliveryAmount)).toString()),
            if (controller.isCouponApplied) rowFlatText(label: "Gutscheinrabatt", value: controller.couponModal!.giftamount.toString()),
            Container(
              height: 1,
              color: const Color(0xffdbdbdb),
            ),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Kurye
                  // Group 384
// Toplam Fiyat
                  Text("Gesamt",
                      style: const TextStyle(
                          color: MyColors.charcoal, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 15.0),
                      textAlign: TextAlign.left),
                  // 30
                  Row(
                    children: [
                      // €

                      Text(
                          controller.cartItems != null
                              ? priceFormat((double.parse(controller.cartItems!.totalUnformatted) +
                                          double.parse(userController.selectedArea!.deliveryAmount.toString())))
                                      .toString() +
                                  "€"
                              : '0€',
                          style: const TextStyle(
                              color: const Color(0xff22292b),
                              fontWeight: FontWeight.w900,
                              fontFamily: "Avenir",
                              fontStyle: FontStyle.normal,
                              fontSize: 20.0)),
                      SizedBox(
                        width: 5,
                      ),
                      Text("€",
                          style: TextStyle(
                              color: primaryColor, fontWeight: FontWeight.w500, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 20.0),
                          textAlign: TextAlign.left),
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  if (!controller.checkoutControl()) {
                    return null;
                  }
                  // controller.checkoutComplete("12313");
                  if (controller.selectedPayment == 0) {
                    // 5 haneli rastgele sayı üret
                    Random random = Random();
                    int randomNumber = random.nextInt(90000) + 10000;
                    controller.checkoutComplete(randomNumber);
                  } else if (controller.selectedPayment == 1) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => Payment(
                          tutar: priceFormat((double.parse(controller.cartItems!.totalUnformatted) +
                                  double.parse(userController.selectedArea!.deliveryAmount.toString())))
                              .toString()
                              .replaceAll(",", "."),
                          araToplam: controller.cartItems!.amount.toString(),
                          getirmeucreti: userController.selectedArea!.deliveryAmount.toString(),
                          adsoyad: controller.nameController!.text,
                          adresCity: controller.addressController!.text,
                          phone: controller.phoneController!.text,
                          onFinish: (number) async {
                            // payment done
                            /*  final snackBar = SnackBar(
                              content: Text("Payment done Successfully"),
                              duration: Duration(seconds: 5),
                              action: SnackBarAction(
                                label: 'Close',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            ); */
                            /*   _scaffoldKey.currentState
                                    .showSnackBar(snackBar); */
                            print('order id: ' + number);
                            print('Payment done Successfully');
                            Random random = Random();
                            int randomNumber = random.nextInt(90000) + 10000;
                            controller.checkoutComplete(randomNumber);
                          },
                        ),
                      ),
                    );
                  }
                },
                child: Opacity(
                    opacity: controller.checkoutControl() ? 1 : 0.5,
                    child: buttonGlobal(
                      text: "Zahlungspflichtig bestellen",
                      color: buttonColor,
                    ))),
            SizedBox(
              height: 10,
            )
          ],
        ),
        padding: EdgeInsets.only(top: 15, bottom: 10, left: 25, right: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            boxShadow: [BoxShadow(color: const Color(0x29000000), offset: Offset(0, 3), blurRadius: 30, spreadRadius: 0)],
            color: const Color(0xffffffff)));
  }
}

class pricingCard extends StatelessWidget {
  final String image;
  final String title;
  final int id;
  const pricingCard({
    Key? key,
    this.image = "assets/coins.png",
    this.title = "Barzahlung",
    this.id = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return GestureDetector(
      onTap: () {
        controller.selectedPayment = id;
        controller.update();
      },
      child: Container(
        width: Get.width / 4,
        height: Get.width / 3.6,
        decoration: BoxDecoration(
          color: controller.selectedPayment == id ? Color.fromARGB(255, 236, 236, 236) : Colors.white,
          border: Border.all(color: Color.fromARGB(255, 207, 207, 207), width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AspectRatio(
              aspectRatio: 2 / 1,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: TextStyle(
                color: MyColors.charcoal,
                fontWeight: FontWeight.w400,
                fontFamily: "Avenir",
                fontStyle: FontStyle.normal,
                fontSize: 13.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class rowFlatText extends StatelessWidget {
  final String label;
  final String value;
  final bool negative;

  const rowFlatText({
    Key? key,
    required this.label,
    required this.value,
    this.negative = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Kurye
          Text(label,
              style: const TextStyle(
                  color: MyColors.charcoal, fontWeight: FontWeight.w500, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0)),
          // 30
          Row(
            children: [
              // €

              negative
                  ? Text(" -",
                      style: const TextStyle(
                          color: const Color(0xff22292b),
                          fontWeight: FontWeight.w900,
                          fontFamily: "Avenir",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0))
                  : Container(),

              Text(value.replaceAll(".", ","),
                  style: const TextStyle(
                      color: const Color(0xff22292b),
                      fontWeight: FontWeight.w900,
                      fontFamily: "Avenir",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.0)),
              SizedBox(
                width: 5,
              ),
              Text("€",
                  style:
                      TextStyle(color: primaryColor, fontWeight: FontWeight.w500, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 16.0),
                  textAlign: TextAlign.left),
            ],
          )
        ],
      ),
    );
  }
}

class topSideWidget extends StatelessWidget {
  final int count;

  const topSideWidget({
    Key? key,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return Container(
      height: 60,
      color: primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 14,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.chevron_left,
                    size: 30,
                    color: primaryColor,
                  ),
                ),
              ),
              // Ödeme
              Text(
                "Zahlung",
                style: const TextStyle(
                    color: const Color(0xffffffff), fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 18.0),
              )
            ],
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.shopping_basket_outlined,
                size: 33,
                color: MyColors.white,
              ),
              // Path 3097
              Positioned(
                top: -5,
                right: -5,
                child: Container(
                    width: 26,
                    height: 26,
                    alignment: Alignment.center,
                    child: // 5
                        count == 0
                            ? Container()
                            : Text(count.toString(),
                                style: TextStyle(
                                    color: primaryColor,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Avenir",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0),
                                textAlign: TextAlign.left),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24), border: Border.all(color: primaryColor, width: 2), color: const Color(0xffffffff))),
              )
            ],
          )
        ],
      ),
    );
  }
}
