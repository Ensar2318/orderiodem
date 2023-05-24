import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/screens/profile.dart';
import 'package:zwerge/widgets/inputGlobal.dart';

import '../utils/Colors.dart';
import '../widgets/buttonGlobal.dart';

class AccountSettings extends GetView<UserController> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    // future delay
    Future.delayed(Duration.zero, () {
      controller.passwordController!.text = '';
      controller.firstnameController!.text = controller.loginInfo!.firstname.toString();
      controller.surnameController!.text = controller.loginInfo!.surname.toString();
      controller.phoneController!.text = controller.loginInfo!.phone.toString();
      controller.emailController!.text = controller.loginInfo!.email.toString();
    });

    Get.put(UserController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: MyColors.white,
        body: Column(
          children: [
            Container(
              width: Get.width,
              height: 40,
              margin: EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 20),
              child: Stack(
                children: [
                  Container(
                    height: 40,
                    alignment: Alignment.center,
                    child: Text("Persönliche Daten",
                        style: const TextStyle(
                            color: MyColors.charcoal, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 18.0),
                        textAlign: TextAlign.center),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                          child: Icon(
                            Icons.chevron_left,
                            color: MyColors.watermelon,
                          ),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              boxShadow: [BoxShadow(color: const Color(0xffe5e5e5), offset: Offset(0, 3), blurRadius: 6, spreadRadius: 0)],
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: MyColors.white)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: Get.height,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(38)),
                        boxShadow: [BoxShadow(color: const Color(0x0b000000), offset: Offset(0, 3), blurRadius: 30, spreadRadius: 0)],
                        color: const Color(0xffffffff)),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          GetBuilder<UserController>(builder: (controller) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Please Select'),
                                        content: SizedBox(
                                          height: Get.height / 5,
                                          child: Column(
                                            children: [
                                              ListTile(
                                                leading: const Icon(Icons.camera_alt),
                                                title: const Text('Camera'),
                                                onTap: () async {
                                                  var image = await ImagePicker().pickImage(
                                                    source: ImageSource.camera,
                                                    maxWidth: 256,
                                                    maxHeight: 256,
                                                    imageQuality: 60,
                                                  );
                                                  Navigator.pop(context);
                                                  controller.profilePhoto = File(image!.path);
                                                  controller.addPImage(image);
                                                  controller.update();
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(Icons.photo),
                                                title: const Text('My Photos'),
                                                onTap: () async {
                                                  var image = await ImagePicker().pickImage(
                                                    source: ImageSource.gallery,
                                                    maxWidth: 256,
                                                    maxHeight: 256,
                                                    imageQuality: 60,
                                                  );
                                                  Navigator.pop(context);
                                                  controller.profilePhoto = File(image!.path);
                                                  controller.addPImage(image);
                                                  controller.update();
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                width: Get.width * 0.35,
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: Get.width * 0.35,
                                        height: Get.width * 0.35,
                                        padding: EdgeInsets.all(Get.width * 0.015),
                                        decoration: BoxDecoration(
                                          color: MyColors.white,
                                          boxShadow: [
                                            BoxShadow(color: const Color(0x29000000), offset: Offset(0, 3), blurRadius: 6, spreadRadius: 0),
                                          ],
                                          borderRadius: BorderRadius.circular(150),
                                        ),
                                        child: controller.profilePhoto != null
                                            ? ClipRRect(
                                                borderRadius: BorderRadius.circular(60.0),
                                                child: Image.file(controller.profilePhoto!, fit: BoxFit.cover))
                                            : controller.profilePhotoUrl != null
                                                ? ClipRRect(
                                                    borderRadius: BorderRadius.circular(60.0),
                                                    child: CachedNetworkImage(
                                                      imageUrl: 'https://cdn.orderio.de' + controller.profilePhotoUrl!,
                                                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                                      errorWidget: (context, url, error) {
                                                        return Image.network('https://cdn.orderio.de/images/products/placeholder.jpg');
                                                      },
                                                      fit: BoxFit.cover,
                                                    ))
                                                : ClipRRect(
                                                    borderRadius: BorderRadius.circular(80.0),
                                                    child: Container(child: Image.network('https://cdn.orderio.de/images/products/placeholder.jpg'))),
                                      ),
                                      Container(
                                        width: Get.width * 0.35,
                                        height: Get.width * 0.35,
                                        child: Align(
                                          alignment: Alignment.topRight,
                                          child: Container(
                                              width: 40,
                                              height: 40,
                                              child: Icon(
                                                Icons.add,
                                                color: MyColors.white,
                                                size: 30,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(40)),
                                                  border: Border.all(color: const Color(0xffffffff), width: 3),
                                                  color: MyColors.watermelon)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                          Container(
                            padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                            child: Column(
                              children: [
                                inputGlobal(
                                  hint: "Vorname",
                                  label: "Vorname",
                                  radius: 10,
                                  icon: "user",
                                  mb: 15,
                                  searchController: controller.firstnameController,
                                ),
                                inputGlobal(
                                  hint: "Nachname",
                                  label: "Nachname",
                                  radius: 10,
                                  icon: "user",
                                  mb: 15,
                                  searchController: controller.surnameController,
                                ),
                                inputGlobal(
                                  hint: "Telefonnummer",
                                  label: "Telefonnummer",
                                  radius: 10,
                                  icon: "phone",
                                  mb: 15,
                                  searchController: controller.phoneController,
                                ),
                                inputGlobal(
                                  hint: "E-Mailadresse",
                                  label: "E-Mailadresse",
                                  radius: 10,
                                  icon: "email",
                                  readonly: true,
                                  mb: 15,
                                  searchController: controller.emailController,
                                ),
                                inputGlobal(
                                    hint: "Passwort",
                                    label: "Passwort (nur zum Ändern ausfüllen)",
                                    radius: 10,
                                    icon: "key",
                                    mb: 15,
                                    searchController: controller.passwordController,
                                    isPassword: true),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: MyColors.white,
              padding: EdgeInsets.symmetric(horizontal: 30),
              margin: EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                  onTap: () {
                    controller.updateProfile();
                    Get.to(Profile());
                  },
                  child: buttonGlobal(text: "Speichern")),
            )
          ],
        ),
      ),
    );
  }
}
