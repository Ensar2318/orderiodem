import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/utils/helper.dart';

import '../controllers/productController.dart';

class mySlideUpCollapsed extends GetView<ProductController> {
  const mySlideUpCollapsed({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
    UserController userController = Get.put(UserController());
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;
    return GestureDetector(
      onTap: () {
        if (controller.box.read('coordinateActive') == "1") {
          if (controller.addressText != 'Addresse eingeben') {
            controller.pc.animatePanelToPosition(1.0);
            Future.delayed(Duration(milliseconds: 500), () {
              controller.update();
            });
          } else {
            if (!_isThereCurrentDialogShowing(context)) {
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
            }

            // Get.snackbar('Warnung', 'Bitte wählen Sie oben im Antrag eine Adresse aus');
          }
        } else {
          if (userController.selectedArea != null) {
            controller.pc.animatePanelToPosition(1.0);
            Future.delayed(Duration(milliseconds: 500), () {
              controller.update();
            });
          } else {
            if (!_isThereCurrentDialogShowing(context)) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(Radius.circular(12.0))),
                      contentPadding: EdgeInsets.zero,
                      content: Container(
                        width: screenW(0.9, context),
                        padding: const EdgeInsets.all(20),
                        height: screenH(0.2, context),
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
                                  child: Text("❗️",
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
                            const Text("Warnung",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Gilroy",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 24.0),
                                textAlign: TextAlign.left),
                            const SizedBox(height: 10),
                            const Text("Bitte wählen Sie oben im Antrag eine Adresse aus",
                                style: TextStyle(
                                  color: Color(0xff767676),
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Gilroy",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 16.0,
                                ),
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    );
                  });
            }
          }
        }
      },
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: const Color(0x29000000), offset: Offset(0, 3), blurRadius: 30, spreadRadius: 0)],
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/cart-icon.png',
                width: Get.width * 0.05,
                color: primaryColor,
              ),
              SizedBox(width: 5),
              Text(controller.totalItems.toString(),
                  style: const TextStyle(
                      color: const Color(0xff000000), fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 18.0),
                  textAlign: TextAlign.left),
            ],
          ), // Warenkorb
          Text("Warenkorb",
              style: TextStyle(color: primaryColor, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 18.0),
              textAlign: TextAlign.left), // 12,50 €
          Text(controller.cartItems != null ? controller.cartItems!.total.toString().replaceAll(".", ",") + "€" : '0€',
              style: const TextStyle(
                  color: const Color(0xff000000), fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 18.0),
              textAlign: TextAlign.left)
        ]),
      ),
    );
  }
}
