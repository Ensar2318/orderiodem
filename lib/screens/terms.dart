import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:zwerge/utils/Colors.dart';

class Terms extends StatelessWidget {
  final data;
  final title;
  final color;
  const Terms({Key? key, this.data, this.title, this.color = MyColors.watermelon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: Column(
          children: [
            Container(
              height: 70,
              color: color,
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
                    width: Get.width * 0.6,
                    child: Text(title.toString(),
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
            Expanded(
              child: SingleChildScrollView(
                  child: data != null
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [Html(data: data)],
                          ),
                        )
                      : Container()),
            ),
          ],
        ),
      )),
    );
  }
}
