import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/models/productModel.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/myButton.dart';

class mySlideUpPanel extends GetView<ProductController> {
  const mySlideUpPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(24.0)), boxShadow: [
        BoxShadow(
          blurRadius: 20.0,
          color: Colors.grey,
        ),
      ]),
      margin: const EdgeInsets.all(24.0),
      child: GetBuilder<ProductController>(builder: (controller) {
        return Column(
          children: [
            Container(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: const Text("Variants",
                    style: TextStyle(
                        color: Color(0xff040413), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 24.0),
                    textAlign: TextAlign.left),
              ),
            ),
            controller.slideUpProduct!.variants != null
                ? Container(
                    margin: const EdgeInsets.only(top: 5, right: 15, left: 15),
                    width: Get.width * 0.9,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(color: Colors.black54, blurRadius: 4.0, offset: Offset(0.0, 1.2)),
                        ],
                        color: Colors.white),
                    child: DropdownButton<Variant>(
                      value: controller.variant ?? null,
                      hint: const Text('Please select an option',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              fontFamily: "Gilroy",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.left),
                      onChanged: (Variant? newValue) {
                        controller.variant = newValue;
                        controller.update();
                      },
                      items: controller.slideUpProduct!.variants
                          .map<DropdownMenuItem<Variant>>((Variant? value) => DropdownMenuItem<Variant>(
                                value: value,
                                child: Text(value!.name,
                                    style: const TextStyle(
                                        color: Color(0xff000000),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Gilroy",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 17.0),
                                    textAlign: TextAlign.left),
                              ))
                          .toList(),
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
            Center(
              child: Container(
                margin: const EdgeInsets.all(10),
                child: const Text("Extras",
                    style: TextStyle(
                        color: Color(0xff040413), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 24.0),
                    textAlign: TextAlign.left),
              ),
            ),
            controller.variant != null
                ? MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                    child: Container(
                      height: 225,
                      child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: controller.variant!.extras.length,
                          itemBuilder: (context, index) {
                            return CheckboxListTile(
                              title: Text(controller.variant!.extras[index].label),
                              value: controller.variant!.extras[index].check,
                              onChanged: (bool? value) {
                                controller.variant!.extras[index].check = value!;
                                controller.update();
                              },
                            );
                          }),
                    ),
                  )
                : Container(),
            Container(
              margin: EdgeInsets.all(8),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          controller.hidePanel();
                          controller.hidePanelDetail();
                        });
                      },
                      child: MyButton(label: 'Close', width: Get.width * 0.4, color: MyColors.softText)),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        /* Future.delayed(const Duration(milliseconds: 100), () {
                          controller.hidePanel();
                        }); */
                        controller.addToCart(controller.slideUpProduct, controller.variant, true);
                      },
                      child: MyButton(label: 'Bestellen', width: Get.width * 0.4)),
                ],
              ),
            )
          ],
        );
      }),
    );
  }
}
