import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/checkoutBottom.dart';
import 'package:zwerge/widgets/newCartItem.dart';
import 'package:zwerge/widgets/newProduct.dart';

class Cart extends GetView<ProductController> {
  const Cart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    controller.getCartList();
    return Scaffold(
      body: GetBuilder<ProductController>(builder: (controller) {
        if (controller.isLoading) {
          return Container(
              child: const Center(
            child: CircularProgressIndicator(
              color: MyColors.orange,
            ),
          ));
        } else {
          return Container(
            margin: EdgeInsets.only(top: 50),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
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
                          // My Cart
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("My Cart",
                                  style: TextStyle(
                                      color: const Color(0xff040413),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Gilroy",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 28.0),
                                  textAlign: TextAlign.left),
                              // 0 Items
                              Opacity(
                                opacity: 0.699999988079071,
                                child: Text(controller.cartItems != null ? controller.cartItems!.products.length.toString() + ' items' : '0 items',
                                    style: const TextStyle(
                                        color: Color(0xff040413),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Gilroy",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 16.0),
                                    textAlign: TextAlign.left),
                              )
                            ],
                          ),
                          controller.cartItems != null
                              ? controller.cartItems!.products.isEmpty
                                  ? const cartIsEmpty()
                                  : GridView.count(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.only(top: 10),
                                      crossAxisCount: 1,
                                      childAspectRatio: Get.width / Get.height / 0.2,
                                      children: List<Widget>.generate(controller.cartItems!.products.length, (index) {
                                        return newCartItem(product: controller.cartItems!.products[index], cartkey: index);
                                      }),
                                    )
                              : const cartIsEmpty(),
                          controller.cartItems != null
                              ? controller.cartItems!.products.isNotEmpty
                                  ? const Text("You might also like",
                                      style: TextStyle(
                                          color: Color(0xff040413),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Gilroy",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20.0),
                                      textAlign: TextAlign.left)
                                  : Container()
                              : Container(),
                          controller.cartItems != null
                              ? controller.cartItems!.products.isNotEmpty
                                  ? Container(
                                      height: 500,
                                      child: GridView.count(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        padding: const EdgeInsets.only(top: 10),
                                        crossAxisCount: 2,
                                        childAspectRatio: Get.width / Get.height / 0.7,
                                        children: List<Widget>.generate(controller.products[controller.activeTab].products.length, (index) {
                                          return newProduct(
                                              product: controller.products[controller.activeTab].products[index],
                                              tab: '',
                                              otherProduct: controller.products[controller.activeTab].products,
                                              index: index,
                                              isDetail: true,
                                              qty: controller.getQuantity(int.parse(controller.products[controller.activeTab].products[index].id)));
                                        }),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                ),
                CheckoutBottom(type: 1, label: 'Checkout', total: controller.cartItems != null ? controller.cartItems!.total.toString() : '0'),
              ],
            ),
          );
        }
      }),
    );
  }
}

class cartIsEmpty extends StatelessWidget {
  const cartIsEmpty({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: Get.height * 0.2,
        ),
        Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(width: 1, color: Colors.grey),
              color: Colors.white,
            ),
            child: const Center(
              child: Text("🛒",
                  style: TextStyle(
                      color: Color(0xff040413), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 48.0),
                  textAlign: TextAlign.left),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text("Cart is empty",
              style:
                  TextStyle(color: Color(0xff040413), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 24.0),
              textAlign: TextAlign.left),
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Opacity(
            opacity: 0.6000000238418579,
            child: Text("You don’t have any product in your cart.\nAdd anything you like",
                style: TextStyle(
                    color: Color(0xff040413), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 16.0),
                textAlign: TextAlign.center),
          ),
        )
      ],
    );
  }
}
