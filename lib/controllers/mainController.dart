import 'dart:async';

import 'package:get/get.dart';
import 'package:zwerge/models/staticPagesModel.dart';
import 'package:zwerge/services/remote_services.dart';

class MainController extends GetxController {
  late Map<int, bool> isExpanded;
  var restourantTabs = 0;

  var pages;

  getPages() async {
    try {
      var list = await RemoteServices.getStaticPages();

      if (list != null && list != '[]' && list != '') {
        pages = staticModelFromJson(list);
        update();
      } else {
        pages = null;
        //  Get.snackbar('Warnung', 'No found product in cart');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    isExpanded = Map();
    isExpanded[0] = false;
    isExpanded[1] = false;
    isExpanded[2] = false;
    isExpanded[3] = false;

    getPages();
  }
}
