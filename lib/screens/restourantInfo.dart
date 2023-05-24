import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/utils/Colors.dart';

class iconTitle extends StatelessWidget {
  final String title;
  final String image;
  const iconTitle({
    Key? key,
    this.title = "Lieferzeiten",
    this.image = "assets/clock-icon.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.start,
      runAlignment: WrapAlignment.start,
      children: [
        ImageIcon(
          AssetImage(image),
          size: 24,
          color: MyColors.watermelon,
        ),
        // Lieferzeiten
        Text(title,
            style: const TextStyle(
                color: MyColors.darkText, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 18.0))
      ],
    );
  }
}

class restourantComment extends StatelessWidget {
  final String title;
  final String date;
  final int stars;
  const restourantComment({
    Key? key,
    required this.title,
    required this.date,
    this.stars = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(14)), color: MyColors.softWhite),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sehr Lecker
              Text(title,
                  style: const TextStyle(
                      color: MyColors.darkText, fontWeight: FontWeight.w500, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0)),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < stars; i++) Icon(Icons.star, color: const Color(0xffffba38), size: 16),
                ],
              ),
            ],
          )
          // 18.09.2022 - 01:07
          ,
          Text(date,
              style: const TextStyle(
                  color: MyColors.darkText, fontWeight: FontWeight.w500, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 12.0))
        ],
      ),
    );
  }
}

