import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/models/supportsModel.dart';
import 'package:zwerge/newWidgets/menuItem.dart';
import 'package:zwerge/screens/customerSupport.dart';
import 'package:zwerge/screens/profile.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/buttonGlobal.dart';

import '../widgets/myButton.dart';

class CustomerSupports extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: GetBuilder<UserController>(builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                await controller.getSupport();
              },
              child: Column(
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

                        Text("Supports",
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
                        controller.supportTitlecontroller!.text = "";
                        controller.supportDesccontroller!.text = "";
                        Get.defaultDialog(
                          title: "",
                          content: Column(
                            children: [
                              TextField(
                                controller: controller.supportTitlecontroller,
                                decoration: InputDecoration(
                                  hintText: "Titel",
                                ),
                              ),
                              TextField(
                                controller: controller.supportDesccontroller,
                                decoration: InputDecoration(
                                  hintText: "Erläuterung",
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  print(controller.supportDesccontroller!.text);
                                  Get.back();
                                  controller.createNewSupport(
                                      other: true, title: controller.supportTitlecontroller!.text, desc: controller.supportDesccontroller!.text);
                                },
                                child: buttonGlobal(
                                  text: "Schicken",
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      child: menuItem(
                        text: "Neue Supportanfrage erstellen",
                        icon: Icons.pin_drop,
                        lastIcon: Icons.add,
                        textColor: primaryColor,
                      ),
                    ),
                  ),
                  controller.supports != null
                      ? controller.supports.length > 0
                          ? Expanded(
                              child: Container(
                              margin: EdgeInsets.only(bottom: 14, left: 20, right: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [for (var i in controller.supports) itemSupport(data: i)],
                                ),
                              ),
                            ))
                          : isEmpty()
                      : isEmpty()
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Column isEmpty() {
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
              child: Text("🎧",
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
          child: Text("Stützen ist leer",
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
            child: Text("Sie haben noch keine Supports hinzugefügt,\nklicken Sie auf Neu hinzufügen, um einen zu erstellen",
                style: TextStyle(
                    color: Color(0xff040413), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 16.0),
                textAlign: TextAlign.center),
          ),
        ),
      ],
    );
  }
}

class itemSupport extends GetView<UserController> {
  final Support data;

  const itemSupport({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return GestureDetector(
      onTap: () {
        Get.to(CustomerSupport(data: data));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 20),
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
                  Text(data.subject,
                      style: TextStyle(
                          color: MyColors.charcoal, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 15.0)),
                  SizedBox(
                    height: 5,
                  ),
                  // (319) 555-0115
                  Text(data.responses!.length != 0 ? data.responses![data.responses!.length - 1].message : data.message,
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
                ],
              ),
              GestureDetector(
                onTap: (() => {
                      Get.defaultDialog(
                        title: 'Delete Suppport',
                        titlePadding: const EdgeInsets.only(top: 20),
                        titleStyle: TextStyle(color: MyColors.watermelon),
                        content: Container(padding: EdgeInsets.all(15), child: Text('Are you sure you want to delete this Support?')),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: MyButton(label: 'Stornieren', width: Get.width * 0.27, color: MyColors.watermelon),
                          ),
                          TextButton(
                            onPressed: () {
                              Get.back();
                              controller.removeSupport(int.parse(data.id));
                              Get.snackbar('Erfolg', 'Der Support wurde gelöscht.');
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: MyButton(
                                label: 'löschen',
                                width: Get.width * 0.27,
                              ),
                            ),
                          ),
                        ],
                      )
                    }),
                child: Icon(
                  Icons.delete_outline,
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
                  colors: [const Color(0xffffffff), const Color(0xffffffff)]))),
    );
  }
}
