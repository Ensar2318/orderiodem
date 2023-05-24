import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Colors.dart';

class newCategoryBox extends StatelessWidget {
  final bool isSelected;
  final String title;
  final int index;
  final ScrollController scrolController;
  final int currentIndex;

  newCategoryBox({
    Key? key,
    required this.isSelected,
    required this.title,
    required this.index,
    required this.scrolController,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("object");

    ProductController controller = Get.find<ProductController>();
    return GestureDetector(
      onTap: () {
        double dy = 0.0;
        print("click");

        final box = GetStorage();
        dy = box.read('offset' + index.toString());

        var yukseklik = dy < 0 ? 0 : dy;
        scrolController.animateTo(
          yukseklik.toDouble() - 110,
          duration: Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 8.0, right: 8.0),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)), color: index == currentIndex ? MyColors.watermelon : MyColors.softWhite),
        child: Center(
          child: Text(title,
              style: TextStyle(
                  color: index == currentIndex ? Colors.white : MyColors.darkText,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Avenir",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.0),
              textAlign: TextAlign.left),
        ),
      ),
    );
  }
}
