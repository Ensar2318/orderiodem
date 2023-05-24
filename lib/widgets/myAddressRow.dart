import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/myButton.dart';

class MyAddressRow extends GetView<UserController> {
  final String title;
  final String address;
  final int id;
  const MyAddressRow({required this.title, required this.address, required this.id}) : super();

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 15),
        alignment: Alignment.bottomCenter,
        width: Get.width * 0.9,
        height: 125,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffdbdbdb), width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/locationIcon.png',
                  width: 24,
                  color: MyColors.orange,
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  width: Get.width * 0.56,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          style: TextStyle(
                              color: Color(0xffe88a34),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Gilroy",
                              fontStyle: FontStyle.normal,
                              fontSize: 18.0),
                          textAlign: TextAlign.left),
                      SizedBox(
                        height: 5,
                      ),
                      Text(address,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                              color: Color(0xff040413),
                              fontWeight: FontWeight.w500,
                              fontFamily: "Gilroy",
                              fontStyle: FontStyle.normal,
                              fontSize: 16.0),
                          textAlign: TextAlign.left)
                    ],
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                Get.defaultDialog(
                  title: 'Delete Address',
                  titlePadding: const EdgeInsets.only(top: 20),
                  titleStyle: TextStyle(color: MyColors.watermelon),
                  content: Container(padding: EdgeInsets.all(15), child: Text('Möchten Sie diese Adresse wirklich löschen?')),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: MyButton(label: 'Stornieren', width: Get.width * 0.27, color: MyColors.watermelon),
                    ),
                    TextButton(
                      onPressed: () {
                        controller.removeAddress(id.toString());
                        Get.back();
                        Get.snackbar('Erfolg', 'Die Adresse wurde gelöscht.');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: MyButton(
                          label: 'löschen',
                          width: Get.width * 0.27,
                        ),
                      ),
                    ),
                  ],
                );
              },
              child: Image.asset(
                'assets/more.png',
                width: 40,
              ),
            ),
          ],
        ));
  }
}
