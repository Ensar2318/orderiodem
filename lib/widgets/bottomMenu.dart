import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/screens/cart.dart';
import 'package:zwerge/screens/home.dart';
import 'package:zwerge/screens/profile.dart';
import 'package:zwerge/screens/store.dart';

class BottomMenu extends StatelessWidget {
  final String active;
  BottomMenu({required this.active}) : super();
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => Get.to(Home()),
              child: Column(
                children: [
                  Image.asset('assets/menuHome.png', color: active == 'home' ? Colors.orange : Colors.white, width: 25),
                  const SizedBox(
                    height: 7,
                  ),
                  Text("Home",
                      style: TextStyle(
                          color: active == 'home' ? Colors.orange : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Gilroy",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0),
                      textAlign: TextAlign.left)
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(Store()),
              child: Column(
                children: [
                  Image.asset('assets/menuStore.png', color: active == 'store' ? Colors.orange : Colors.white, width: 25),
                  const SizedBox(
                    height: 7,
                  ),
                  Text("Store",
                      style: TextStyle(
                          color: active == 'store' ? Colors.orange : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Gilroy",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0),
                      textAlign: TextAlign.left)
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Get.to(Cart()),
              child: Column(
                children: [
                  Image.asset('assets/menuCart.png', color: active == 'cart' ? Colors.orange : Colors.white, width: 25),
                  const SizedBox(
                    height: 7,
                  ),
                  Text("Cart",
                      style: TextStyle(
                          color: active == 'cart' ? Colors.orange : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Gilroy",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0),
                      textAlign: TextAlign.left)
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                final box = GetStorage();
                var loginCheck = box.read('userId');
                if (loginCheck != null) {
                  Get.to(Profile());
                } else {
                  Get.snackbar(
                    'Warnung',
                    'You must be logged in to use the profile page.',
                    icon: Icon(
                      Icons.error,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.yellow.shade700,
                    colorText: Colors.white,
                  );
                }
              },
              child: Column(
                children: [
                  Image.asset('assets/menuUser.png', color: active == 'profile' ? Colors.orange : Colors.white, width: 25),
                  const SizedBox(
                    height: 7,
                  ),
                  Text("Profile",
                      style: TextStyle(
                          color: active == 'profile' ? Colors.orange : Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Gilroy",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.0),
                      textAlign: TextAlign.left)
                ],
              ),
            )
          ],
        ));
  }
}
