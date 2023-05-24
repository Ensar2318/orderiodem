import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/screens/accountSettings.dart';
import 'package:zwerge/screens/home.dart';

import '../utils/Colors.dart';

class TopBarProfile extends GetView<UserController> {
  const TopBarProfile() : super();

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return Container(
      height: controller.isLogin == true ? 254 : 70,
      decoration: BoxDecoration(
          borderRadius: controller.isLogin == true
              ? BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
              : BorderRadius.all(Radius.circular(0)),
          boxShadow: [BoxShadow(color: const Color(0x10000000), offset: Offset(0, 0), blurRadius: 15, spreadRadius: 0)],
          color: const Color(0xffffffff)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(Home());
                  },
                  child: Container(
                      child: Icon(
                        Icons.close,
                        color: MyColors.white,
                      ),
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: primaryColor)),
                ),
                // Group 2144
                if (controller.isLogin == true)
                  GestureDetector(
                    onTap: () {
                      Get.to(() => AccountSettings());
                    },
                    child: Container(
                        width: 40,
                        height: 40,
                        child: Icon(
                          Icons.edit,
                          color: primaryColor,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            boxShadow: [BoxShadow(color: const Color(0xffe5e5e5), offset: Offset(0, 3), blurRadius: 6, spreadRadius: 0)],
                            color: const Color(0xffffffff))),
                  )
              ],
            ),
          ),
          Container(
            child: controller.isLogin == true
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(80),
                          child: Container(
                            child: controller.profilePhotoUrl != null
                                ? CachedNetworkImage(
                                    imageUrl: 'https://cdn.orderio.de' + controller.profilePhotoUrl!,
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) {
                                      return Image.network('https://cdn.orderio.de/images/products/placeholder.jpg');
                                    },
                                    fit: BoxFit.cover,
                                  )
                                : Image.network(
                                    'https://ui-avatars.com/api/?name=${controller.loginInfo?.firstname}',
                                    fit: BoxFit.cover,
                                  ),
                            width: 80,
                            height: 80,
                            color: MyColors.watermelon,
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: // Aylin Yıldırım
                              Text(
                            "${controller.loginInfo?.firstname} ${controller.loginInfo?.surname}",
                            style: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 18.0),
                          )),
                      // aylinyildirim@gmail.com
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text("${controller.loginInfo?.email}",
                            style: const TextStyle(
                                color: const Color(0xff747474),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Avenir",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0)),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: Text("${controller.loginInfo?.phone}",
                            style: const TextStyle(
                                color: const Color(0xff747474),
                                fontWeight: FontWeight.w500,
                                fontFamily: "Avenir",
                                fontStyle: FontStyle.normal,
                                fontSize: 16.0)),
                      )
                    ],
                  )
                : Container(),
          )
        ],
      ),
    );
  }
}
