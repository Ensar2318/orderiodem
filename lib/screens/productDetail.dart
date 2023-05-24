import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/models/productModel.dart';
import 'package:zwerge/newWidgets/newMyButton.dart';
import 'package:zwerge/utils/Colors.dart';

class ProductDetail extends GetView<ProductController> {
  final items = ['Allergens', 'Ingredients', 'One', 'Two', 'Three', 'Four'];
  String selectedValue = 'Allergens';
  String selectedValue2 = 'Ingredients';

  double allergensHeight = 40;

  final product;
  final catname;
  final alsolike;
  final index;
  ProductDetail(this.product, this.catname, this.alsolike, this.index, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());

    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    Color buttonColor = HexColor.fromHex(box.read('buttonColor'));
    controller.variant = null;
    List<int?> options = [];
    var variantnames = "";
    for (var element in product.variants) {
      variantnames += element.name + ", ";
    }
    controller.getProductInfo(int.parse(product.id));
    controller.productDetailQuantitiy = 1;

    if (product!.extras != null && product.extras!.length > 0) {
      for (var i = 0; i < product!.extras!.length; i++) {
        product!.extras[i].check = false;
      }
    }

    if (product.options != null) {
      for (var i = 0; i < product.options.length; i++) {
        options.add(null);
      }
    }

