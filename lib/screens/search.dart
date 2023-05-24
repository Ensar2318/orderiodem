import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/widgets/myButton.dart';
import 'package:zwerge/widgets/myTextField.dart';

class Search extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(margin: const EdgeInsets.only(right: 35, top: 25), child: Image.asset('assets/closeIcon.png', width: 24))),
            ],
          ),
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text("Search",
                style: TextStyle(
                    color: Color(0xff040413), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 28.0),
                textAlign: TextAlign.left),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: MyTextField(
              searchController: controller.searchTextField,
              hidden: false,
              label: '  What are you looking for?',
              prefixIcon: Container(
                  child: Image.asset(
                'assets/topSearch.png',
                color: Colors.black,
                width: 15,
                height: 15,
              )),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20),
            child: const Text("Search in categories",
                style: TextStyle(
                    color: Color(0xff040413), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 20.0),
                textAlign: TextAlign.left),
          ),
          SizedBox(height: 20),
          GetBuilder<ProductController>(builder: (controller) {
            return Expanded(
              child: GridView.count(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 10),
                crossAxisCount: 1,
                childAspectRatio: Get.width / Get.height / 0.1,
                children: List<Widget>.generate(controller.products.length, (index) {
                  var i = 0;
                  var i2 = 1;
                  if (index == 0) {
                    i = 0;
                    i2 = 1;
                  } else {
                    i = index * 2 - 1;
                    i2 = index * 2;
                  }
                  // print('https://cdn.orderio.de/images/categories/icons/' + controller.products[i].icon);
                  return i2 < controller.products.length
                      ? Row(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(12),
                                margin: EdgeInsets.only(left: Get.width * 0.025, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: const Color(0xffe0e0e0), width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          controller.products[i].icon != null
                                              ? Image.network(
                                                  'https://cdn.orderio.de/images/categories/icons/' + controller.products[i].icon,
                                                  width: 35,
                                                )
                                              : Image.network(
                                                  'https://cdn.orderio.de/images/products/placeholder.jpg',
                                                  width: 35,
                                                ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(controller.products[i].name,
                                              style: TextStyle(
                                                  color: Color(0xff040413),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Gilroy",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0),
                                              textAlign: TextAlign.left),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                            Container(
                                padding: const EdgeInsets.all(12),
                                margin: EdgeInsets.only(left: Get.width * 0.025, bottom: 15),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(color: const Color(0xffe0e0e0), width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          controller.products[i2].icon != null
                                              ? Image.network(
                                                  'https://cdn.orderio.de/images/categories/icons/' + controller.products[i2].icon,
                                                  width: 35,
                                                )
                                              : Image.network(
                                                  'https://cdn.orderio.de/images/products/placeholder.jpg',
                                                  width: 35,
                                                ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(controller.products[i2].name,
                                              style: TextStyle(
                                                  color: Color(0xff040413),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Gilroy",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0),
                                              textAlign: TextAlign.left),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )
                      : Container();
                }),
              ),
            );
          }),
          GestureDetector(
              onTap: () {
                controller.searchProducts();
              },
              child: Container(margin: EdgeInsets.only(left: Get.width * 0.05), child: MyButton(label: 'Search', width: Get.width * 0.9)))
        ],
      ),
    ));
  }
}
