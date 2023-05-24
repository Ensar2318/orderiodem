import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/controllers/userController.dart';

class Splash extends GetView<UserController> {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    Get.put(ProductController());
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Image.asset(
            "assets/zwerge.jpg",
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}
