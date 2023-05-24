import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBigTextField extends StatefulWidget {
  const MyBigTextField({this.hidden, this.label, this.prefixIcon, this.searchController}) : super();
  final bool? hidden;
  final String? label;
  final Widget? prefixIcon;
  final TextEditingController? searchController;
  @override
  State<MyBigTextField> createState() => _MyBigTextFieldState();
}

class _MyBigTextFieldState extends State<MyBigTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 1,
      height: 150,
      child: widget.hidden == true
          ? TextField(
              controller: widget.searchController,
              obscureText: true,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                  prefixIcon: widget.prefixIcon ?? null,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff777777), width: 1.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff777777), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: widget.label,
                  labelStyle: const TextStyle(color: Color(0xff777777))))
          : TextField(
              maxLines: 5,
              decoration: InputDecoration(
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 25,
                    maxWidth: 25,
                    minHeight: 25,
                    minWidth: 25,
                  ),
                  prefixIcon: widget.prefixIcon ?? null,
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff777777), width: 1.0),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xff777777), width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: widget.label,
                  labelStyle: const TextStyle(color: Color(0xff777777)))),
    );
  }
}
