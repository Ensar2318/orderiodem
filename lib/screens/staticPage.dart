import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/mainController.dart';

class StaticPage extends GetView<MainController> {
  String page;
  StaticPage(this.page, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MainController());
    return Scaffold(
        body: SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      children: [
                        Image.asset('assets/backIcon.png', width: 8),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text("Back",
                            style: TextStyle(
                                color: Color(0xff040413),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Gilroy",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0),
                            textAlign: TextAlign.left)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ), // Terms & Conditions
                  Html(
                    data: page,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
