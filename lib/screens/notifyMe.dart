import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/screens/createAccount.dart';
import 'package:zwerge/widgets/myButton.dart';
import 'package:zwerge/widgets/myTextField.dart';

class NotifyMe extends StatefulWidget {
  const NotifyMe({Key? key}) : super(key: key);

  @override
  State<NotifyMe> createState() => _NotifyMeState();
}

class _NotifyMeState extends State<NotifyMe> {
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
              const Text("Notify",
                  style: TextStyle(
                      color: Color(0xff040413), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 28.0),
                  textAlign: TextAlign.left),
              const SizedBox(
                height: 20,
              ),
              MyTextField(
                hidden: false,
                label: 'Email',
                prefixIcon: null,
              ),
              MyTextField(
                hidden: false,
                label: 'Postal Code',
                prefixIcon: null,
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(CreateAccount());
                },
                child: MyButton(
                  label: 'Continue',
                  width: Get.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
