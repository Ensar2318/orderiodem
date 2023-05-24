import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/screens/home.dart';
import 'package:zwerge/utils/Colors.dart';

import '../widgets/buttonGlobal.dart';
import '../widgets/inputGlobal.dart';

class SignIn extends GetView<UserController> {
  const SignIn({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    ProductController productController = Get.put(ProductController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    int tabTarget = 0;
    // future delay

    return SafeArea(
      child: Scaffold(body: GetBuilder<UserController>(builder: (controller) {
        // future delay
        return SingleChildScrollView(
          child: Container(
            color: primaryColor,
            child: Column(
              children: [
                // Group 1915
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(Home());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Ohne Anmeldung fortfahren",
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0)),
                      Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                      SizedBox(
                        width: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Stack(children: [
                    Center(
                      child: productController.options != null
                          ? Image.network(
                              'https://cdn.orderio.de/images/logos/' + productController.options!.logo!.toString(),
                              width: Get.width * 0.5,
                              fit: BoxFit.contain,
                            )
                          : Container(),
                    )
                  ]),
                ),
                SizedBox(
                  height: controller.tabTarget == 0 ? Get.height / 6 : 0,
                ),

                controller.tabTarget == 0
                    ? Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 54,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.tabTarget = 0;
                                    controller.update();
                                  },
                                  child: tabItem(
                                    text: "Anmeldung",
                                    isActive: true,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      controller.tabTarget = 1;
                                      controller.update();
                                    },
                                    child: tabItem(text: "Registrieren")),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(38), topRight: Radius.circular(38)),
                              ),
                              child: Container(
                                child: Column(
                                  children: [
                                    inputGlobal(
                                      hint: "E-Mail Adresse",
                                      label: "E-Mail Adresse",
                                      radius: 25,
                                      icon: "email",
                                      lastIcon: 1,
                                      mb: 10,
                                      searchController: controller.emailController,
                                    ),
                                    inputGlobal(
                                      hint: "******",
                                      label: "Passwort",
                                      radius: 25,
                                      icon: "key",
                                      lastIcon: 2,
                                      mb: 25,
                                      searchController: controller.passwordController,
                                      isPassword: true,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (controller.emailController!.text.length > 2 && controller.passwordController!.text.length > 2) {
                                          controller.login();
                                        } else {
                                          productController.customModal(title: "Bitte lassen Sie keine Leerzeichen.", status: "error");
                                        }
                                      },
                                      child: buttonGlobal(
                                        text: "Anmelden",
                                        color: primaryColor,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text("Passwort vergessen?",
                                          style: TextStyle(
                                              color: primaryColor,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Avenir",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 14.0),
                                          textAlign: TextAlign.center),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 54,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.tabTarget = 0;
                                  controller.update();
                                },
                                child: tabItem(
                                  text: "Anmeldung",
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    controller.tabTarget = 1;
                                    controller.update();
                                  },
                                  child: tabItem(text: "registrieren", isActive: true)),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(38), topRight: Radius.circular(38)),
                            ),
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  inputGlobal(
                                    hint: "Vorname",
                                    label: "Vorname",
                                    radius: 10,
                                    icon: "user",
                                    mb: 10,
                                    searchController: controller.firstnameController,
                                  ),
                                  inputGlobal(
                                    hint: "Nachname",
                                    label: "Nachname",
                                    radius: 10,
                                    icon: "user",
                                    mb: 10,
                                    searchController: controller.surnameController,
                                  ),
                                  inputGlobal(
                                      hint: "E-Mail Adresse",
                                      label: "E-Mail Adresse",
                                      radius: 10,
                                      icon: "email",
                                      mb: 10,
                                      searchController: controller.emailControllerRegister),
                                  inputGlobal(
                                      hint: "Telefonnummer",
                                      label: "Telefonnummer",
                                      radius: 10,
                                      icon: "phone",
                                      mb: 10,
                                      searchController: controller.phoneController),
                                  inputGlobal(
                                    hint: "******",
                                    label: "Passwort",
                                    radius: 10,
                                    icon: "key",
                                    lastIcon: 2,
                                    mb: 25,
                                    searchController: controller.passwordControllerRegister,
                                    isPassword: true,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.firstnameController!.text.length > 2 &&
                                          controller.surnameController!.text.length > 2 &&
                                          controller.emailControllerRegister!.text.length > 2 &&
                                          controller.phoneController!.text.length > 2 &&
                                          controller.passwordControllerRegister!.text.length > 2) {
                                        controller.register();
                                      } else {
                                        Get.snackbar('Warnung', 'Bitte lassen Sie keine Leerzeichen.',
                                            icon: Icon(
                                              Icons.error,
                                              color: Colors.white,
                                            ),
                                            backgroundColor: MyColors.watermelonSoft,
                                            colorText: Colors.white,
                                            margin: EdgeInsets.all(10));
                                      }
                                    },
                                    child: buttonGlobal(
                                      text: "Registrieren",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        );
      })),
    );
  }
}

class tabItem extends StatelessWidget {
  final bool isActive;
  final String text;
  const tabItem({
    Key? key,
    this.isActive = false,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      decoration: isActive
          ? BoxDecoration(
              border: Border(
              bottom: BorderSide(width: 3.0, color: MyColors.white),
            ))
          : null,
      child: Opacity(
        opacity: isActive ? 1 : 0.7,
        child: Text(text,
            style: TextStyle(color: MyColors.white, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 17.0)),
      ),
    );
  }
}
