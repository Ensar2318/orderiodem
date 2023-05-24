import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPaymentRow extends StatefulWidget {
  final String type;
  final String cardNumber;
  final Color color;
  const MyPaymentRow({required this.type, required this.cardNumber, required this.color}) : super();
  @override
  State<MyPaymentRow> createState() => _MyPaymentRowState();
}

class _MyPaymentRowState extends State<MyPaymentRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        alignment: Alignment.bottomCenter,
        width: Get.width * 0.9,
        height: 65,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            boxShadow: [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
            color: widget.color),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                widget.type == 'visa' ? Image.asset('assets/visa.png') : Image.asset('assets/master.png'),
                SizedBox(
                  width: 10,
                ),
                Text(widget.cardNumber,
                    style: const TextStyle(
                        color: const Color(0xff040413),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Gilroy",
                        fontStyle: FontStyle.normal,
                        fontSize: 14.0),
                    textAlign: TextAlign.left),
              ],
            ),
            Image.asset('assets/more.png'),
          ],
        ));
  }
}
