import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/models/areaModel.dart';
import 'package:zwerge/screens/addresses.dart';
import 'package:zwerge/screens/billingAddresses.dart';
import 'package:zwerge/screens/home.dart';
import 'package:zwerge/screens/notifyMe.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/utils/helper.dart';
import 'package:zwerge/widgets/buttonGlobal.dart';
import 'package:zwerge/widgets/inputGlobal.dart';
import 'package:zwerge/widgets/myTextField.dart';

class Address extends GetView<UserController> {
  final String returnPage;

  final int type;
  var groupvalue;

  bool first = true;
  Address({required this.returnPage, required this.type, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));

    return SafeArea(
      child: Scaffold(
        body: Container(
          color: MyColors.white,
          child: GetBuilder<UserController>(builder: (controller) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                  color: primaryColor,
                  child: // Adreslerim
                      Row(
                    children: [
                      // Rectangle 15
                      GestureDetector(
                        onTap: () => {Get.to(Addresses())},
                        child: Container(
                            width: 40,
                            height: 40,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            child: Icon(
                              Icons.chevron_left,
                              color: primaryColor,
                              size: 30,
                            ),
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: const Color(0xffffffff))),
                      ),

                      Text("Zurück",
                          style: const TextStyle(
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w900,
                              fontFamily: "Avenir",
                              fontStyle: FontStyle.normal,
                              fontSize: 18.0),
                          textAlign: TextAlign.left),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                          color: MyColors.white,
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 35,
                                ),
                                const Text("Geben Sie Ihre Adresse ein",
                                    style: TextStyle(
                                        color: Color(0xff040413),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Gilroy",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 26.0),
                                    textAlign: TextAlign.left),
                                const SizedBox(
                                  height: 20,
                                ),
                                inputGlobal(
                                  hint: "Adresse",
                                  label: "Adresse",
                                  radius: 10,
                                  icon: "map",
                                  searchController: controller.addressController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                inputGlobal(
                                    hint: "Treppenhaus / Wohnung / Etage / Sonstiges",
                                    label: "Treppenhaus / Wohnung / Etage / Sonstiges",
                                    radius: 10,
                                    icon: "map",
                                    searchController: controller.apartmentController),
                                const SizedBox(
                                  height: 20,
                                ),
                                controller.areas != null
                                    ? Container(
                                        margin: const EdgeInsets.only(top: 5, right: 2, left: 2),
                                        width: Get.width * 0.9,
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(color: Colors.black54, blurRadius: 4.0, offset: Offset(0.0, 1.2)),
                                            ],
                                            color: Colors.white),
                                        child: DropdownButton<AreaModel>(
                                          value: controller.selectedArea ?? null,
                                          hint: const Text('Please select a postal code',
                                              style: TextStyle(
                                                  color: Color(0xff000000),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Gilroy",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0),
                                              textAlign: TextAlign.left),
                                          onChanged: (AreaModel? newValue) {
                                            controller.selectedArea = newValue;
                                            controller.update();
                                          },
                                          items: controller.areas
                                              .map<DropdownMenuItem<AreaModel>>((AreaModel? value) => DropdownMenuItem<AreaModel>(
                                                    value: value,
                                                    child: Text(value!.postal + ' - ' + value.city,
                                                        style: const TextStyle(
                                                            color: Color(0xff000000),
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "Gilroy",
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: 17.0),
                                                        textAlign: TextAlign.left),
                                                  ))
                                              .toList(),
                                          // add extra sugar..
                                          icon: Image.asset(
                                            'assets/downArrow.png',
                                            width: 15,
                                          ),
                                          isExpanded: true,
                                          iconSize: 42,
                                          underline: const SizedBox(),
                                        ),
                                      )
                                    : Container(),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Radio(
                                              activeColor: Colors.black,
                                              value: "Home",
                                              groupValue: controller.addressLabel,
                                              onChanged: (newValue) {
                                                controller.addressLabel = newValue;
                                                controller.otherAddressVisible = false;
                                                controller.update();
                                              }),
                                          const Text("Privat",
                                              style: TextStyle(
                                                  color: Color(0xff494949),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "DMSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0),
                                              textAlign: TextAlign.left)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Radio(
                                              activeColor: Colors.black,
                                              value: "Arbeiten",
                                              groupValue: controller.addressLabel,
                                              onChanged: (newValue) {
                                                controller.addressLabel = newValue;
                                                controller.otherAddressVisible = false;
                                                controller.update();
                                              }),
                                          const Text("Arbeit",
                                              style: TextStyle(
                                                  color: Color(0xff494949),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "DMSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0),
                                              textAlign: TextAlign.left)
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Radio(
                                              activeColor: Colors.black,
                                              value: "Andere",
                                              groupValue: controller.addressLabel,
                                              onChanged: (newValue) {
                                                controller.addressLabel = newValue;
                                                controller.otherAddressVisible = true;
                                                controller.update();
                                              }),
                                          const Text("Andere",
                                              style: TextStyle(
                                                  color: Color(0xff494949),
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: "DMSans",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 16.0),
                                              textAlign: TextAlign.left)
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: controller.otherAddressVisible,
                                  child: MyTextField(
                                    hidden: false,
                                    label: 'Adressname',
                                    searchController: controller.otherLabelController,
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
                  child: GestureDetector(
                    onTap: () {
                      //check only address field is empty
                      if (controller.addressController!.text.isEmpty || controller.selectedArea == null) {
                        Get.snackbar(
                          'Fehler',
                          'Bitte alle Felder ausfüllen.',
                          icon: Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        if (controller.otherAddressVisible) {
                          controller.addAddress(controller.addressController!.text + ' ' + controller.apartmentController!.text,
                              controller.selectedArea!.id, controller.otherLabelController!.text, type);
                        } else {
                          controller.addAddress(controller.addressController!.text + ' ' + controller.apartmentController!.text,
                              controller.selectedArea!.id, controller.addressLabel, type);
                        }
                        if (returnPage == 'home') {
                          Get.to(Home());
                        } else if (returnPage == 'billing') {
                          Get.to(BillingAddresses());
                        } else {
                          Get.to(Addresses());
                        }
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 15),
                      child: buttonGlobal(
                        text: 'Speichern',
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  showFirstPopup(BuildContext? maincontext) async {
    await Future.delayed(Duration(milliseconds: 50));
    return showDialog(
        context: maincontext!,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(12.0))),
            contentPadding: EdgeInsets.zero,
            content: Container(
              width: screenW(0.9, context),
              padding: const EdgeInsets.all(20),
              height: 400,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Container(
                      //  margin: const EdgeInsets.all(10),
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          boxShadow: [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
                          color: Color(0xffdbdbdb)),
                      child: const Center(
                        child: Text("😞",
                            style: TextStyle(
                                color: Color(0xff000000),
                                fontWeight: FontWeight.w600,
                                fontFamily: "Gilroy",
                                fontStyle: FontStyle.normal,
                                fontSize: 28.0),
                            textAlign: TextAlign.left),
                      ),
                    ),
                  ), // Hello there
                  const SizedBox(height: 10),
                  const Text("Oh no!",
                      style: TextStyle(
                          color: Color(0xff000000), fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 24.0),
                      textAlign: TextAlign.left),
                  const SizedBox(height: 10),
                  const Text("Delievery isn’t avaliable for your adress.\nWe will notify you when come to your area.",
                      style: TextStyle(
                          color: Color(0xff767676), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 14.0),
                      textAlign: TextAlign.center),

                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () => Get.to(NotifyMe()),
                    child: const Text("Notify when location will be available",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Color(0xffe88a34),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Gilroy",
                            fontStyle: FontStyle.normal,
                            fontSize: 14.0),
                        textAlign: TextAlign.center),
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                        margin: const EdgeInsets.only(top: 40),
                        width: screenW(0.85, context),
                        height: 48,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xffdbdbdb)),
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            boxShadow: [const BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
                            color: const Color(0xffffffff)),
                        child: const Center(
                          child: Text("Change Location",
                              style: TextStyle(
                                  color: MyColors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Gilroy",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                              textAlign: TextAlign.center),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      // Get.to(Home());
                    },
                    child: Container(
                        margin: const EdgeInsets.only(top: 15),
                        width: screenW(0.85, context),
                        height: 48,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                            boxShadow: [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
                            color: Color(0xffe88a34)),
                        child: const Center(
                          child: Text("Continue",
                              style: TextStyle(
                                  color: MyColors.white,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Gilroy",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0),
                              textAlign: TextAlign.center),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
