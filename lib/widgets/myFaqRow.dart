import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Colors.dart';

class MyFaqRow extends GetView<ProductController> {
  final String question;
  final String answer;
  const MyFaqRow({required this.question, required this.answer}) : super();

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
        width: Get.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffdbdbdb), width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question,
                style: TextStyle(
                    color: MyColors.pastelRed, fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 18.0),
                textAlign: TextAlign.left),
            SizedBox(
              height: 5,
            ),
            Text(answer,
                overflow: TextOverflow.ellipsis,
                maxLines: 20,
                style: TextStyle(
                    color: Color(0xff040413), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 16.0),
                textAlign: TextAlign.left)
          ],
        ));
  }
}
