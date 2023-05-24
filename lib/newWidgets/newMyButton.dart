import 'package:flutter/material.dart';
import 'package:zwerge/utils/Colors.dart';

class NewMyButton extends StatefulWidget {
  final String label;
  final Color color;
  final double width;
  NewMyButton({required this.label, required this.width, this.color = MyColors.pastelRed}) : super();

  @override
  State<NewMyButton> createState() => _NewMyButtonState();
}

class _NewMyButtonState extends State<NewMyButton> {
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