    return Scaffold(
      body: GetBuilder<ProductController>(builder: (controller) {
        return Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 20),
              height: 100,
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
                          color: MyColors.watermelon,
                          size: 30,
                        ),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: const Color(0xffffffff))),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: Get.width * 0.6,
                    child: Text(product.name,
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
            SizedBox(
              height: 20,
            ),
            Container(
              width: Get.width * 0.3,
              child: product.image != null
                  ? CachedNetworkImage(
                      imageUrl: 'https://cdn.orderio.de/images/products/' + product.image,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) {
                        return Image.network('https://cdn.orderio.de/images/products/placeholder.jpg');
                      },
                      fit: BoxFit.contain,
                    )
                  : Container(),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: Get.width * 0.05, top: Get.width * 0.05, right: Get.width * 0.01),
                margin: EdgeInsets.only(left: Get.width * 0.03, top: Get.width * 0.03, right: Get.width * 0.03),
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(19)),
                    border: Border.all(color: const Color(0xfff7f6f6), width: 1),
                    boxShadow: [BoxShadow(color: const Color(0x17000000), offset: Offset(0, 0), blurRadius: 15, spreadRadius: 0)],
                    color: const Color(0xffffffff)),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(product.name!,
                                          style: const TextStyle(
                                              color: MyColors.darkText,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Avenir",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.0),
                                          textAlign: TextAlign.left),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(product.price.toString(),
                                          style: const TextStyle(
                                              color: MyColors.darkText,
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Avenir",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 22.0),
                                          textAlign: TextAlign.left)
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: 349, height: 0, decoration: BoxDecoration(border: Border.all(color: const Color(0xfff4f4f4), width: 1))),
                              SizedBox(
                                height: 10,
                              ),
                              Text(product.shortdesc != null ? product.shortdesc! : "",
                                  style: const TextStyle(
                                      color: MyColors.darkText,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Avenir",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.left),
                              SizedBox(
                                height: 5,
                              ),
                              Text("Wahl aus: " + variantnames,
                                  style: const TextStyle(
                                      color: MyColors.darkText,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "ZurichCnBT",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  textAlign: TextAlign.left),
                              if (product.extras != null && product.extras.length > 0) SizedBox(height: 30),
                              if (product.extras != null && product.extras.length > 0)
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: const Text("Extras",
                                      style: TextStyle(
                                          color: Color(0xff040413),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Gilroy",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 24.0),
                                      textAlign: TextAlign.left),
                                ),
                              SizedBox(height: 10),
                              if (product.extras != null && product.extras.length > 0)
                                MediaQuery.removePadding(
                                  removeTop: true,
                                  context: context,
                                  child: Container(
                                    height: 225,
                                    child: Scrollbar(
                                      thumbVisibility: true,
                                      child: ListView.builder(
                                          physics: const AlwaysScrollableScrollPhysics(),
                                          itemCount: product.extras.length,
                                          itemBuilder: (context, index) {
                                            return CheckboxListTile(
                                              title: Text(product!.extras[index].label + ' - ' + product!.extras[index].price.toString()),
                                              value: product!.extras[index].check,
                                              onChanged: (bool? value) {
                                                product!.extras[index].check = value!;
                                                controller.update();
                                              },
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                              for (int i = 0; i < product!.options.length; i++)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30),
                                    Text(product.options[i]["title"],
                                        style: const TextStyle(
                                            color: MyColors.darkText,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Gilroy",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18.0),
                                        textAlign: TextAlign.left),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                                      width: Get.width * 0.9,
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(color: Colors.black54, blurRadius: 4.0, offset: Offset(0.0, 1.2)),
                                          ],
                                          color: Colors.white),
                                      child: DropdownButton<int>(
                                        value: options[i] ?? null,
                                        hint: const Text('Bitte auswählen',
                                            style: TextStyle(
                                                color: Color(0xff000000),
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Gilroy",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.left),
                                        onChanged: (int? newValue) {
                                          print(newValue);

                                          options[i] = newValue;

                                          controller.update();
                                        },
                                        items: [
                                          DropdownMenuItem<int>(
                                            value: null,
                                            child: const Text('Bitte auswählen',
                                                style: TextStyle(
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Gilroy",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.left),
                                          ),
                                          for (var x = 0; x < product.options[i]["options"].length; x++)
                                            DropdownMenuItem<int>(
                                              value: x,
                                              child: Text(product.options[i]["options"][x]["text"],
                                                  style: const TextStyle(
                                                      color: Color(0xff000000),
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Gilroy",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 16.0),
                                                  textAlign: TextAlign.left),
                                            ),
                                        ],

                                        // add extra sugar..
                                        icon: Image.asset(
                                          'assets/downArrow.png',
                                          width: 15,
                                        ),
                                        isExpanded: true,
                                        iconSize: 42,
                                        underline: const SizedBox(),
                                      ),
                                    ),
                                  ],
                                ),
                              if (product.variants != null && product.variants.length > 0)
                                Container(
                                  child: Container(
                                    margin: const EdgeInsets.all(10),
                                    child: const Text("Varianten",
                                        style: TextStyle(
                                            color: Color(0xff040413),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Gilroy",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 24.0),
                                        textAlign: TextAlign.left),
                                  ),
                                ),
                              product.variants != null
                                  ? product.variants.length > 0
                                      ? Container(
                                          margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
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
                                            hint: const Text('Bitte wähle eine Option',
                                                style: TextStyle(
                                                    color: Color(0xff000000),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Gilroy",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.left),
                                            onChanged: (Variant? newValue) {
                                              controller.variant = newValue;
                                              if (controller.variant != null && controller.variant!.extras.length > 0) {
                                                for (var i = 0; i < controller.variant!.extras.length; i++) {
                                                  controller.variant!.extras[i].check = false;
                                                }
                                              }
                                              controller.update();
                                            },
                                            items: product.variants
                                                .map<DropdownMenuItem<Variant>>((Variant? value) => DropdownMenuItem<Variant>(
                                                      value: value,
                                                      child: Row(
                                                        children: [
                                                          Text(value!.name,
                                                              style: const TextStyle(
                                                                  color: Color(0xff000000),
                                                                  fontWeight: FontWeight.w500,
                                                                  fontFamily: "Gilroy",
                                                                  fontStyle: FontStyle.normal,
                                                                  fontSize: 17.0),
                                                              textAlign: TextAlign.left),
                                                          SizedBox(width: 10),
                                                          Text(value.price.toString(),
                                                              style: const TextStyle(
                                                                  color: Color(0xff000000),
                                                                  fontWeight: FontWeight.w500,
                                                                  fontFamily: "Gilroy",
                                                                  fontStyle: FontStyle.normal,
                                                                  fontSize: 17.0),
                                                              textAlign: TextAlign.left),
                                                        ],
                                                      ),
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
                                      : Container()
                                  : Container(),
                              if (product.variants != null && product.variants.length > 0)
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  child: const Text("Extras",
                                      style: TextStyle(
                                          color: Color(0xff040413),
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Gilroy",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 24.0),
                                      textAlign: TextAlign.left),
                                ),
                              controller.variant != null
                                  ? controller.variant!.extras.length > 0
                                      ? MediaQuery.removePadding(
                                          removeTop: true,
                                          context: context,
                                          child: Container(
                                            height: 225,
                                            child: Scrollbar(
                                              thumbVisibility: true,
                                              child: ListView.builder(
                                                  physics: const AlwaysScrollableScrollPhysics(),
                                                  itemCount: controller.variant!.extras.length,
                                                  itemBuilder: (context, index) {
                                                    return CheckboxListTile(
                                                      title: Text(controller.variant!.extras[index].label +
                                                          ' - ' +
                                                          controller.variant!.extras[index].price.toString()),
                                                      value: controller.variant!.extras[index].check,
                                                      onChanged: (bool? value) {
                                                        controller.variant!.extras[index].check = value!;
                                                        controller.update();
                                                      },
                                                    );
                                                  }),
                                            ),
                                          ),
                                        )
                                      : Container(
                                          margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                                          child: Text('Es gibt keine zusätzliche Auswahl.'))
                                  : Container(
                                      margin: const EdgeInsets.only(top: 10, left: 5, right: 5, bottom: 10),
                                    ),
                              const SizedBox(height: 15),
                            ]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.symmetric(horizontal: 6),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.productDetailQuantitiy <= 1) {
                                        return;
                                      }
                                      controller.productDetailQuantitiy -= 1;
                                      controller.update();
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: MyColors.white,
                                      size: 20,
                                    ),
                                  ),
                                  Expanded(
                                    child: // 5
                                        Text(controller.productDetailQuantitiy.toString(),
                                            style: const TextStyle(
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "Avenir",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 17.0),
                                            textAlign: TextAlign.center),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.productDetailQuantitiy += 1;
                                      controller.update();
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: MyColors.white,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              width: 80,
                              height: 32,
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)), color: buttonColor)),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: GestureDetector(
                                onTap: () {
                                  if (product.options != null && product.options.length > 0) {
                                    for (var option in options) {
                                      if (option == null) {
                                        return;
                                      }
                                    }
                                  }

                                  if (product.variants != null && product.variants.length > 0) {
                                    controller.addToCart(
                                      product,
                                      controller.variant,
                                      true,
                                      quantitiy: controller.productDetailQuantitiy,
                                      options: product.options != null && product.options.length > 0 ? options.toString() : "-1",
                                    );
                                  } else {
                                    controller.addToCart(
                                      product,
                                      controller.variant,
                                      false,
                                      quantitiy: controller.productDetailQuantitiy,
                                      options: product.options != null && product.options.length > 0 ? options.toString() : "-1",
                                    );
                                  }

                                  Get.back();
                                },
                                child: Opacity(
                                  opacity: _isVariantSelected(product, options) ? 1 : 0.5,
                                  child: NewMyButton(color: buttonColor, label: 'Warenkorb', width: Get.width * 0.85),
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Widget getTextWidgets(List<String> strings) {
    List<Widget> list = <Widget>[];
    for (var i = 0; i < strings.length; i++) {
      list.add(Text("\u2022  " + strings[i],
          style: TextStyle(color: Color(0xff5c5c5c), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 14.0),
          textAlign: TextAlign.left));
    }
    return Column(
      children: list,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
    );
  }

  // function return false
  bool _isVariantSelected(product, options) {
    if (product.options != null && product.options.length > 0) {
      for (var option in options) {
        if (option == null) {
          return false;
        }
      }
    }
    if (product.variants != null && product.variants.length > 0 && controller.variant == null) {
      return false;
    }
    return true;
  }
}
