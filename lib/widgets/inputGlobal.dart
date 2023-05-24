import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/utils/Colors.dart';

import '../utils/Constants.dart';

class inputGlobal extends StatelessWidget {
  final String hint;
  final String label;
  final double mt;
  final double mb;
  final double radius;
  final String icon;
  final int lastIcon;
  final TextEditingController? searchController;
  final bool isPassword;
  final String area;
  final bool readonly;
  final bool numberType;
  final double height;
  final int maxLines;

  inputGlobal({
    Key? key,
    required this.hint,
    required this.label,
    this.mt = 0,
    this.mb = 0,
    required this.radius,
    this.icon = "",
    this.lastIcon = 0,
    this.searchController,
    this.isPassword = false,
    this.area = "",
    this.numberType = false,
    this.readonly = false,
    this.height = 50,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, IconData> map = {
      'email': Icons.email_outlined,
      'key': Icons.vpn_key,
      'user': Icons.person_outline,
      'phone': Icons.phone,
      'map': Icons.map,
    };
    List<IconData> _icons = [
      Icons.email_outlined,
    ];
    return Container(
      margin: EdgeInsets.only(bottom: mb, top: mt),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != "")
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                label,
                style: inputLabelText,
              ),
            ),
          Container(
            height: height,
            decoration: BoxDecoration(
              color: MyColors.softWhite,
              borderRadius: BorderRadius.all(Radius.circular(radius)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (icon != "")
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Icon(
                      map[icon],
                      color: MyColors.softGrey,
                    ),
                  ),
                Expanded(
                  child: TextField(
                    style: inputText,
                    obscuringCharacter: "*",
                    maxLines: this.maxLines,
                    obscureText: isPassword,
                    readOnly: readonly,
                    keyboardType: numberType ? TextInputType.number : TextInputType.text,
                    onChanged: (value) {
                      if (area == "checkout") {
                        ProductController productController = Get.find();
                        productController.update();
                      }
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: inputHintText,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if (lastIcon == 1)
                  Icon(
                    Icons.check,
                    color: MyColors.watermelon,
                  )
                else if (lastIcon == 2)
                  Icon(
                    Icons.remove_red_eye_sharp,
                    color: MyColors.warmGrey,
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
