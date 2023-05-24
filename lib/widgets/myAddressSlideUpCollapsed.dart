import 'package:flutter/material.dart';
import 'package:zwerge/utils/Colors.dart';

class myAddressSlideUpCollapsed extends StatelessWidget {
  const myAddressSlideUpCollapsed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: MyColors.orange,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      child: const Center(
        child: Text(
          "Please select address",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
