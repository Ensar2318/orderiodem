import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/screens/productDetail.dart';

class newProduct extends StatelessWidget {
  final product;
  final tab;
  final otherProduct;
  final index;
  final isDetail;
  final qty;

  const newProduct({Key? key, this.product, this.tab, this.otherProduct, this.index, this.isDetail, this.qty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductController>(builder: (controller) {
      return GestureDetector(
        onTap: () {
          // controller.getProductInfo(_products.products[_products.activeTab].products[index].id);
          if (isDetail) {
            Get.back();
            Get.to(ProductDetail(product, tab, otherProduct, index));
          } else {
            Get.to(ProductDetail(product, tab, otherProduct, index));
          }
        },
        child: Container(
            height: 400,
            margin: EdgeInsets.only(left: Get.width * 0.025, right: Get.width * 0.025, bottom: 15),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: const Color(0xffe0e0e0), width: 1),
              color: Colors.white,
            ),
            child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    !controller.isAlreadyInCart(product.id)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    style: const TextStyle(
                                        color: Color(0xff040413),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Gilroy",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0),
                                    text: product.price)
                              ])),
                              GestureDetector(
                                  onTap: () {
                                    if (product.variants.length != 0) {
                                      controller.showPanel(product);
                                    } else {
                                      controller.addToCart(product, null, false);
                                    }
                                  },
                                  child: Image.asset('assets/addCart.png', width: 35))
                            ],
                          )
                        : Container(
                            margin: const EdgeInsets.only(left: 6, right: 6),
                            padding: const EdgeInsets.only(left: 6, right: 6),
                            height: 40,
                            decoration: const BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(100)), color: Color(0xffe88a34)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    if (controller.getQuantity(int.parse(product.id)) > 1) {
                                      controller.updateCart(int.parse(product.id), controller.getQuantity(int.parse(product.id)) - 1);
                                    } else {
                                      controller.removeFromCart(int.parse(product.id));
                                    }
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                      child: Text("-",
                                          style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Gilroy",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 25.0),
                                          textAlign: TextAlign.left),
                                    ),
                                  ),
                                ), // 1
                                Text(qty.toString(),
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "Gilroy",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0),
                                    textAlign: TextAlign.left), // 1
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: () {
                                    int qtyNew = qty + 1;
                                    controller.updateCart(int.parse(product.id), qtyNew);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    child: Center(
                                      child: Text("+",
                                          style: TextStyle(
                                              color: Color(0xffffffff),
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Gilroy",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 25.0),
                                          textAlign: TextAlign.left),
                                    ),
                                  ),
                                )
                              ],
                            )),
                    Container(
                      margin: const EdgeInsets.all(12),
                      height: 110,
                      child: product.image != null
                          ? CachedNetworkImage(
                              imageUrl: 'https://cdn.orderio.de/images/products/' + product.image,
                              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) {
                                return Image.network('https://cdn.orderio.de/images/products/placeholder.jpg');
                              },
                              fit: BoxFit.fitWidth,
                            )
                          : Image.network(
                              'https://cdn.orderio.de/images/products/placeholder.jpg',
                            ),
                    ),
                    /*  Container(
                        margin: const EdgeInsets.all(12),
                        child: product.image != null
                            ? Image.network('https://cdn.orderio.de/images/products/' + product.image)
                            : Image.network(
                                'https://cdn.orderio.de/images/products/placeholder.jpg',
                              )), */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name,
                                  style: const TextStyle(
                                      color: Color(0xff040413),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Gilroy",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.left), // Snacks
                              Text(tab,
                                  style: const TextStyle(
                                      color: const Color(0xff767676),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Gilroy",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.left)
                            ],
                          ),
                        ),
                        controller.isAlreadyInWhishlist(product.id) == true
                            ? GestureDetector(
                                onTap: () {
                                  controller.removeFromWhishlist(product.id);
                                },
                                child: Image.asset(
                                  'assets/likeIconFilled.png',
                                  width: 25,
                                ),
                              )
                            : GestureDetector(
                                onTap: () {
                                  controller.addWhishlist(product.id);
                                },
                                child: Image.asset(
                                  'assets/likeIcon.png',
                                  width: 25,
                                ),
                              )
                      ],
                    )
                  ],
                ))),
      );
    });
  }
}
