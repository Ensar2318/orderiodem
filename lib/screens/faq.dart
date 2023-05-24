import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/myFaqRow.dart';

class Faq extends GetView<ProductController> {
  const Faq({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    color: primaryColor,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
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
                        Container(
                          width: Get.width * 0.6,
                          child: Text("FAQ",
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "Avenir",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.0),
                              textAlign: TextAlign.center),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ), // Terms & Conditions

                  GetBuilder<ProductController>(builder: (controller) {
                    return controller.faq != null
                        ? controller.faq.length > 0
                            ? Container(
                                margin: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
                                child: ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: controller.isLoading != true ? controller.faq.length : 0,
                                    itemBuilder: (BuildContext context, int index) {
                                      return MyFaqRow(question: controller.faq[index].question, answer: controller.faq[index].answer);
                                    }),
                              )
                            : Container()
                        : Center(child: CircularProgressIndicator());
                  }),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
