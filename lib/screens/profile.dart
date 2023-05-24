import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/screens/accountSettings.dart';
import 'package:zwerge/screens/addresses.dart';
import 'package:zwerge/screens/customerSupports.dart';
import 'package:zwerge/screens/home.dart';
import 'package:zwerge/screens/orders.dart';
import 'package:zwerge/screens/signIn.dart';
import 'package:zwerge/screens/terms.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/utils/helper.dart';
import 'package:zwerge/widgets/topBarProfile.dart';

import '../controllers/userController.dart';
import '../newWidgets/menuItem.dart';
import '../utils/Constants.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profiletate();
}

class _Profiletate extends State<Profile> {
  UserController userController = Get.find<UserController>();
  ProductController productController = Get.find<ProductController>();

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    var screenHeight = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Get.to(Home());
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Container(
              color: Colors.white,
              child: LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
                // if the screen width >= 480 i.e Wide Screen
                return Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TopBarProfile(), // Settings
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.zero,
                        child: Container(
                          margin: const EdgeInsets.all(25),
                          child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                            if (userController.isLogin == true)
                              Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Get.to(AccountSettings());
                                      },
                                      child: menuItem(text: "Profil bearbeiten", icon: Icons.edit)),
                                  if (box.read('coordinateActive') != "1")
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(Addresses());
                                        },
                                        child: menuItem(text: "Adressen", icon: Icons.pin_drop_outlined)),
                                  // GestureDetector(
                                  //     onTap: () => {Get.to(BillingAddresses())},
                                  //     child: menuItem(text: "Rechnungsadressen", icon: Icons.pin_drop_rounded)),
                                  GestureDetector(
                                      onTap: () => {Get.to(Orders())}, child: menuItem(text: "Bestellungen", icon: Icons.shopping_bag_outlined)),
                                  GestureDetector(
                                      onTap: () => {Get.to(CustomerSupports())}, child: menuItem(text: "Support", icon: Icons.shopping_bag_outlined)),
                                ],
                              ),
                            // GestureDetector(
                            //     onTap: () {
                            //       Get.to(Faq());
                            //     },
                            //     child: menuItem(text: "FAQ", icon: Icons.headphones)),
                            GestureDetector(
                                onTap: () {
                                  final data = userController.staticFooterPages[0];

                                  Get.to(Terms(
                                    data: data,
                                    title: "AGB",
                                    color: primaryColor,
                                  ));
                                },
                                child: menuItem(text: "AGB", icon: Icons.privacy_tip)),
                            GestureDetector(
                                onTap: () {
                                  final data = userController.staticFooterPages[1];

                                  Get.to(Terms(
                                    data: data,
                                    color: primaryColor,
                                    title: "Datenschutz",
                                  ));
                                },
                                child: menuItem(text: "Datenschutz", icon: Icons.privacy_tip)),
                            GestureDetector(
                                onTap: () {
                                  final data = userController.staticFooterPages[2];

                                  Get.to(Terms(
                                    data: data,
                                    color: primaryColor,
                                    title: "Impressum",
                                  ));
                                },
                                child: menuItem(text: "Impressum", icon: Icons.privacy_tip)),
                            GestureDetector(
                                onTap: () {
                                  goWebUrl("tel: ${userController.shopContact!.telefon!}");
                                },
                                child: menuItem(
                                  text: "Restaurant anrufen",
                                  icon: Icons.phone,
                                  hideLastIcon: true,
                                )),
                            if (userController.isLogin == false)
                              GestureDetector(
                                  onTap: () {
                                    Get.to(SignIn());
                                  },
                                  child: menuItem(text: "Einloggen", icon: Icons.login)),

                            if (userController.isLogin == true)
                              GestureDetector(
                                onTap: () => {
                                  userController.logout(),
                                },
                                child: Container(
                                    height: 66,
                                    margin: EdgeInsets.only(bottom: 12),
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Group 545
                                              Text("Ausloggen", style: menuText(MyColors.black)),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.logout,
                                            color: primaryColor,
                                            size: 26,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(18)),
                                        boxShadow: [
                                          BoxShadow(color: const Color(0xffe6e6e6), offset: Offset(0, 15), blurRadius: 30, spreadRadius: 0)
                                        ],
                                        gradient: LinearGradient(
                                            begin: Alignment(0.08409727364778519, 0.43446260690689087),
                                            end: Alignment(0.46691903471946716, 0.45219510793685913),
                                            colors: [const Color(0xffffffff), const Color(0xffffffff)]))),
                              ),
                            if (userController.isLogin == true)
                              GestureDetector(
                                onTap: () => {
                                  userController.logout(),
                                },
                                child: Container(
                                    height: 66,
                                    margin: EdgeInsets.only(bottom: 12),
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Group 545
                                              Text("Lösche mein Konto", style: menuText(MyColors.black)),
                                            ],
                                          ),
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Icon(
                                            Icons.logout,
                                            color: primaryColor,
                                            size: 26,
                                          ),
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(18)),
                                        boxShadow: [
                                          BoxShadow(color: const Color(0xffe6e6e6), offset: Offset(0, 15), blurRadius: 30, spreadRadius: 0)
                                        ],
                                        gradient: LinearGradient(
                                            begin: Alignment(0.08409727364778519, 0.43446260690689087),
                                            end: Alignment(0.46691903471946716, 0.45219510793685913),
                                            colors: [const Color(0xffffffff), const Color(0xffffffff)]))),
                              ),
                            // // Group 543
                            SizedBox(
                              height: 10,
                            ),
                            Text("Version 1.0",
                                style: const TextStyle(
                                    color: const Color(0xffa2a2a2),
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Avenir",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0),
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                              onTap: () {
                                goWebUrl("https://7zwerge.de");
                              },
                              child: Text(
                                "© 2023 | Alle Rechte vorbehalten - Software Solution by orderio.de",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                goWebUrl("https://orderio.de");
                              },
                              child: AspectRatio(
                                aspectRatio: 7 / 1,
                                child: Image.asset(
                                  "assets/orderiologo.jpg",
                                  width: 20,
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                  ],
                );
              })),
        ),
      ),
    );
  }
}
