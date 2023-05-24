import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/myButton.dart';
import 'package:zwerge/widgets/myPaymentRow.dart';

class Payment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Row(
                  children: [
                    Image.asset('assets/backIcon.png', width: 8),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text("Back",
                        style: TextStyle(
                            color: Color(0xff040413), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 16.0),
                        textAlign: TextAlign.left)
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              const Text("Payment",
                  style: TextStyle(
                      color: Color(0xff040413), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 28.0),
                  textAlign: TextAlign.left),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: const [
                  MyPaymentRow(type: 'visa', cardNumber: '**** 0098', color: MyColors.paymentGrey),
                  MyPaymentRow(type: 'master', cardNumber: '**** 0024', color: MyColors.white),
                  MyPaymentRow(type: 'visa', cardNumber: '**** 5399', color: MyColors.paymentGrey),
                  MyPaymentRow(type: 'visa', cardNumber: '**** 7644', color: MyColors.white),
                ],
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {},
                    child: MyButton(
                      label: 'Add Method',
                      width: Get.width,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
