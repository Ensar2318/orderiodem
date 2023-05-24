import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:zwerge/controllers/productController.dart';
import 'package:zwerge/screens/orders.dart';
import 'package:zwerge/utils/Colors.dart';

class basketItems extends StatelessWidget {
  final data;
  const basketItems({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    width: Get.width * 0.35,
                    child: data.image != null
                        ? CachedNetworkImage(
                            width: Get.width * 0.3,
                            imageUrl: 'https://cdn.orderio.de/images/products/' + data.image!.toString(),
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) {
                              return Image.network('https://cdn.orderio.de/images/products/placeholder.jpg');
                            },
                            fit: BoxFit.contain,
                          )
                        : CachedNetworkImage(
                            width: Get.width * 0.3,
                            imageUrl: 'https://cdn.orderio.de/images/products/placeholder.jpg',
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) {
                              return Image.network('https://cdn.orderio.de/images/products/placeholder.jpg');
                            },
                            fit: BoxFit.contain,
                          )),
                Expanded(
                    child: Wrap(
                  spacing: 5,
                  direction: Axis.vertical,
                  children: [
                    // Special Hamburger
                    Container(
                      width: Get.width * 0.54,
                      child: Text(
                        data.name.toString(),
                        style: const TextStyle(
                            color: MyColors.charcoal, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 15.0),
                      ),
                    ),

                    // Burgerking
                    Text(data.extraSelection ?? "",
                        style: const TextStyle(
                            color: const Color(0xffc1c1c1),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Avenir",
                            fontStyle: FontStyle.normal,
                            fontSize: 11.0)),
                    // 9.54
                    Text("\€ " + data.price.toString(),
                        style: const TextStyle(
                            color: const Color(0xff22292b),
                            fontWeight: FontWeight.w900,
                            fontFamily: "Avenir",
                            fontStyle: FontStyle.normal,
                            fontSize: 22.0))
                  ],
                ))
              ],
            ),
            Positioned(
                bottom: 12,
                right: 12,
                child: // Group 828
                    Text(data.quantity.toString(),
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 17.0),
                        textAlign: TextAlign.left))
          ],
        ),
        height: 115,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(23)),
            boxShadow: [BoxShadow(color: const Color(0x89cecece), offset: Offset(0, 1), blurRadius: 6, spreadRadius: 0)],
            gradient: LinearGradient(
                begin: Alignment(0.08409727364778519, 0.43446260690689087),
                end: Alignment(0.46691903471946716, 0.45219510793685913),
                colors: [const Color(0xffffffff), const Color(0xffffffff)])));
  }
}

