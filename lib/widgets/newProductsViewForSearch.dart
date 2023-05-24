import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/newProduct.dart';

class newProductsViewForSearch extends StatelessWidget {
  const newProductsViewForSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: GetBuilder<ProductController>(builder: (_products) {
          return LayoutBuilder(builder: (BuildContext ctx, BoxConstraints constraints) {
            // if the screen width >= 480 i.e Wide Screen
            if (constraints.maxHeight <= 380) {
              return Stack(
                children: [
                  _products.searchResult != null
                      ? GridView.count(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 10),
                          crossAxisCount: 2,
                          childAspectRatio: Get.width / Get.height / 0.82,
                          children: List<Widget>.generate(_products.searchResult.length, (index) {
                            return newProduct(
                                product: _products.searchResult[index],
                                tab: '',
                                otherProduct: _products.searchResult,
                                index: index,
                                isDetail: false,
                                qty: _products.getQuantity(int.parse(_products.searchResult[index].id)));
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
            } else {
              return Stack(
                children: [
                  _products.searchResult.length != 0
                      ? GridView.count(
                          padding: const EdgeInsets.only(top: 10),
                          crossAxisCount: 2,
                          childAspectRatio: Get.width / Get.height / 0.7,
                          children: List<Widget>.generate(_products.searchResult.length, (index) {
                            return newProduct(
                                product: _products.searchResult[index],
                                tab: '',
                                otherProduct: _products.searchResult,
                                index: index,
                                isDetail: false,
                                qty: _products.getQuantity(int.parse(_products.searchResult[index].id)));
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
            }
          });
        }),
      ),
    );
  }
}
