import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/models/productModel.dart';
import 'package:zwerge/newWidgets/newProductCart.dart';
import 'package:zwerge/utils/Colors.dart';

class newCategoryList extends StatelessWidget {
  final ProductModel data;

  const newCategoryList({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.find<ProductController>();
    final box = GetStorage();
    Color secondaryColor = HexColor.fromHex(box.read('secondaryColor'));
    Color textColor = HexColor.fromHex(box.read('textColor'));

    GlobalObjectKey globalKey = new GlobalObjectKey(new UniqueKey());
    controller.categoryKey.add(globalKey);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            data.image != null
                ? CachedNetworkImage(
                    width: Get.width,
                    height: Get.width * 0.3,
                    imageUrl: 'https://cdn.orderio.de/images/categories/' + data.image.toString(),
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) {
                      return Image.network('https://cdn.orderio.de/images/products/placeholder.jpg');
                    },
                    fit: BoxFit.cover,
                  )
                : Container(),
            Container(),
            Container(
              key: globalKey,
              width: Get.width,
              height: Get.width * 0.3,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      stops: [0.0, 1.1],
                      begin: Alignment(0, 0),
                      end: Alignment(0.9726977348327637, 0.7281810641288757),
                      colors: [secondaryColor, Colors.transparent])),
              child: Container(
                margin: EdgeInsets.only(left: Get.width * 0.1, top: Get.width * 0.1),
                child: Text(data.name,
                    style:
                        TextStyle(color: textColor, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 20.0),
                    textAlign: TextAlign.left),
              ),
            ),
          ],
        ),
        data.products.length > 0
            ? ListView.builder(
                itemCount: data.products.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return newProductCart(data: data.products[index], index: index, other: data.products, catname: data.name);
                },
              )
            : Container(),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
