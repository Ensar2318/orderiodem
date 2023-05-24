import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/widgets/bottomMenu.dart';
import 'package:zwerge/widgets/myCategoriesMenu.dart';
import 'package:zwerge/widgets/mySlideUpCollapsed.dart';
import 'package:zwerge/widgets/mySlideUpPanel.dart';
import 'package:zwerge/widgets/newProductsViewForSearch.dart';
import 'package:zwerge/widgets/topBar.dart';

class SearchResults extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    Get.put(UserController());
    return Scaffold(
      body: GetBuilder<ProductController>(builder: (controller) {
        return SlidingUpPanel(
          controller: controller.pc,
          color: Colors.transparent,
          renderPanelSheet: false,
          panel: controller.slideUpVisibilty == true ? mySlideUpPanel() : Container(),
          collapsed: controller.slideUpVisibilty == true ? mySlideUpCollapsed() : Container(),
          body: Container(
            color: MyColors.orange,
            child: Container(
              margin: const EdgeInsets.only(top: 25),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<UserController>(builder: (controllerUser) {
                    if (controllerUser.loginInfo != null) {
                      return TopBar(label: 'Welcome 👋\n${controllerUser.loginInfo!.firstname}', loginInfo: controllerUser.loginInfo);
                    } else {
                      return TopBar(label: 'Welcome 👋', loginInfo: null);
                    }
                  }),
                  const myCategoriesMenu(),
                  Container(height: 20, color: Colors.white),
                  GestureDetector(
                    onTap: () {
                      controller.pc.hide();
                      controller.slideUpVisibilty = false;
                      controller.clearSession();
                    },
                    child: Container(
                      width: Get.width,
                      padding: EdgeInsets.only(left: Get.width * 0.05),
                      color: Colors.white,
                      child: const Text("Search Results",
                          style: TextStyle(
                              color: Color(0xff040413),
                              fontWeight: FontWeight.w600,
                              fontFamily: "Gilroy",
                              fontStyle: FontStyle.normal,
                              fontSize: 24.0),
                          textAlign: TextAlign.left),
                    ),
                  ),
                  const newProductsViewForSearch(),
                  BottomMenu(active: 'home')
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
