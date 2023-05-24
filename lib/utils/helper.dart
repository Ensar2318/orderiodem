//Functions

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zwerge/utils/Colors.dart';

SharedPreferences? prefs;

bool containsStr(String str) {
  bool found = str.contains(new RegExp(r'[0-9]'));
  return found;
}

currentDate() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd HH:mm:ss');
  String formattedDate = formatter.format(now);
  return formattedDate; // 2016-01-25
}

void customModal({String title = "custom modal", String status = "success", String succesButton = "Ok", String cancelButton = ""}) {
  final image;
  if (status == "success") {
    image = "assets/success.png";
  } else if (status == "order") {
    image = "assets/orderSuccesful.png";
  } else if (status == "error") {
    image = "assets/error.png";
  } else {
    image = "assets/success.png";
  }
  Get.defaultDialog(
      title: "",
      contentPadding: EdgeInsets.zero,
      titlePadding: EdgeInsets.zero,
      barrierDismissible: true,
      confirmTextColor: Colors.white,
      content: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Image.asset(
              image,
              width: Get.width / 4.5,
            ),
            SizedBox(
              height: 20,
            ),
            // Siparişinizi aldık!
            Text(
              title,
              style: const TextStyle(
                  color: const Color(0xff000000), fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            // Rectangle 86
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      alignment: Alignment.center,
                      child: // Anasayfa
                          Text(succesButton,
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "Avenir",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.0)),
                      height: 30,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(18)), color: MyColors.watermelon)),
                ),
                if (cancelButton.isNotEmpty)
                  SizedBox(
                    width: 10,
                  ),
                if (cancelButton.isNotEmpty)
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        child: // Anasayfa
                            Text(cancelButton,
                                style: const TextStyle(
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Avenir",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0)),
                        height: 40,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(27)), color: MyColors.black)),
                  ),
              ],
            )
          ],
        ),
      ));
}

//Get Gen  from SP
Future<String?> getGenPref(String key) async {
  final prefs = await SharedPreferences.getInstance();
  final String? value = prefs.getString(key);
  return value;
}

Future goWebUrl(String slug) async {
  final Uri url = Uri.parse(slug.toString());
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
  }
}

priceFormat(price) {
  final formatCurrency = new NumberFormat("#,##0.00", "de_DE");
  return formatCurrency.format(price);
}

//cihazın yüksekliğini al
double screenH(double hheight, context) {
  return MediaQuery.of(context).size.height * hheight;
}

//cihazın genişliğini al
double screenW(double wwidth, context) {
  return MediaQuery.of(context).size.width * wwidth;
}

//Gen save SP
Future<void> setGenPref(String key, String val) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, val);
}
