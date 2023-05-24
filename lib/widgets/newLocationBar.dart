import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/models/addressModel.dart';

class newLocationBar extends StatelessWidget {
  final List<AddressModel> addresses;
  newLocationBar({
    Key? key,
    required this.addresses,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: Get.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: Get.width * 0.9,
              height: 48,
              margin: EdgeInsets.only(left: Get.width * 0.05, top: 15, bottom: 15),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: const Color(0xffe0e0e0), width: 1),
              ),
              child: Row(
                children: [
                  Container(margin: const EdgeInsets.only(left: 10, right: 10), child: Image.asset('assets/locationIcon.png', width: 22)),
                  Text(addresses[0].address.length > 25 ? addresses[0].address.substring(0, 25) + '...' : addresses[0].address,
                      style: TextStyle(
                          color: Color(0xff040413), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 14.0),
                      textAlign: TextAlign.left),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(7),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        border: Border.all(color: const Color(0xffe0e0e0), width: 1),
                        color: Colors.black),
                    child: const Text("10 mins",
                        style: TextStyle(
                            color: Color(0xffffffff), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 14.0),
                        textAlign: TextAlign.left),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
