import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/models/addressModel.dart';
import 'package:zwerge/widgets/myButton.dart';

class myAddressSlideUpPanel extends GetView<ProductController> {
  const myAddressSlideUpPanel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    Get.put(UserController());
    return Container(
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(24.0)), boxShadow: [
        BoxShadow(
          blurRadius: 20.0,
          color: Colors.grey,
        ),
      ]),
      margin: const EdgeInsets.all(24.0),
      child: GetBuilder<UserController>(builder: (userController) {
        return Column(
          children: [
            GestureDetector(
                onTap: () {
                  Future.delayed(const Duration(milliseconds: 100), () {
                    controller.hideAddressPanel();
                    controller.hideAddressPanelDetail();
                  });
                },
                child: Container(margin: EdgeInsets.all(15), child: Align(alignment: Alignment.centerRight, child: Icon(Icons.close)))),
            Container(
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: const Text("Select Address",
                    style: TextStyle(
                        color: Color(0xff040413), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 24.0),
                    textAlign: TextAlign.left),
              ),
            ),
            Container(
              height: Get.height * 0.3,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: userController.addresses.length,
                  itemBuilder: (BuildContext context, int index) {
                    return newAddressRow(userController.addresses[index], userController);
                  }),
            )
            // newAddressRow('Home', 'Livingston New Jersey 07039, USA', controller, 1),
            ,
            SizedBox(
              height: 10,
            ),
            //  newAddressRow('Work', '95 Lvovi St, Tbilisi 0160', controller, 2),
            SizedBox(
              height: 10,
            ),
            // newAddressRow('Otto’s home', 'Richard Gere street 9', controller, 3),
            Spacer(),
            Container(
              margin: EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () {
                        Future.delayed(const Duration(milliseconds: 100), () {
                          controller.hideAddressPanel();
                        });
                        // controller.addToCart(controller.slideUpProduct, controller.variant, true);
                      },
                      child: MyButton(label: 'Select Address', width: Get.width * 0.8)),
                ],
              ),
            )
          ],
        );
      }),
    );
  }

  GetBuilder newAddressRow(AddressModel address, UserController controller) {
    return GetBuilder<UserController>(builder: (userController) {
      return Container(
        child: Row(
          children: [
            Radio(
                activeColor: Colors.black,
                value: address,
                groupValue: controller.selectedAddress,
                onChanged: (newValue) {
                  controller.selectedAddress = newValue as AddressModel?;
                  controller.update();
                }),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(address.label,
                    style: const TextStyle(
                        color: const Color(0xffe88a34),
                        fontWeight: FontWeight.w600,
                        fontFamily: "Gilroy",
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0),
                    textAlign: TextAlign.left),
                SizedBox(
                  height: 3,
                ),
                Container(
                  width: Get.width * 0.70,
                  child: Expanded(
                    child: Text(address.address,
                        style: TextStyle(
                            color: Color(0xff494949), fontWeight: FontWeight.w400, fontFamily: "DMSans", fontStyle: FontStyle.normal, fontSize: 16.0),
                        textAlign: TextAlign.left),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
