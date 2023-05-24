import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/screens/staticPage.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/myButton.dart';
import 'package:zwerge/widgets/myTextField.dart';

class CreateAccount extends GetView<UserController> {
  CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05),
          child: Stack(
            children: [
              GetBuilder<UserController>(builder: (controller) {
                return SingleChildScrollView(
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
                                    color: Color(0xff040413),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Gilroy",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.0),
                                textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      const Text("Create Account",
                          style: TextStyle(
                              color: Color(0xff040413),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Gilroy",
                              fontStyle: FontStyle.normal,
                              fontSize: 28.0),
                          textAlign: TextAlign.left),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                              width: 64,
                              height: 64,
                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Color(0x40e3853b)),
                              child: controller.profilePhoto != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(60.0), child: Image.file(controller.profilePhoto!, fit: BoxFit.cover))
                                  : Container(child: const Icon(Icons.person_outlined, color: Color(0xffe88a34), size: 35))),
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Please Select'),
                                      content: SizedBox(
                                        height: MediaQuery.of(context).size.height * 0.30,
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
                                                // controller.addPImage(image);
                                                controller.image = image;
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
                                                //controller.addPImage(image);
                                                controller.image = image;
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
                              height: 50,
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(5)), color: Color(0xff000000)),
                                    child: // Upload
                                        const Text("Upload",
                                            style: TextStyle(
                                                color: Color(0xffffffff),
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Gilroy",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 12.0),
                                            textAlign: TextAlign.left),
                                  ),
                                  const Text("Only PNG and JPG images are supported",
                                      style: TextStyle(
                                          color: Color(0xff777777),
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Gilroy",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 12.0),
                                      textAlign: TextAlign.left)
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            width: Get.width * 0.42,
                            height: 75,
                            child: TextField(
                                controller: controller.firstnameController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff777777), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff777777), width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    labelText: 'First Name',
                                    labelStyle: TextStyle(color: Color(0xff777777)))),
                          ),
                          const Spacer(),
                          Container(
                            width: Get.width * 0.42,
                            height: 75,
                            child: TextField(
                                controller: controller.surnameController,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff777777), width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Color(0xff777777), width: 1.0),
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                    ),
                                    labelText: 'Last Name',
                                    labelStyle: TextStyle(color: Color(0xff777777)))),
                          ),
                        ],
                      ),
                      Container(
                        width: Get.width * 1,
                        height: 75,
                        child: TextField(
                            controller: controller.phoneController,
                            decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff777777), width: 1.0),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xff777777), width: 1.0),
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                labelText: 'Mobile Phone',
                                hintText: '+995 ',
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Image.asset(
                                    'assets/germany.png',
                                    width: 15,
                                  ),
                                ),
                                labelStyle: const TextStyle(color: Color(0xff777777)))),
                      ),
                      MyTextField(
                        hidden: false,
                        label: 'Email',
                        searchController: controller.emailControllerRegister,
                      ),
                      MyTextField(
                        hidden: true,
                        label: 'Password',
                        searchController: controller.passwordControllerRegister,
                      ),
                      MyTextField(
                        hidden: true,
                        label: 'Repeat Password',
                        searchController: controller.passwordRepeatController,
                      ),
                      /* controller.areas != null
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
                        : Container(), */
                      /*  SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      hidden: false,
                      label: 'Adres',
                      searchController: controller.addressController,
                    ), */
                      GestureDetector(
                        onTap: () {
                          if (controller.checkboxNewsletter) {
                            controller.checkboxNewsletter = false;
                          } else {
                            controller.checkboxNewsletter = true;
                          }
                          controller.update();
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 28,
                                height: 28,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                                    border: Border.all(
                                        color: controller.checkboxNewsletter == false ? const Color(0xffc4c4c4) : MyColors.orange, width: 1),
                                    color: controller.checkboxNewsletter == false ? const Color(0xffffffff) : MyColors.orange),
                                child: controller.checkboxNewsletter == false ? Container() : Image.asset('assets/tik.png')),
                            const Text("I want to recieve a newsletter",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Gilroy",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0),
                                textAlign: TextAlign.left)
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (controller.checkboxTerms) {
                                controller.checkboxTerms = false;
                              } else {
                                controller.checkboxTerms = true;
                              }
                              controller.update();
                            },
                            child: Container(
                                width: 28,
                                height: 28,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(4)),
                                    border:
                                        Border.all(color: controller.checkboxTerms == false ? const Color(0xffc4c4c4) : MyColors.orange, width: 1),
                                    color: controller.checkboxTerms == false ? const Color(0xffffffff) : MyColors.orange),
                                child: controller.checkboxTerms == false ? Container() : Image.asset('assets/tik.png')),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Get.to(Terms());
                              Get.to(StaticPage(controller.pages.termsAndConditions));
                            },
                            child: RichText(
                                text: const TextSpan(children: [
                              TextSpan(
                                  style: TextStyle(
                                      color: Color(0xff000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Gilroy",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  text: "By creating an account I accept \n"),
                              TextSpan(
                                  style: TextStyle(
                                      color: MyColors.orange,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "Gilroy",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 14.0),
                                  text: "Terms & Conditions")
                            ])),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          //password repeat control
                          if (controller.passwordControllerRegister!.text == controller.passwordRepeatController!.text) {
                            if (controller.checkboxTerms) {
                              if (controller.firstnameController!.text.length < 2 ||
                                  controller.surnameController!.text.length < 2 ||
                                  controller.phoneController!.text.length < 2 ||
                                  controller.emailControllerRegister!.text.length < 2 ||
                                  controller.passwordControllerRegister!.text.length < 2 ||
                                  controller.passwordRepeatController!.text.length < 2) {
                                Get.snackbar(
                                  'Warnung',
                                  'Bitte alle Felder ausfüllen.',
                                  icon: Icon(
                                    Icons.error,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.yellow.shade700,
                                  colorText: Colors.white,
                                );
                              } else {
                                controller.register();
                              }
                            } else {
                              Get.snackbar(
                                'Warnung',
                                'Bitte akzeptieren Sie die AGB',
                                icon: Icon(
                                  Icons.error,
                                  color: Colors.white,
                                ),
                                backgroundColor: Colors.yellow.shade700,
                                colorText: Colors.white,
                              );
                            }
                          } else {
                            Get.snackbar(
                              'Warnung',
                              'Passwörter stimmen nicht überein',
                              icon: Icon(
                                Icons.error,
                                color: Colors.white,
                              ),
                              backgroundColor: Colors.yellow.shade700,
                              colorText: Colors.white,
                            );
                          }
                        },
                        child: MyButton(
                          label: 'Continue',
                          width: Get.width,
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
