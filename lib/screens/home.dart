import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/models/areaModel.dart';
import 'package:zwerge/newWidgets/newCategoryBox.dart';
import 'package:zwerge/newWidgets/newCategoryList.dart';
import 'package:zwerge/newWidgets/newSlideUpCollapsed.dart';
import 'package:zwerge/newWidgets/newSlideUpPanel.dart';
import 'package:zwerge/screens/profile.dart';
import 'package:zwerge/screens/restourantInfo.dart';
import 'package:zwerge/utils/Colors.dart';

class Home extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    print(context.height);
    final ScrollController mainScrollableController = ScrollController();
    final ItemScrollController categoryBoxScroll = ItemScrollController();
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    bool flag = true;
    bool flag2 = true;

    print(controller.box.read('coordinateActive'));

    TextStyle marketText =
        TextStyle(color: Color(0xff7c7c7c), fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 16.0);
    TextStyle marketPriceText =
        TextStyle(color: Color(0xff000000), fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 18.0);
    final mybuttonkey = GlobalKey();
    final mybuttonkey2 = GlobalKey();

    Get.put(ProductController());
    Get.put(UserController());
    UserController userController = Get.find<UserController>();
    Color secondaryColor = HexColor.fromHex(box.read('secondaryColor'));
    // print(userController.annouuncements);

    // future delay
    if (controller.oneTimeTrigger) {
      Future.delayed(Duration(milliseconds: 100), () {
        controller.categoryHeights.clear();
        for (int i = 0; i < controller.categoryKey.length; i++) {
          double dy = 0.0;
          final RenderBox renderBox = controller.categoryKey[i].currentContext?.findRenderObject() as RenderBox;

          Offset offset = renderBox.localToGlobal(Offset.zero);
          dy = offset.dy;
          controller.categoryHeights.add(dy);
          box.write('offset' + i.toString(), dy);
          // print('offset' + i.toString() + ' ' + dy.toString());
        }
      });
      controller.oneTimeTrigger = false;
      controller.update();

      if (controller.box.read('coordinateActive') == "1") {
        //delay
        Future.delayed(Duration(milliseconds: 500), () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    width: Get.width * 0.9,
                    padding: const EdgeInsets.all(20),
                    height: 220,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            var sonuc = await PlacesAutocomplete.show(
                                //offset: 0,
                                //radius: 1000,
                                strictbounds: false,
                                region: "de",
                                language: "de",
                                context: context,
                                mode: Mode.overlay,
                                apiKey: 'AIzaSyCm5S9GHntSP6--IbIY6K3c86wR4fEEF40',
                                //sessionToken: sessionToken,
                                components: [new Component(Component.country, "de")],
                                types: [],
                                hint: "Adresse suchen");
                            // startText: city == null || city == "" ? "" : city);
                            print(sonuc);
                            if (sonuc != null) {
                              final places = new GoogleMapsPlaces(apiKey: "AIzaSyCm5S9GHntSP6--IbIY6K3c86wR4fEEF40");

                              PlacesDetailsResponse response = await places.getDetailsByPlaceId(sonuc.placeId!);
                              print(response);
                              print(response.result.geometry!.location.lat);
                              print(response.result.geometry!.location.lng);
                              print(response.result.formattedAddress);

                              controller.update();
                              userController.checkCoordinate(
                                  response.result.geometry!.location.lat.toString() + ',' + response.result.geometry!.location.lng.toString(),
                                  userController.shopContact!.name.toString(),
                                  response.result.name,
                                  response.result.formattedAddress!);
                              Get.back();
                            }
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 40),
                              width: Get.width * 0.85,
                              height: 48,
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xffdbdbdb)),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  boxShadow: [const BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
                                  color: const Color(0xffffffff)),
                              child: const Center(
                                child: Text("Liefern",
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
                            controller.setGelAl();
                            controller.addressText = 'Abholung';
                            controller.update();
                            Get.back();
                            //yeni api tetiklenece
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: Get.width * 0.85,
                              height: 48,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  boxShadow: [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
                                  color: Color(0xffe88a34)),
                              child: const Center(
                                child: Text("Abholen",
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
        });
      } else {
        Future.delayed(Duration(milliseconds: 500), () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                  contentPadding: EdgeInsets.zero,
                  content: Container(
                    width: Get.width * 0.9,
                    padding: const EdgeInsets.all(20),
                    height: 220,
                    child: Column(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            Get.back();
                            await Future.delayed(Duration(milliseconds: 200));

                            RenderBox renderbox = mybuttonkey.currentContext!.findRenderObject() as RenderBox;
                            Offset position = renderbox.localToGlobal(Offset.zero); //205,85
                            double x = position.dx;
                            double y = position.dy;

                            print(x);
                            print(y);
                            // x = 205;
                            // y = 85;

                            GestureBinding.instance.handlePointerEvent(PointerDownEvent(
                              position: Offset(x, y),
                            )); //trigger button up,

                            await Future.delayed(Duration(milliseconds: 500));
                            //add delay between up and down button

                            GestureBinding.instance.handlePointerEvent(PointerUpEvent(
                              position: Offset(x, y),
                            ));

                            RenderBox renderbox2 = mybuttonkey2.currentContext!.findRenderObject() as RenderBox;
                            Offset position2 = renderbox.localToGlobal(Offset.zero); //205,85
                            double x2 = position2.dx;
                            double y2 = position2.dy;

                            print(x2);
                            print(y2);
                            // x = 205;
                            // y = 85;

                            GestureBinding.instance.handlePointerEvent(PointerDownEvent(
                              position: Offset(x2, y2),
                            )); //trigger button up,

                            await Future.delayed(Duration(milliseconds: 500));
                            //add delay between up and down button

                            GestureBinding.instance.handlePointerEvent(PointerUpEvent(
                              position: Offset(x2, y2),
                            ));
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 40),
                              width: Get.width * 0.85,
                              height: 48,
                              decoration: BoxDecoration(
                                  border: Border.all(color: const Color(0xffdbdbdb)),
                                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                                  boxShadow: [const BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
                                  color: const Color(0xffffffff)),
                              child: const Center(
                                child: Text("Liefern",
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
                            controller.setGelAl();
                            controller.addressText = 'Abholung';
                            controller.update();
                            Get.back();
                            //yeni api tetiklenece
                          },
                          child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              width: Get.width * 0.85,
                              height: 48,
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(12)),
                                  boxShadow: [BoxShadow(color: Color(0x0d000000), offset: Offset(0, 3), blurRadius: 3, spreadRadius: 0)],
                                  color: Color(0xffe88a34)),
                              child: const Center(
                                child: Text("Abholen",
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
        });
      }
    }

    return Container(
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: GetBuilder<ProductController>(builder: (controller) {
            controller.categoryKey.clear();

            if (!controller.closedIsShown) {
              Future.delayed(Duration(milliseconds: 500), () {
                controller.options != null
                    ? controller.options!.closed == 1
                        ? Get.dialog(
                            AlertDialog(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              titlePadding: EdgeInsets.zero,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    color: primaryColor,
                                    height: 40,
                                    padding: EdgeInsets.only(left: 20, right: 6),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Rabattakionen
                                        Text("Wir haben geschlossen!",
                                            style: const TextStyle(
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "Avenir",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.0),
                                            textAlign: TextAlign.left),

                                        GestureDetector(
                                          onTap: (() => {Get.back()}),
                                          child: Container(
                                              height: 30,
                                              width: 30,
                                              child: Icon(
                                                Icons.close_rounded,
                                                color: MyColors.watermelon,
                                              ),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(19)), color: MyColors.white)),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                                      child: Container(
                                          child: Text("Wir haben momentan geschlossen! Sie können eine Vorbestellung tätigen.",
                                              style: const TextStyle(
                                                  color: MyColors.darkText,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "Avenir",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14.0)))),
                                ],
                              ),
                            ),
                          )
                        : null
                    : null;
                controller.closedIsShown = true;
              });
            }
            return !controller.isLoading && controller.options != null
                ? SlidingUpPanel(
                    controller: controller.pc,
                    color: Colors.transparent,
                    renderPanelSheet: false,
                    minHeight: 70,
                    maxHeight: Get.height * 0.8,
                    panel: controller.slideUpVisibilty == true ? mySlideUpPanel() : Container(),
                    collapsed: controller.slideUpVisibilty == true ? mySlideUpCollapsed() : Container(),
                    body: Container(
                      width: Get.width,
                      color: MyColors.white,
                      child: Stack(
                        children: [
                          NotificationListener(
                            onNotification: (notification) {
                              if (notification is ScrollUpdateNotification) {
                                if (notification.depth == 0 && notification.metrics.axis == Axis.vertical) {
                                  int index = 0;
                                  double dy = 300;

                                  if (notification.metrics.pixels.round() % 2 == 1) {
                                    var key = 0;
                                    controller.categoryHeights.forEach((element) {
                                      if (notification.metrics.pixels > element - 250) {
                                        index = key;
                                      }
                                      key++;
                                    });
                                    if ((notification.metrics.pixels) > (dy)) {
                                      if (controller.currentCategorySlideIndex != index) {
                                        if (controller.categoryHeights.length - 2 > index) {
                                          categoryBoxScroll.jumpTo(index: index);
                                        }
                                        controller.update();
                                      }
                                      controller.currentCategorySlideIndex = index;
                                      if (flag) {
                                        flag = false;

                                        controller.update();
                                      }
                                    } else {
                                      if (!flag) {
                                        flag = true;
                                        controller.update();
                                      }
                                      controller.currentCategorySlideIndex = -1;
                                    }
                                  }
                                }
                              }
                              return true;
                            },
                            child: ListView(
                              controller: mainScrollableController,
                              children: [
                                Container(
                                    padding: EdgeInsets.all(20),
                                    width: Get.width,
                                    height: 70,
                                    decoration: BoxDecoration(
                                        boxShadow: [BoxShadow(color: const Color(0x29000000), offset: Offset(0, 3), blurRadius: 6, spreadRadius: 0)],
                                        color: const Color(0xffffffff)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Get.to(Profile());
                                          },
                                          child: Image.asset(
                                            'assets/menu-icon.png',
                                            width: 30,
                                            height: 30,
                                            color: primaryColor,
                                          ),
                                        ),
                                        controller.box.read('coordinateActive') == "1"
                                            ? GestureDetector(
                                                onTap: () async {
                                                  /*   await PlacesAutocomplete.show(
                                                      context: context,
                                                      apiKey: 'AIzaSyCm5S9GHntSP6--IbIY6K3c86wR4fEEF40',
                                                      mode: Mode.overlay, // Mode.fullscreen
                                                      language: "de",
                                                      components: [new Component(Component.country, "de")]);
                                                  */
                                                  return showDialog(
                                                      context: context,
                                                      builder: (BuildContext context) {
                                                        return AlertDialog(
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                                                          contentPadding: EdgeInsets.zero,
                                                          content: Container(
                                                            width: Get.width * 0.9,
                                                            padding: const EdgeInsets.all(20),
                                                            height: 220,
                                                            child: Column(
                                                              children: <Widget>[
                                                                GestureDetector(
                                                                  onTap: () async {
                                                                    var sonuc = await PlacesAutocomplete.show(
                                                                        //offset: 0,
                                                                        //radius: 1000,
                                                                        strictbounds: false,
                                                                        region: "de",
                                                                        language: "de",
                                                                        context: context,
                                                                        mode: Mode.overlay,
                                                                        apiKey: 'AIzaSyCm5S9GHntSP6--IbIY6K3c86wR4fEEF40',
                                                                        //sessionToken: sessionToken,
                                                                        components: [new Component(Component.country, "de")],
                                                                        types: [],
                                                                        hint: "Adresse suchen");
                                                                    // startText: city == null || city == "" ? "" : city);
                                                                    print(sonuc);
                                                                    if (sonuc != null) {
                                                                      final places =
                                                                          new GoogleMapsPlaces(apiKey: "AIzaSyCm5S9GHntSP6--IbIY6K3c86wR4fEEF40");

                                                                      PlacesDetailsResponse response =
                                                                          await places.getDetailsByPlaceId(sonuc.placeId!);
                                                                      print(response);
                                                                      print(response.result.geometry!.location.lat);
                                                                      print(response.result.geometry!.location.lng);
                                                                      print(response.result.formattedAddress);

                                                                      controller.update();
                                                                      userController.checkCoordinate(
                                                                          response.result.geometry!.location.lat.toString() +
                                                                              ',' +
                                                                              response.result.geometry!.location.lng.toString(),
                                                                          userController.shopContact!.name.toString(),
                                                                          response.result.name,
                                                                          response.result.formattedAddress!);
                                                                      Get.back();
                                                                    }
                                                                  },
                                                                  child: Container(
                                                                      margin: const EdgeInsets.only(top: 40),
                                                                      width: Get.width * 0.85,
                                                                      height: 48,
                                                                      decoration: BoxDecoration(
                                                                          border: Border.all(color: const Color(0xffdbdbdb)),
                                                                          borderRadius: const BorderRadius.all(Radius.circular(12)),
                                                                          boxShadow: [
                                                                            const BoxShadow(
                                                                                color: Color(0x0d000000),
                                                                                offset: Offset(0, 3),
                                                                                blurRadius: 3,
                                                                                spreadRadius: 0)
                                                                          ],
                                                                          color: const Color(0xffffffff)),
                                                                      child: const Center(
                                                                        child: Text("Liefern",
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
                                                                    controller.setGelAl();
                                                                    controller.addressText = 'Abholung';
                                                                    controller.update();
                                                                    Get.back();
                                                                    //yeni api tetiklenece
                                                                  },
                                                                  child: Container(
                                                                      margin: const EdgeInsets.only(top: 15),
                                                                      width: Get.width * 0.85,
                                                                      height: 48,
                                                                      decoration: const BoxDecoration(
                                                                          borderRadius: BorderRadius.all(Radius.circular(12)),
                                                                          boxShadow: [
                                                                            BoxShadow(
                                                                                color: Color(0x0d000000),
                                                                                offset: Offset(0, 3),
                                                                                blurRadius: 3,
                                                                                spreadRadius: 0)
                                                                          ],
                                                                          color: Color(0xffe88a34)),
                                                                      child: const Center(
                                                                        child: Text("Abholen",
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
                                                },
                                                child: Text(controller.addressText))
                                            : GetBuilder<UserController>(builder: (userController) {
                                                return Row(
                                                  children: [
                                                    Container(
                                                      width: Get.width * 0.57,
                                                      child: DropdownButtonFormField2(
                                                        key: mybuttonkey,
                                                        dropdownButtonKey: mybuttonkey2,
                                                        dropdownMaxHeight: 250,
                                                        alignment: Alignment.centerLeft,
                                                        style: TextStyle(
                                                            color: Color(0xff040413),
                                                            fontWeight: FontWeight.w500,
                                                            fontFamily: "Gilroy",
                                                            fontStyle: FontStyle.normal,
                                                            fontSize: 14.0),
                                                        decoration: InputDecoration(
                                                          border: InputBorder.none,
                                                          //       prefixIcon:
                                                          //Add isDense true and zero Padding.
                                                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                                          isDense: true,
                                                          contentPadding: EdgeInsets.zero,

                                                          //Add more decoration as you want here
                                                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                                        ),
                                                        isExpanded: true,
                                                        hint: userController.selectedArea != null
                                                            ? Row(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Image.asset(
                                                                    'assets/location-icon.png',
                                                                    color: primaryColor,
                                                                  ),
                                                                  SizedBox(width: 7),
                                                                  Expanded(
                                                                    child: controller.addressText != 'Abholung'
                                                                        ? Text(
                                                                            userController.selectedArea!.postal.toString() +
                                                                                "," +
                                                                                userController.selectedArea!.city.toString(),
                                                                            overflow: TextOverflow.ellipsis,
                                                                            maxLines: 1,
                                                                          )
                                                                        : Text(
                                                                            'Abholen',
                                                                            overflow: TextOverflow.ellipsis,
                                                                            maxLines: 1,
                                                                          ),
                                                                  )
                                                                ],
                                                              )
                                                            : Container(),
                                                        icon: Transform.rotate(
                                                          angle: 90 * 3.1415927 / 180,
                                                          child: Icon(
                                                            Icons.arrow_forward_ios,
                                                            size: 15,
                                                            color: primaryColor,
                                                          ),
                                                        ),
                                                        buttonHeight: 48,
                                                        buttonPadding: const EdgeInsets.only(left: 5, right: 15),
                                                        dropdownDecoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(15),
                                                        ),
                                                        items: [
                                                          if (userController.areas != null)
                                                            for (var item in userController.areas!)
                                                              DropdownMenuItem(
                                                                child: Row(
                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  children: [
                                                                    Image.asset('assets/location-icon.png'),
                                                                    SizedBox(width: 7),
                                                                    Expanded(
                                                                      child: Text(
                                                                        item.postal.toString() + "," + item.city.toString(),
                                                                        overflow: TextOverflow.ellipsis,
                                                                        maxLines: 1,
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                                value: item,
                                                              ),
                                                          DropdownMenuItem(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                Image.asset('assets/location-icon.png'),
                                                                SizedBox(width: 7),
                                                                Expanded(
                                                                  child: Text(
                                                                    "Abholung",
                                                                    overflow: TextOverflow.ellipsis,
                                                                    maxLines: 1,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                            value: "Abholung",
                                                          ),
                                                        ],
                                                        validator: (value) {
                                                          if (value == null) {
                                                            return 'Please select address.';
                                                          }
                                                          return null;
                                                        },
                                                        onChanged: (value) {
                                                          if (value == "Abholung") {
                                                            controller.setGelAl();
                                                            controller.addressText = 'Abholung';
                                                            controller.update();
                                                            userController.update();
                                                          } else {
                                                            //Do something when changing the item if you want.
                                                            userController.selectedArea = value as AreaModel;
                                                            userController.update();
                                                            controller.update();
                                                          }
                                                        },
                                                        onSaved: (value) {
                                                          if (value == "Abholung") {
                                                            controller.setGelAl();
                                                            controller.addressText = 'Abholung';
                                                            controller.update();
                                                            userController.update();
                                                          } else {
                                                            //Do something when changing the item if you want.
                                                            userController.selectedArea = value as AreaModel;
                                                            userController.update();
                                                            controller.update();
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              }),
                                        Image.asset('assets/notification-icon.png')
                                      ],
                                    )),
                                Stack(
                                  children: [
                                    Image.network(
                                      "https://cdn.orderio.de/images/header/" + controller.options!.header.toString(),
                                      width: Get.width,
                                      height: Get.height * 0.18,
                                      fit: BoxFit.cover,
                                    ),
                                    if (userController.annouuncements != null)
                                      if (userController.annouuncements!.length == 1)
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                              width: Get.width * 0.9,
                                              child: Text(userController.annouuncements![0].content.toString(),
                                                  style: TextStyle(
                                                      color: secondaryColor, fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontSize: 20.0),
                                                  textAlign: TextAlign.center),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                                                color: Color.fromRGBO(255, 255, 255, 0.9),
                                              ),
                                            ),
                                          ],
                                        ),
                                    if (userController.annouuncements != null)
                                      if (userController.annouuncements!.length > 1 && userController.annouuncements != null)
                                        CarouselSlider(
                                            items: [
                                              for (var item in userController.annouuncements!)
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                                  width: Get.width * 0.9,
                                                  child: Text(item.content.toString(),
                                                      style: TextStyle(
                                                          color: secondaryColor, fontWeight: FontWeight.w600, fontFamily: "Gilroy", fontSize: 20.0),
                                                      textAlign: TextAlign.center),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
                                                    color: Color.fromRGBO(255, 255, 255, 0.9),
                                                  ),
                                                )
                                            ],
                                            options: CarouselOptions(
                                              height: 80,
                                              aspectRatio: 1,
                                              viewportFraction: 1,
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              reverse: false,
                                              autoPlay: true,
                                              autoPlayInterval: Duration(seconds: 5),
                                              autoPlayAnimationDuration: Duration(milliseconds: 1000),
                                              enlargeCenterPage: true,
                                              enlargeFactor: 0.3,
                                              scrollDirection: Axis.horizontal,
                                            )),
                                    Container(
                                      height: Get.height * 0.25,
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: (() => {
                                                    Get.dialog(
                                                      AlertDialog(
                                                        clipBehavior: Clip.antiAlias,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(20),
                                                        ),
                                                        titlePadding: EdgeInsets.zero,
                                                        title: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              color: primaryColor,
                                                              height: 40,
                                                              padding: EdgeInsets.only(left: 20, right: 6),
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  // Rabattakionen
                                                                  Text("Rabattakionen",
                                                                      style: const TextStyle(
                                                                          color: const Color(0xffffffff),
                                                                          fontWeight: FontWeight.w900,
                                                                          fontFamily: "Avenir",
                                                                          fontStyle: FontStyle.normal,
                                                                          fontSize: 16.0),
                                                                      textAlign: TextAlign.left),

                                                                  GestureDetector(
                                                                    onTap: (() => {Get.back()}),
                                                                    child: Container(
                                                                        height: 30,
                                                                        width: 30,
                                                                        child: Icon(
                                                                          Icons.close_rounded,
                                                                          color: MyColors.watermelon,
                                                                        ),
                                                                        decoration: BoxDecoration(
                                                                            borderRadius: BorderRadius.all(Radius.circular(19)),
                                                                            color: MyColors.white)),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                                padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 20),
                                                                child: userController.discounts != null
                                                                    ? Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        children: [
                                                                          for (var discount in userController.discounts!)
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                                              children: [
                                                                                Row(
                                                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                                  children: [
                                                                                    // 10% Rabatt
                                                                                    Icon(
                                                                                      Icons.chevron_right,
                                                                                      color: MyColors.pastelRed,
                                                                                    ),
                                                                                    Text(discount.label.toString(),
                                                                                        style: const TextStyle(
                                                                                            color: MyColors.darkText,
                                                                                            fontWeight: FontWeight.w900,
                                                                                            fontFamily: "Avenir",
                                                                                            fontStyle: FontStyle.normal,
                                                                                            fontSize: 16.0))
                                                                                  ],
                                                                                ),
                                                                                SizedBox(height: 10),
                                                                                // 15% auf folgende Kategorien: Pasta
                                                                                Text(
                                                                                    discount.value.toString() +
                                                                                        "% auf " +
                                                                                        discount.content.toString(),
                                                                                    style: const TextStyle(
                                                                                        color: MyColors.darkText,
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontFamily: "Avenir",
                                                                                        fontStyle: FontStyle.normal,
                                                                                        fontSize: 14.0))
                                                                              ],
                                                                            )
                                                                        ],
                                                                      )
                                                                    : Container(
                                                                        child: Text("Derzeit keine laufenden Rabattaktionen.",
                                                                            style: const TextStyle(
                                                                                color: MyColors.darkText,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontFamily: "Avenir",
                                                                                fontStyle: FontStyle.normal,
                                                                                fontSize: 14.0)))),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  }),
                                              child: Container(
                                                margin: EdgeInsets.only(bottom: 10),
                                                child: Image.asset(
                                                  'assets/megaphone-icon.png',
                                                  width: Get.width * 0.05,
                                                  color: primaryColor,
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                // controller.pc.hide();
                                                //controller.slideUpVisibilty = false;
                                                // controller.clearSession();
                                                controller.restourantTabs = 0;
                                                Get.to(RestourantInfo());
                                              },
                                              child: Container(
                                                width: Get.width * 0.3,
                                                height: Get.width * 0.3,
                                                padding: EdgeInsets.all(Get.width * 0.006),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(150),
                                                  color: Colors.white,
                                                ),
                                                child: controller.options != null
                                                    ? controller.options!.logo != null
                                                        ? Image.network(
                                                            'https://cdn.orderio.de/images/logos/' + controller.options!.logo!.toString(),
                                                            fit: BoxFit.contain,
                                                          )
                                                        : Container()
                                                    : Container(),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.restourantTabs = 1;
                                                Get.to(RestourantInfo());
                                              },
                                              child: Container(
                                                margin: EdgeInsets.only(bottom: 10),
                                                child: Image.asset(
                                                  'assets/shop-icon.png',
                                                  color: primaryColor,
                                                  width: Get.width * 0.05,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Text(userController.shopContact!.name.toString(),
                                    style: const TextStyle(
                                        color: const Color(0xff1f272e),
                                        fontWeight: FontWeight.w900,
                                        fontFamily: "Avenir",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 18.0),
                                    textAlign: TextAlign.center),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (var i = 0; i < 5; i++)
                                      Row(
                                        children: [
                                          if (userController.ratingAvarage > i)
                                            Icon(Icons.star, color: const Color(0xffffba38), size: 20)
                                          else
                                            Icon(Icons.star, color: Color.fromARGB(255, 196, 192, 189), size: 20),
                                          if (i != userController.ratingAvarage - 1)
                                            SizedBox(
                                              width: 4,
                                            )
                                        ],
                                      ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    controller.restourantTabs = 0;
                                    Get.to(RestourantInfo());
                                  },
                                  child: Text(
                                      "(" +
                                          (userController.ratingScore != null ? userController.ratingScore!.ratingCount.toString() : "0") +
                                          " Bewertungen)",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Avenir",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 14.0),
                                      textAlign: TextAlign.center),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(controller.options!.shortinfo.toString(),
                                        style: const TextStyle(
                                            color: const Color(0xff1f272e),
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Avenir",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.0),
                                        textAlign: TextAlign.center),
                                  ),
                                ),
                                StickyHeader(
                                  header: Column(
                                    children: [
                                      Material(
                                        elevation: 4.0,
                                        child: Container(
                                          color: MyColors.white,
                                          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 14),
                                          margin: EdgeInsets.only(top: 14),
                                          width: Get.width,
                                          height: 50,
                                          child: controller.products != null
                                              ? controller.products.length > 0
                                                  ? ScrollablePositionedList.builder(
                                                      itemScrollController: categoryBoxScroll,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: controller.products.length,
                                                      physics: ClampingScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        return newCategoryBox(
                                                            currentIndex: controller.currentCategorySlideIndex,
                                                            scrolController: mainScrollableController,
                                                            index: index,
                                                            title: controller.products[index].name,
                                                            isSelected: false);
                                                      },
                                                    )
                                                  : Container(child: Text('not found'))
                                              : Container(child: Text('not found')),
                                        ),
                                      ),
                                    ],
                                  ),
                                  content: controller.products != null
                                      ? controller.products.length > 0
                                          ? ListView.builder(
                                              itemCount: controller.products.length,
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (BuildContext context, int index) {
                                                return newCategoryList(
                                                  data: controller.products[index],
                                                );
                                              },
                                            )
                                          : Container(child: Text('not found'))
                                      : Container(child: Text('not found')),
                                ),
                                SizedBox(height: 170),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Container();
          }),
        ),
      ),
    );
  }
}

class itemNoCarts extends StatelessWidget {
  const itemNoCarts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Ellipse 114
        ClipOval(
          child: Container(
              padding: EdgeInsets.all(20),
              child: Image.asset("assets/noitem.png", fit: BoxFit.contain),
              width: 97,
              height: 97,
              decoration: BoxDecoration(color: const Color(0xfff2f2f2))),
        ),
        SizedBox(height: 15),
        Text("Wählen Sie leckere Gerichte\naus der Karte.",
            style: const TextStyle(
                color: const Color(0xff7c7c7c), fontWeight: FontWeight.w500, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 16.0),
            textAlign: TextAlign.center)
      ],
    );
  }
}
