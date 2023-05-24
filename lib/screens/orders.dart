import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/screens/orderDetail.dart';
import 'package:zwerge/screens/profile.dart';
import 'package:zwerge/utils/Colors.dart';

class addresItem extends GetView<UserController> {
  final String title;
  final String content;
  final String price;

  const addresItem({
    Key? key,
    required this.title,
    required this.content,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return Container(
        margin: EdgeInsets.only(bottom: 20, left: 20, right: 20),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ev
                Text(title,
                    style: TextStyle(
                        color: MyColors.softGrey, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 15.0)),
                SizedBox(
                  height: 5,
                ),
                // (319) 555-0115
                Text(content,
                    style: TextStyle(
                        color: MyColors.slateGrey, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 15.0)),
                // 1749 Wheeler Ridge
              ],
            ),
            Row(
              children: [
                Text("€ ",
                    style: TextStyle(
                        color: primaryColor, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 20.0)),
                Text(price,
                    style: TextStyle(
                        color: MyColors.black, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 20.0)),
                Icon(
                  Icons.chevron_right_rounded,
                  color: primaryColor,
                  size: 40,
                ),
              ],
            ),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            boxShadow: [BoxShadow(color: const Color(0xffe6e6e6), offset: Offset(0, 15), blurRadius: 30, spreadRadius: 0)],
            gradient: LinearGradient(
                begin: Alignment(0.08409727364778519, 0.43446260690689087),
                end: Alignment(0.46691903471946716, 0.45219510793685913),
                colors: [const Color(0xffffffff), const Color(0xffffffff)])));
  }
}

class Orders extends GetView<UserController> {
  Column addressIsEmpty() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.2,
        ),
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.white,
            ),
            child: const Center(
              child: Text("🗺️",
                  style: TextStyle(
                      color: Color(0xff040413), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 48.0),
                  textAlign: TextAlign.left),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text("Addresses is empty",
              style:
                  TextStyle(color: Color(0xff040413), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 24.0),
              textAlign: TextAlign.left),
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Opacity(
            opacity: 0.6000000238418579,
            child: Text("You don’t have any address added yet,\nclick Add New to create one",
                style: TextStyle(
                    color: Color(0xff040413), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 16.0),
                textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    // futuredelay
    Future.delayed(Duration(milliseconds: 200), () {
      controller.getOrders();
    });
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: GetBuilder<UserController>(builder: (controller) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  color: primaryColor,
                  child: // Adreslerim
                      Row(
                    children: [
                      // Rectangle 15
                      GestureDetector(
                        onTap: () => {Get.to(Profile())},
                        child: Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Icon(
                              Icons.chevron_left,
                              color: primaryColor,
                              size: 30,
                            ),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: const Color(0xffffffff))),
                      ),

                      Text("Bestellungen",
                          style: const TextStyle(
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w900,
                              fontFamily: "Avenir",
                              fontStyle: FontStyle.normal,
                              fontSize: 18.0),
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                controller.orders.length != 0
                    ? Expanded(
                        child: Container(
                        margin: EdgeInsets.only(bottom: 14),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var i in controller.orders)
                                GestureDetector(
                                  onTap: () => {
                                    Get.to(OrderDetail(
                                      data: i,
                                    ))
                                  },
                                  child: addresItem(
                                    title: i.created.toString(),
                                    content: i.transactionId.toString(),
                                    price: i.amount.toString(),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ))
                    : addressIsEmpty()
              ],
            );
          }),
        ),
      ),
    );
  }
}
