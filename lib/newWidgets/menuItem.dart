import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../utils/Colors.dart';
import '../utils/Constants.dart';

class menuItem extends StatelessWidget {
  final String text;
  final double mb;
  final IconData icon;
  final IconData lastIcon;
  final Color textColor;
  final bool hideLastIcon;

  const menuItem({
    Key? key,
    required this.text,
    required this.icon,
    this.lastIcon = Icons.chevron_right,
    this.mb = 12,
    this.textColor = MyColors.black,
    this.hideLastIcon = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));

    return Container(
        height: 55,
        margin: EdgeInsets.only(bottom: mb),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 30,
            ),
            SizedBox(
              width: 15,
            ),
            // Group 545
            Text(text, style: menuText(textColor)),
            Spacer(),
            if (!hideLastIcon)
              Icon(
                lastIcon,
                color: primaryColor,
                size: 35,
              ),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(18)),
            boxShadow: [BoxShadow(color: const Color(0xffe6e6e6), offset: Offset(0, 15), blurRadius: 30, spreadRadius: 0)],
            gradient: LinearGradient(
                begin: Alignment(0.08409727364778519, 0.43446260690689087),
                end: Alignment(0.46691903471946716, 0.45219510793685913),
                colors: [const Color(0xffffffff), const Color(0xffffffff)])));
  }
}
