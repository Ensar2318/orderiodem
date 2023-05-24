import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/bottomMenu.dart';
import 'package:zwerge/widgets/newProductsView.dart';
import 'package:zwerge/widgets/topBar.dart';

class Store extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());

    return Scaffold(
      body: Container(
        color: MyColors.orange,
        child: Container(
          margin: const EdgeInsets.only(top: 25),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TopBar(
                label: 'Welcome 👋',
              ),
              Container(
                color: Colors.black,
                height: 60,
                child: GetBuilder<ProductController>(builder: (_products) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _products.isLoading != true ? _products.products.length : 0,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _products.setActiveTab(index);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, top: 12, bottom: 12, right: 10),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.white),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(7),
                              ),
                            ),
                            child: Center(
                              child: Text(_products.products[index].name,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Gilroy",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.0),
                                  textAlign: TextAlign.left),
                            ),
                          ),
                        );
                      });
                }),
              ),
              const newProductsView(),
              BottomMenu(
                active: 'store',
              )
            ],
          ),
        ),
      ),
    );
  }
}
