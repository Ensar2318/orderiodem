import 'package:flutter/material.dart';
import 'package:zwerge/utils/Colors.dart';

class MyButton extends StatefulWidget {
  final String label;
  final Color color;
  final double width;
  MyButton({required this.label, required this.width, this.color = MyColors.black}) : super();

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        width: widget.width,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            boxShadow: const [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
            color: widget.color),
        child: Center(
          child: Text(widget.label,
              style: const TextStyle(
                  color: MyColors.white, fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 16.0),
              textAlign: TextAlign.center),
        ));
  }
}