class OrderDetail extends GetView<ProductController> {
  final data;
  const OrderDetail({Key? key, this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    int status = int.parse(data.status);

    String orderText = "";
    if (status == 0) {
      orderText = "Wartet auf Aktion";
    } else if (status == 1) {
      orderText = "Vorbestellung";
    } else if (status == 2) {
      orderText = "Wird zubereitet";
    } else if (status == 3) {
      orderText = "Unterwegs";
    } else if (status == 4) {
      orderText = "Abgeschlossen";
    } else if (status == 5) {
      orderText = "Storniert";
    }
    double totalAmount = 0;

    final moneyformat = new NumberFormat("#,##0.00", "en_US");
    int softAmount = 0;
    data.amount.split(",");
    String deliveryAmountS = data.deliveryAmount.replaceAll(",", "").replaceAll(".", "");
    String amountS = data.amount.replaceAll(",", "").replaceAll(".", "");
    deliveryAmountS = deliveryAmountS.substring(0, deliveryAmountS.length - 2);
    amountS = amountS.substring(0, amountS.length - 2);
    totalAmount = double.parse(amountS) + double.parse(deliveryAmountS);

    String totalAmountS = moneyformat.format(totalAmount);
    // explode data

    return SafeArea(
      child: Scaffold(
        body: WillPopScope(
          onWillPop: () async {
            Get.to(Orders());
            return false;
          },
          child: data == null
              ? Container()
              : Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        height: 90,
                        color: primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => Get.to(Orders()),
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
                              "Sendungsverfolgung",
                              style: const TextStyle(
                                  color: const Color(0xffffffff),
                                  fontWeight: FontWeight.w900,
                                  fontFamily: "Avenir",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18.0),
                            ),
                            Opacity(
                              opacity: 0,
                              child: Icon(
                                Icons.message,
                                size: 33,
                                color: MyColors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            //  Sipariş Durumu
                                            Text("Bestellstatus",
                                                style: const TextStyle(
                                                    color: const Color(0xff919191),
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.0),
                                                textAlign: TextAlign.left),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            // Rectangle 67
                                            Container(
                                                height: 50,
                                                alignment: Alignment.center,
                                                child: // Paketiniz Hazırlanıyor
                                                    Text(
                                                  orderText,
                                                  style: const TextStyle(
                                                      color: const Color(0xff6eab8e),
                                                      fontWeight: FontWeight.w900,
                                                      fontFamily: "Avenir",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 13.0),
                                                ),
                                                decoration:
                                                    BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9)), color: const Color(0xffeef4f2)))
                                          ],
                                        )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.stretch,
                                          children: [
                                            //  Sipariş Durumu
                                            Text("Auftragsdatum",
                                                style: const TextStyle(
                                                    color: const Color(0xff919191),
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.0),
                                                textAlign: TextAlign.left),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            // Rectangle 67
                                            Container(
                                                height: 50,
                                                alignment: Alignment.center,
                                                child: // Paketiniz Hazırlanıyor
                                                    Text(
                                                  data.created.toString(),
                                                  style: const TextStyle(
                                                      color: const Color(0xff969696),
                                                      fontWeight: FontWeight.w900,
                                                      fontFamily: "Avenir",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 13.0),
                                                ),
                                                decoration:
                                                    BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9)), color: const Color(0xfff4f4f4)))
                                          ],
                                        )),
                                      ],
                                    ),
                                  ),
                                  // Path 3209
                                  Container(
                                      width: Get.width, decoration: BoxDecoration(border: Border.all(color: const Color(0xfff4f4f4), width: 1))),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  // Teslimat Adresi
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 20),
                                    child: Text("Lieferadresse",
                                        style: const TextStyle(
                                            color: MyColors.charcoal,
                                            fontWeight: FontWeight.w900,
                                            fontFamily: "Avenir",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18.0)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: primaryColor,
                                          size: 40,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Container(
                                          width: Get.width * 0.7,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: [
                                              // 22 Tem 2020 19:16
                                              Text("Bestellnummer #" + data.transactionId.toString(),
                                                  style: const TextStyle(
                                                      color: const Color(0xffc7c7c7),
                                                      fontWeight: FontWeight.w900,
                                                      fontFamily: "Avenir",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 14.0)),
                                              SizedBox(
                                                height: 4,
                                              ),
                                              // Ev: Laleli Sk. Selamet Sultan Avni Mahallesi
                                              Text(data.address.toString(),
                                                  style: const TextStyle(
                                                      color: MyColors.charcoal,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "Avenir-Roman",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 15.0))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(border: Border.symmetric(horizontal: BorderSide(color: MyColors.softGrey, width: 1))),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  orderStatus(
                                      title: "Genehmigt",
                                      status: status == 0
                                          ? 1
                                          : status > 0 && status != 5
                                              ? 2
                                              : 0),
                                  orderStatus(
                                      title: "Wird \n zubereitet",
                                      status: status == 1
                                          ? 1
                                          : status > 1 && status != 5
                                              ? 2
                                              : 0),
                                  orderStatus(
                                      title: "Unterwegs",
                                      status: status == 2
                                          ? 1
                                          : status > 2 && status != 5
                                              ? 2
                                              : 0),
                                  orderStatus(
                                      title: "Abgeschlossen",
                                      status: status == 3
                                          ? 1
                                          : status > 3 && status != 5
                                              ? 2
                                              : 0),
                                  orderStatus(title: "Storniert", status: status == 5 ? 2 : 0, last: true),
                                ],
                              ),
                            )
                            // Sepetinizdeki Ürünler
                            ,
                            if (false)
                              Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.store, color: MyColors.white),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      // Satıcıyı Değerlendir
                                      Text("Verkäufer bewerten",
                                          style: const TextStyle(
                                              color: const Color(0xffffffff),
                                              fontWeight: FontWeight.w900,
                                              fontFamily: "Avenir",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.0))
                                    ],
                                  ),
                                  height: 40,
                                  margin: EdgeInsets.only(left: 40, right: 40, top: 20),
                                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(11)), color: primaryColor)),
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20, left: 5),
                                    child: Text(
                                      "Produkte in Ihrem Warenkorb",
                                      style: const TextStyle(
                                          color: MyColors.charcoal,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "Avenir",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18.0),
                                    ),
                                  ),
                                  for (var product in data.products)
                                    basketItems(
                                      data: product,
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Bezahlverfahren",
                                      style: const TextStyle(
                                          color: MyColors.charcoal,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "Avenir",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18.0)),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 20),
                                      padding: EdgeInsets.all(20),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              // Ender Yıldırım
                                              Text(data.name.toString(),
                                                  style: const TextStyle(
                                                      color: MyColors.charcoal,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Avenir",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 14.0)),
                                              // 89543543***********10
                                              Text("Bestellnummer #" + data.transactionId.toString(),
                                                  style: const TextStyle(
                                                      color: const Color(0xff9d9d9d),
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Avenir",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 14.0),
                                                  textAlign: TextAlign.left)
                                            ],
                                          ),
                                          if (data.paymentMethod == "1")
                                            Icon(
                                              Icons.paypal,
                                              color: primaryColor,
                                              size: 35,
                                            ),
                                          if (data.paymentMethod == "0")
                                            Icon(
                                              Icons.payments_outlined,
                                              color: primaryColor,
                                              size: 35,
                                            )
                                        ],
                                      ),
                                      height: 94,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(23)),
                                          boxShadow: [
                                            BoxShadow(color: const Color(0x89cecece), offset: Offset(0, 1), blurRadius: 6, spreadRadius: 0)
                                          ],
                                          gradient: LinearGradient(
                                              begin: Alignment(0.08409727364778519, 0.43446260690689087),
                                              end: Alignment(0.46691903471946716, 0.45219510793685913),
                                              colors: [const Color(0xffffffff), const Color(0xffffffff)]))),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text("Zahlungsdetails",
                                      style: const TextStyle(
                                          color: MyColors.charcoal,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: "Avenir",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18.0)),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            // Sepet Tutarı
                                            Text("Korbbetrag",
                                                style: const TextStyle(
                                                    color: MyColors.charcoal,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.0)),
                                            Spacer(),
                                            // €

                                            // 52,20
                                            Text(data.amount.toString(),
                                                style: const TextStyle(
                                                    color: const Color(0xff22292b),
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.right),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("€",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16.0)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            // Sepet Tutarı
                                            Text("Ladung",
                                                style: const TextStyle(
                                                    color: MyColors.charcoal,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.0)),
                                            Spacer(),
                                            // €

                                            // 52,20
                                            Text(data.deliveryAmount.toString(),
                                                style: const TextStyle(
                                                    color: const Color(0xff22292b),
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16.0),
                                                textAlign: TextAlign.right),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("€",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 16.0)),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          margin: EdgeInsets.symmetric(vertical: 10),
                                          height: 1,
                                          color: Color(0xfff4f4f4),
                                        ),
                                        Row(
                                          children: [
                                            // Sepet Tutarı
                                            Text("Gesamtpreis",
                                                style: TextStyle(
                                                    color: MyColors.charcoal,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 14.0)),
                                            Spacer(),
                                            // €

                                            // 32.96
                                            Text(totalAmountS,
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w900,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 20.0)),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Text("€",
                                                style: TextStyle(
                                                    color: primaryColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "Avenir",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 20.0)),
                                            // 52,20
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                            // Ödeme Yöntemi
                          ],
                        ),
                      ))
                    ],
                  )),
        ),
      ),
    );
  }
}

