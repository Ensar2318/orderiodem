import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/models/supportsModel.dart';
import 'package:zwerge/utils/Colors.dart';

class chatBox extends StatelessWidget {
  final String message;
  final int userType;

  const chatBox({
    Key? key,
    required this.message,
    required this.userType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    TextStyle adminName = TextStyle(
        color: const Color(0xffa2a2a2), fontWeight: FontWeight.w400, fontFamily: "Avenir-Roman", fontStyle: FontStyle.normal, fontSize: 13.0);
    TextStyle adminText = TextStyle(
        color: const Color(0xff000002), fontWeight: FontWeight.w400, fontFamily: "Avenir-Roman", fontStyle: FontStyle.normal, fontSize: 15.0);

    TextStyle customerText = TextStyle(
        color: const Color(0xffffffff), fontWeight: FontWeight.w400, fontFamily: "Avenir-Roman", fontStyle: FontStyle.normal, fontSize: 15.0);

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: userType == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              userType == 0
                  ? Container(
                      padding: EdgeInsets.only(left: 10, bottom: 6),
                      child: Text("", style: adminName),
                    )
                  : Container(),
              // Rectangle 592
              Container(
                  constraints: BoxConstraints(minWidth: 20, maxWidth: Get.width * 0.6),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Text(message, style: userType == 0 ? adminText : customerText),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15)), color: userType == 0 ? MyColors.softWhite : primaryColor))
            ],
          )
        ],
      ),
    );
  }
}

class CustomerSupport extends GetView<ProductController> {
  final Support data;
  const CustomerSupport({Key? key, required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return SafeArea(
      child: Scaffold(
        body: Container(
            color: MyColors.white,
            child: Column(
              children: [
                Container(
                  height: 72,
                  color: primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Get.back(),
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: MyColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.chevron_left,
                            size: 30,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      Text(
                        "Restaurant kontaktieren",
                        style: const TextStyle(
                            color: const Color(0xffffffff),
                            fontWeight: FontWeight.w900,
                            fontFamily: "Avenir",
                            fontStyle: FontStyle.normal,
                            fontSize: 18.0),
                      ),
                      Container()
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  height: 1,
                  color: MyColors.softGrey,
                ),
                GetBuilder<UserController>(builder: (controller) {
                  return Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 18),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          chatBox(
                            message: data.message,
                            userType: 1,
                          ),
                          ListView(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            children: List.generate(
                                data.responses!.length,
                                (index) => chatBox(
                                      message: data.responses![index].message,
                                      userType: data.responses![index].customerId != controller.box.read('userId') ? 1 : 0,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ));
                }),
                Container(
                    child: Column(
                  children: [
                    Container(
                      height: 1,
                      color: MyColors.softGrey,
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                            padding: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: TextField(
                              controller: Get.find<UserController>().contactMessageController,
                              decoration: InputDecoration(
                                hintText: "Nachricht schreiben",
                                hintStyle: const TextStyle(
                                    color: const Color(0xffb0b0b2),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Avenir-Roman",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.0),
                                border: InputBorder.none,
                              ),
                            ),
                            height: 30,
                            decoration: BoxDecoration(color: MyColors.softWhite, borderRadius: BorderRadius.all(Radius.circular(15))),
                          )),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Get.find<UserController>().sendMessage(data.id, data);
                            },
                            child: Icon(
                              Icons.arrow_circle_right,
                              size: 40,
                              color: Color(0xff7f8488),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ))
              ],
            )),
      ),
    );
  }
}
