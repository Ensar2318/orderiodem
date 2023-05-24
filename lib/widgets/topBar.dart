import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/models/loginModel.dart';
import 'package:zwerge/screens/search.dart';
import 'package:zwerge/screens/wishList.dart';
import 'package:zwerge/utils/Colors.dart';

class TopBar extends GetView<UserController> {
  final String label;
  final LoginModel? loginInfo;
  const TopBar({required this.label, this.loginInfo}) : super();

  @override
  Widget build(BuildContext context) {
    Get.put(UserController());
    return Container(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 10),
      width: Get.width,
      height: 100,
      decoration: const BoxDecoration(color: MyColors.orange),
      child: // Welcome 👋
          Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              loginInfo != null
                  ? SizedBox(
                      width: 45,
                      height: 45,
                      child: controller.profilePhoto != null
                          ? ClipRRect(borderRadius: BorderRadius.circular(60.0), child: Image.file(controller.profilePhoto!, fit: BoxFit.cover))
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
                              : Container(child: const Icon(Icons.person_outlined, color: Color(0xffe88a34), size: 35)))
                  : Container(),
              SizedBox(
                width: 10,
              ),
              Text(label,
                  maxLines: 2,
                  style: const TextStyle(
                      color: const Color(0xffffffff), fontWeight: FontWeight.w500, fontFamily: "Gilroy", fontStyle: FontStyle.normal, fontSize: 16.0),
                  textAlign: TextAlign.left),
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  final box = GetStorage();
                  var loginCheck = box.read('userId');
                  if (loginCheck != null) {
                    Get.to(WishList());
                  } else {
                    Get.snackbar(
                      'Warnung',
                      'Sie müssen eingeloggt sein, um die Wunschliste nutzen zu können.',
                      icon: Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                      backgroundColor: Colors.yellow.shade700,
                      colorText: Colors.white,
                    );
                  }
                },
                child: Container(
                    margin: EdgeInsets.only(right: 10),
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Color.fromRGBO(255, 255, 255, 0.2)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Image.asset('assets/topLikeIcon.png', width: 15, color: Colors.white),
                    )),
              ),
              GestureDetector(
                onTap: () => Get.to(Search()),
                child: Container(
                    width: 34,
                    height: 34,
                    decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Color.fromRGBO(255, 255, 255, 0.2)),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      child: Image.asset('assets/topSearch.png', width: 15, color: Colors.white),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