class orderStatus extends StatelessWidget {
  final String title;
  final int status;
  final bool last;
  const orderStatus({
    Key? key,
    required this.title,
    required this.status,
    this.last = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    Color primaryColor = HexColor.fromHex(box.read('primaryColor'));
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          children: [
            // Onaylandı
            Container(
              height: 30,
              alignment: Alignment.center,
              child: Text(title,
                  style: const TextStyle(
                      color: MyColors.charcoal, fontWeight: FontWeight.w900, fontFamily: "Avenir", fontStyle: FontStyle.normal, fontSize: 10.0),
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              height: 20,
            ),
            if (status == 0)
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: MyColors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                decoration: BoxDecoration(
                  color: Color(0xffd4d4d4),
                  borderRadius: BorderRadius.circular(26),
                ),
              )
            else if (status == 1)
              Container(
                width: 26,
                height: 26,
                padding: EdgeInsets.all(5),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(MyColors.white),
                ),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(26),
                ),
              )
            else if (status == 2)
              Container(
                width: 26,
                height: 26,
                child: Icon(
                  Icons.check,
                  size: 20,
                  color: MyColors.white,
                ),
                decoration: BoxDecoration(
                  color: Color(0xff21d376),
                  borderRadius: BorderRadius.circular(26),
                ),
              )
          ],
        ),
        if (!last)
          if (status == 0)
            Container(
              color: Color(0xffd3d3d3),
              width: Get.width * 0.05,
              height: 2,
              margin: EdgeInsets.only(bottom: 17),
            )
          else if (status == 1)
            Container(
              color: Color(0xffd3d3d3),
              width: Get.width * 0.05,
              height: 2,
              margin: EdgeInsets.only(bottom: 17),
            )
          else if (status == 2)
            Container(
              color: Color(0xff21d376),
              width: Get.width * 0.05,
              height: 2,
              margin: EdgeInsets.only(bottom: 17),
            )
      ],
    );
  }
}
