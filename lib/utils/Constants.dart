import 'package:flutter/material.dart';
import 'package:zwerge/utils/Colors.dart';

TextStyle inputHintText =
    TextStyle(color: MyColors.warmGrey, fontWeight: FontWeight.w500, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0);

TextStyle inputLabelText =
    TextStyle(color: MyColors.warmGrey, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0);

TextStyle inputText =
    TextStyle(color: MyColors.blacktwo, fontWeight: FontWeight.w500, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0);

var shopID = 25;

TextStyle tabText = TextStyle(color: MyColors.white, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 17.0);

TextStyle buttonText(color) {
  return TextStyle(color: color, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 16.0);
}

TextStyle menuText(color) {
  return TextStyle(color: color, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 15.0);
}
