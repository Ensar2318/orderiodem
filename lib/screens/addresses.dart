import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/newWidgets/menuItem.dart';
import 'package:zwerge/screens/profile.dart';
import 'package:zwerge/utils/Colors.dart';

import '../widgets/myButton.dart';
import 'address.dart';

class addresItem extends GetView<UserController> {
  final String title;
  final String phone;
  final String adres;
  final String id;

  const addresItem({
    Key? key,
    required this.title,
    required this.phone,
    required this.adres,
    required this.id,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Ev
                Text(title,
                    style: TextStyle(
                        color: MyColors.charcoal, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 15.0)),
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
                        fontSize: 14.0))
              ],
            ),
            GestureDetector(
              onTap: (() => {
                    Get.defaultDialog(
                      title: 'Adresse löschen',
                      titlePadding: const EdgeInsets.only(top: 20),
                      titleStyle: TextStyle(color: MyColors.watermelon),
                      content: Container(padding: EdgeInsets.all(15), child: Text('Möchten Sie diese Adresse wirklich löschen?')),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: MyButton(label: 'Stornieren', width: Get.width * 0.27, color: MyColors.watermelon),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.removeAddress(id);
                            Get.back();
                            Get.snackbar('Erfolg', 'Die Adresse wurde gelöscht.');
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15.0),
                            child: MyButton(
                              label: 'löschen',
                              width: Get.width * 0.27,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    )
                  }),
              child: Icon(
                Icons.delete,
                color: primaryColor,
              ),
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

class Addresses extends GetView<UserController> {
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
          child: Text("Adressen ist leer",
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
            child: Text("Die Adressliste ist leer! Du hast keine Adressen gespeichert. Gehe auf dein Profil, um eine neue Adresse zu hinterlegen",
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

                      Text("Adressen",
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
                Container(
                  margin: EdgeInsets.only(bottom: 5, top: 20, left: 20, right: 20),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(Address(returnPage: 'addresses', type: 0));
                    },
                    child: menuItem(
                      text: "Adresse hinzufügen",
                      icon: Icons.pin_drop,
                      lastIcon: Icons.add,
                      textColor: primaryColor,
                    ),
                  ),
                ),
                controller.addresses.length != 0
                    ? Expanded(
                        child: Container(
                        margin: EdgeInsets.only(bottom: 14),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [for (var i in controller.addresses) addresItem(title: i.label, phone: i.area, adres: i.address, id: i.id)],
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
