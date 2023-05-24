import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/newProduct.dart';

class WishList extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ProductController>(builder: (controller) {
          return Container(
            margin: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
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
                ),
                Container(
                  width: Get.width,
                  padding: EdgeInsets.only(left: Get.width * 0.05),
                  color: Colors.white,
                  child: const Text("Wishlist",
                      style: TextStyle(
                          color: Color(0xff040413), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 24.0),
                      textAlign: TextAlign.left),
                ),
                Expanded(
                  child: Container(
                    child: GetBuilder<ProductController>(builder: (_products) {
                      return Stack(
                        children: [
                          _products.whishlistResult != null
                              ? GridView.count(
                                  padding: const EdgeInsets.only(top: 10),
                                  crossAxisCount: 2,
                                  childAspectRatio: Get.width / Get.height / 0.7,
                                  children: List<Widget>.generate(_products.whishlistResult.length, (index) {
                                    return newProduct(
                                        product: _products.whishlistResult[index],
                                        tab: 'Whishlist',
                                        otherProduct: null,
                                        index: index,
                                        isDetail: false,
                                        qty: _products.getQuantity(int.parse(_products.whishlistResult[index].id)));
                                  }),
                                )
                              : Container(),
                          _products.isLoading == true
                              ? Container(
                                  child: const Center(
                                  child: CircularProgressIndicator(
                                    color: MyColors.orange,
                                  ),
                                ))
                              : Container(),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
