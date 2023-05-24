import 'package:flutter/material.dart';

class MyProfileRow extends StatefulWidget {
  final String label;
  final String icon;
  const MyProfileRow({required this.label, required this.icon}) : super();
  @override
  State<MyProfileRow> createState() => _MyProfileRowState();
}

class _MyProfileRowState extends State<MyProfileRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            widget.icon != ''
                ? Image.asset(
                    widget.icon,
                    height: 23,
                  )
                : Container(),
            widget.icon != ''
                ? SizedBox(
                    width: 15,
                  )
                : Container(),
            Text(widget.label,
                style: TextStyle(
                    color: Color(0xff040413), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 18.0),
                textAlign: TextAlign.left),
          ],
        ),
        Image.asset(
          'assets/rightArrow.png',
          height: 15,
        )
      ],
    );
  }
}