class RestourantInfo extends GetView<ProductController> {
  const RestourantInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find();
    final mformat = new NumberFormat("#,##0.00", "en_US");
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));

    return SafeArea(
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 70,
            color: primaryColor,
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                      width: 40,
                      height: 40,
                      margin: const EdgeInsets.only(left: 20, right: 20),
                      child: Icon(
                        Icons.chevron_left,
                        color: MyColors.watermelon,
                        size: 30,
                      ),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: const Color(0xffffffff))),
                ),
                Container(
                  width: Get.width * 0.6,
                  child: Text("Über das Restaurant",
                      style: const TextStyle(
                          color: const Color(0xffffffff),
                          fontWeight: FontWeight.w900,
                          fontFamily: "Avenir",
                          fontStyle: FontStyle.normal,
                          fontSize: 18.0),
                      textAlign: TextAlign.center),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                boxShadow: [BoxShadow(color: const Color(0x29000000), offset: Offset(0, 3), blurRadius: 6, spreadRadius: 0)],
                color: const Color(0xffffffff)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  child: // Über das Restaurant
                      Text("Über das Restaurant",
                          style: const TextStyle(
                              color: MyColors.darkText,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Avenir",
                              fontStyle: FontStyle.normal,
                              fontSize: 18.0)),
                ),
                // Path 4182
                Container(height: 1, color: MyColors.softGrey),
                GetBuilder<ProductController>(builder: ((controller) {
                  return (Container(
                      padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 5),
                      child: Wrap(
                        spacing: 20,
                        children: [
                          // Bewertungen
                          GestureDetector(
                            onTap: () {
                              controller.restourantTabs = 0;
                              controller.update();
                            },
                            child: tabitem(
                              title: "Bewertungen",
                              isActive: controller.restourantTabs == 0 ? true : false,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.restourantTabs = 1;
                              controller.update();
                            },
                            child: tabitem(
                              title: "Info",
                              isActive: controller.restourantTabs == 1 ? true : false,
                            ),
                          ),
                        ],
                      ) // Über das Restaurant
                      ));
                })),
              ],
            ),
          ),
          Expanded(
              child: Container(
            color: MyColors.white,
            child: SingleChildScrollView(
              child: Container(
                color: MyColors.white,
                child: Wrap(
                  children: [
                    GetBuilder<ProductController>(builder: (controller) {
                      TextStyle tableText = TextStyle(
                          color: MyColors.darkText, fontWeight: FontWeight.w500, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0);
                      TextStyle tableTextBold = TextStyle(
                          color: MyColors.darkText, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 14.0);

                      if (controller.restourantTabs == 0) {
                        return (Column(
                          children: [
                            // Rectangle 679
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                              decoration: BoxDecoration(color: const Color(0xfff8f5f2)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  // Durchschnittliche Bewertung
                                  Text("Durchschnittliche Bewertung",
                                      style: const TextStyle(
                                          color: MyColors.darkText,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "Avenir",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18.0)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      // 5.0
                                      if (userController.ratingScore != null)
                                        Text(userController.ratingScore!.ratingAverage.toString(),
                                            style: const TextStyle(
                                                color: MyColors.darkText,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "Avenir",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 40.0)),
                                      if (userController.ratingScore == null)
                                        Text("0.0",
                                            style: const TextStyle(
                                                color: MyColors.darkText,
                                                fontWeight: FontWeight.w900,
                                                fontFamily: "Avenir",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 40.0)),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        width: 1,
                                        height: 45,
                                        color: const Color(0xffeae6e2),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Container(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                for (var i = 0; i < 5; i++)
                                                  if (userController.ratingAvarage > i)
                                                    Icon(Icons.star, color: const Color(0xffffba38), size: 20)
                                                  else
                                                    Icon(Icons.star, color: Color.fromARGB(255, 196, 192, 189), size: 20)
                                              ],
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            // 1 Bewertungen
                                            Text(
                                                userController.ratingScore != null
                                                    ? userController.ratingScore!.ratingCount.toString() + " Bewertungen"
                                                    : "0" + " Bewertungen",
                                                style: const TextStyle(
                                                    color: MyColors.darkText,
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.0),
                                                textAlign: TextAlign.left)
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            // Rectangle 150
                            Container(
                              margin: EdgeInsets.all(15),
                              child: Wrap(
                                runSpacing: 15,
                                children: [
                                  if (userController.ratings != null)
                                    if (userController.ratings!.length > 0)
                                      for (var resto in userController.ratings!)
                                        restourantComment(
                                          title: resto.comment!,
                                          date: resto.created.toString(),
                                          stars: int.parse(resto.rating!),
                                        )
                                ],
                              ),
                            )
                          ],
                        ));
                      } else if (controller.restourantTabs == 1) {
                        return (Column(
                          children: [
                            // Container(
                            //   height: 250,
                            //   color: Colors.amber,
                            // ),
                            Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  iconTitle(
                                    title: "Lieferzeiten",
                                    image: "assets/clock-icon.png",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Rectangle 150
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(14)), color: MyColors.softWhite),
                                    child: Wrap(
                                      runSpacing: 10,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Montags",
                                              style: tableText,
                                            ),
                                            Text(
                                              controller.options!.monday == "1"
                                                  ? controller.options!.mondayStart.toString() +
                                                      (controller.options!.monday2Start.toString() != "null" &&
                                                              controller.options!.monday2End.toString() != "null"
                                                          ? " - " +
                                                              controller.options!.monday2Start! +
                                                              " & " +
                                                              controller.options!.monday2Start.toString()
                                                          : "") +
                                                      " - " +
                                                      controller.options!.mondayEnd.toString()
                                                  : "Geschlossen",
                                              style: tableText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Dienstags",
                                              style: tableText,
                                            ),
                                            Text(
                                              controller.options!.tuesday == "1"
                                                  ? controller.options!.tuesdayStart.toString() +
                                                      (controller.options!.tuesday2Start.toString() != "null" &&
                                                              controller.options!.tuesday2End.toString() != "null"
                                                          ? " - " +
                                                              controller.options!.tuesday2Start! +
                                                              " & " +
                                                              controller.options!.tuesday2End.toString()
                                                          : "") +
                                                      " - " +
                                                      controller.options!.tuesdayEnd.toString()
                                                  : "Geschlossen",
                                              style: tableText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Mittwochs",
                                              style: tableText,
                                            ),
                                            Text(
                                              controller.options!.wednesday == "1"
                                                  ? controller.options!.wednesdayStart.toString() +
                                                      (controller.options!.wednesday2Start.toString() != "null" &&
                                                              controller.options!.wednesday2End.toString() != "null"
                                                          ? " - " +
                                                              controller.options!.wednesday2Start! +
                                                              " & " +
                                                              controller.options!.wednesday2End.toString()
                                                          : "") +
                                                      " - " +
                                                      controller.options!.wednesdayEnd.toString()
                                                  : "Geschlossen",
                                              style: tableText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Donnertags",
                                              style: tableText,
                                            ),
                                            Text(
                                              controller.options!.thursday == "1"
                                                  ? controller.options!.thursdayStart.toString() +
                                                      (controller.options!.thursday2Start.toString() != "null" &&
                                                              controller.options!.thursday2End.toString() != "null"
                                                          ? " - " +
                                                              controller.options!.thursday2Start! +
                                                              " & " +
                                                              controller.options!.thursday2End.toString()
                                                          : "") +
                                                      " - " +
                                                      controller.options!.thursdayEnd.toString()
                                                  : "Geschlossen",
                                              style: tableText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Freitags",
                                              style: tableText,
                                            ),
                                            Text(
                                              controller.options!.friday == "1"
                                                  ? controller.options!.fridayStart.toString() +
                                                      (controller.options!.friday2Start.toString() != "null" &&
                                                              controller.options!.friday2End.toString() != "null"
                                                          ? " - " +
                                                              controller.options!.friday2Start! +
                                                              " & " +
                                                              controller.options!.friday2End.toString()
                                                          : "") +
                                                      " - " +
                                                      controller.options!.fridayEnd.toString()
                                                  : "Geschlossen",
                                              style: tableText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Samstags",
                                              style: tableText,
                                            ),
                                            Text(
                                              controller.options!.saturday == "1"
                                                  ? controller.options!.saturdayStart.toString() +
                                                      (controller.options!.saturday2Start.toString() != "null" &&
                                                              controller.options!.saturday2End.toString() != "null"
                                                          ? " - " +
                                                              controller.options!.saturday2Start! +
                                                              " & " +
                                                              controller.options!.saturday2End.toString()
                                                          : "") +
                                                      " - " +
                                                      controller.options!.saturdayEnd.toString()
                                                  : "Geschlossen",
                                              style: tableText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Sonntags",
                                              style: tableText,
                                            ),
                                            Text(
                                              controller.options!.sunday == "1"
                                                  ? controller.options!.sundayStart.toString() +
                                                      (controller.options!.sunday2Start.toString() != "null" &&
                                                              controller.options!.sunday2End.toString() != "null"
                                                          ? " - " +
                                                              controller.options!.sunday2Start! +
                                                              " & " +
                                                              controller.options!.sunday2End.toString()
                                                          : "") +
                                                      " - " +
                                                      controller.options!.sundayEnd.toString()
                                                  : "Geschlossen",
                                              style: tableText,
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Feiertage",
                                              style: tableText,
                                            ),
                                            Text(
                                              controller.options!.holiday == "1"
                                                  ? controller.options!.holidayStart.toString() +
                                                      (controller.options!.holiday2Start.toString() != "null" &&
                                                              controller.options!.holiday2End.toString() != "null"
                                                          ? " - " +
                                                              controller.options!.holiday2Start! +
                                                              " & " +
                                                              controller.options!.holiday2End.toString()
                                                          : "") +
                                                      " - " +
                                                      controller.options!.holidayEnd.toString()
                                                  : "Geschlossen",
                                              style: tableText,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  iconTitle(
                                    title: "Liefergebiete",
                                    image: "assets/motor-icon.png",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // Rectangle 150
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(14)), color: MyColors.softWhite),
                                    child: Table(
                                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              controller.box.read('coordinateActive') == "0" ? "PLZ/Ort" : "Entfernung",
                                              style: tableTextBold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              "MWB",
                                              style: tableTextBold,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Text(
                                              "Lieferkosten",
                                              style: tableTextBold,
                                              textAlign: TextAlign.end,
                                            ),
                                          ),
                                        ]),
                                        for (var area in userController.areas)
                                          TableRow(children: [
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                controller.box.read('coordinateActive') == "0"
                                                    ? (area.postal.toString() + "\n" + area.city.toString())
                                                    : area.distance.toString() + " Meter",
                                                style: tableText,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                mformat.format(double.parse(area.minAmount)).toString() + "€",
                                                style: tableText,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: Text(
                                                mformat.format(double.parse(area.deliveryAmount)).toString() + "€",
                                                style: tableText,
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ]),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  iconTitle(
                                    title: "Bezahlmethoden",
                                    image: "assets/credit-card-icon.png",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(14)), color: MyColors.softWhite),
                                    child: Wrap(
                                      spacing: 20,
                                      runSpacing: 10,
                                      children: [
                                        // Rectangle 152
                                        if (controller.options!.cash == "1")
                                          Container(
                                              padding: EdgeInsets.all(6),
                                              child: Image.asset(
                                                "assets/coins.png",
                                                fit: BoxFit.contain,
                                              ),
                                              width: Get.width * 0.16,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.5)))),
                                        if (controller.options!.paypal == "1")
                                          Container(
                                              child: Image.asset(
                                                "assets/paypal.png",
                                                fit: BoxFit.contain,
                                              ),
                                              width: Get.width * 0.16,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.5)))),
                                        if (controller.options!.paypal == "1")
                                          Container(
                                              child: Image.asset(
                                                "assets/giropay.png",
                                                fit: BoxFit.contain,
                                              ),
                                              width: Get.width * 0.16,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.5)))),
                                        if (controller.options!.paypal == "1")
                                          Container(
                                              child: Image.asset(
                                                "assets/visa.png",
                                                fit: BoxFit.contain,
                                              ),
                                              width: Get.width * 0.16,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.5)))),
                                        if (controller.options!.paypal == "1")
                                          Container(
                                              child: Image.asset(
                                                "assets/mastercard.png",
                                                fit: BoxFit.contain,
                                              ),
                                              width: Get.width * 0.16,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.5)))),
                                        if (controller.options!.paypal == "1")
                                          Container(
                                              child: Image.asset(
                                                "assets/amerkanexpres.png",
                                                fit: BoxFit.contain,
                                              ),
                                              width: Get.width * 0.16,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.5)))),
                                        if (controller.options!.klarna == "1")
                                          Container(
                                              child: Image.asset(
                                                "assets/klarna.png",
                                                fit: BoxFit.contain,
                                              ),
                                              width: Get.width * 0.16,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.5)))),
                                        if (controller.options!.onbill == "1")
                                          Container(
                                              child: Image.asset(
                                                "assets/onbill.png",
                                                fit: BoxFit.contain,
                                              ),
                                              width: Get.width * 0.16,
                                              height: 40,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.5)))),
                                        Container(
                                            child: Image.asset(
                                              "assets/payment_13.png",
                                              fit: BoxFit.contain,
                                            ),
                                            width: Get.width * 0.16,
                                            height: 40,
                                            clipBehavior: Clip.antiAlias,
                                            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(4.5)))),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 25),
                                  iconTitle(
                                    title: "Impressum",
                                    image: "assets/shop-icon.png",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(14)), color: MyColors.softWhite),
                                    child: Wrap(
                                      direction: Axis.vertical,
                                      spacing: 10,
                                      children: [
                                        Text(
                                          userController.shopContact!.name!,
                                          style: tableTextBold,
                                        ),
                                        Text(
                                          userController.shopContact!.address!,
                                          style: tableTextBold,
                                        ),
                                        Text(
                                          userController.shopContact!.postal! + " " + userController.shopContact!.city!,
                                          style: tableTextBold,
                                        ),
                                        Text(
                                          "Vertretungsberechtigt: " + userController.shopContact!.owner!,
                                          style: tableTextBold,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.mail_outline,
                                              color: Color(0xffa3a3a3),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              userController.shopContact!.email!,
                                              style: tableTextBold,
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.phone_outlined,
                                              color: Color(0xffa3a3a3),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              userController.shopContact!.telefon!,
                                              style: tableTextBold,
                                            )
                                          ],
                                        ),
                                        Text(
                                          "Finanzamt: " + userController.shopContact!.finanzamt!,
                                          style: tableTextBold,
                                        ), // Rectangle 152
                                        Text(
                                          "Steuernummer: " + userController.shopContact!.steuernummer!,
                                          style: tableTextBold,
                                        ), // Rectangle 152
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ));
                      } else {
                        return Container();
                      }
                    })
                  ],
                ),
              ),
            ),
          )),
        ],
      )),
    );
  }
}

class tabitem extends StatelessWidget {
  final String title;
  final bool isActive;
  const tabitem({
    Key? key,
    this.title = "Bewertungen",
    this.isActive = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 14),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 2.0, color: isActive ? MyColors.watermelon : MyColors.white),
              ),
            ),
            child: Text(title,
                style: TextStyle(
                    color: isActive ? MyColors.watermelon : MyColors.black,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Avenir",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.0)),
          ),
        ],
      ),
    );
  }
}
