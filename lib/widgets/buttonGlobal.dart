import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/utils/Colors.dart';

import '../utils/Constants.dart';

class buttonGlobal extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color color;
  final double mt;
  final double mb;
  final double rounded;

  const buttonGlobal({
    Key? key,
    required this.text,
    this.color = MyColors.watermelon,
    this.textColor = MyColors.white,
    this.mt = 0,
    this.mb = 0,
    this.rounded = 10,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Color buttoncolor = HexColor.fromHex(box.read('buttonColor'));
    return Container(
        margin: EdgeInsets.only(top: mt, bottom: mb),
        alignment: Alignment.center,
        child: Text(text, style: buttonText(textColor)),
        height: 40,
        decoration: BoxDecoration(color: buttoncolor, borderRadius: BorderRadius.all(Radius.circular(rounded))));
  }
}
