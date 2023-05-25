import 'dart:core';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:zwerge/screens/Services.dart';

class Payment extends StatefulWidget {
  final Function onFinish;
  final tutar;
  final String araToplam;
  final String getirmeucreti;
  final String adsoyad;
  final String adresCity;
  final String phone;

  Payment(
      {required this.onFinish,
      required this.tutar,
      required this.araToplam,
      required this.getirmeucreti,
      required this.adsoyad,
      required this.adresCity,
      required this.phone});

  @override
  State<StatefulWidget> createState() {
    return PaymentState();
  }
}

class PaymentState extends State<Payment> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? checkoutUrl;
  String? executeUrl;
  String? accessToken;
  Services services = Services();

  // you can change default currency according to your need
  Map<dynamic, dynamic> defaultCurrency = {"symbol": "EUR ", "decimalDigits": 2, "symbolBeforeTheNumber": true, "currency": "EUR"};

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  // item name, price and quantity
  String itemName = '';

  String itemPrice = "";
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    print(checkoutUrl);

    if (checkoutUrl != null) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: GestureDetector(
            child: Icon(Icons.arrow_back_ios),
            onTap: () => Navigator.pop(context),
          ),
        ),
        body: WebView(
          initialUrl: checkoutUrl,
          javascriptMode: JavascriptMode.unrestricted,
          navigationDelegate: (NavigationRequest request) {
            if (request.url.contains(returnURL)) {
              final uri = Uri.parse(request.url);
              final payerID = uri.queryParameters['PayerID'];
              if (payerID != null) {
                services.executePayment(executeUrl, payerID, accessToken).then((id) {
                  widget.onFinish(id);
                  Navigator.of(context).pop();
                });
              } else {
                Navigator.of(context).pop();
              }
              Navigator.of(context).pop();
            }
            if (request.url.contains(cancelURL)) {
              Navigator.of(context).pop();
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    } else {
      return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          backgroundColor: Colors.black12,
          elevation: 0.0,
        ),
        body: Center(child: Container(child: CircularProgressIndicator())),
      );
    }
  }

  Map<String, dynamic> getOrderParams(String toplam, String getirmeucreti, String adsoyad, String adresCity, String phone) {
    List items = [
      {"name": itemName, "quantity": quantity, "price": itemPrice, "currency": defaultCurrency["currency"]}
    ];

    // checkout invoice details
    String totalAmount = toplam;
    String subTotalAmount = toplam;
    String shippingCost = '0';
    int shippingDiscountCost = 0;
    String userFirstName = adsoyad;
    String userLastName = '';
    String addressCity = adresCity;
    String addressStreet = "";
    String addressZipCode = '';
    String addressCountry = '';
    String addressState = '';
    String addressPhoneNumber = phone;

    Map<String, dynamic> temp = {
      "intent": "sale",
      "payer": {"payment_method": "paypal"},
      "transactions": [
        {
          "amount": {
            "total": totalAmount,
            "currency": defaultCurrency["currency"],
            "details": {"subtotal": subTotalAmount, "shipping": shippingCost, "shipping_discount": ((-1.0) * shippingDiscountCost).toString()}
          },
          "description": "The payment transaction description.",
          "payment_options": {"allowed_payment_method": "INSTANT_FUNDING_SOURCE"},
          "item_list": {
            "items": items,
            if (isEnableShipping && isEnableAddress)
              "shipping_address": {
                "recipient_name": userFirstName + " " + userLastName,
                "line1": addressStreet,
                "line2": "",
                "city": addressCity,
                "country_code": addressCountry,
                "postal_code": addressZipCode,
                "phone": addressPhoneNumber,
                "state": addressState
              },
          }
        }
      ],
      "note_to_payer": "Contact us for any questions on your order.",
      "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
    };
    return temp;
  }

  @override
  void initState() {
    super.initState();
    itemPrice = widget.tutar.toString();
    Future.delayed(Duration.zero, () async {
      try {
        accessToken = await services.getAccessToken();

        final transactions = getOrderParams(
          widget.tutar.toString(),
          widget.getirmeucreti.toString(),
          widget.adsoyad.toString(),
          widget.adresCity.toString(),
          widget.phone.toString(),
        );
        final res = await services.createPaypalPayment(transactions, accessToken);
        setState(() {
          checkoutUrl = res["approvalUrl"]!;
          executeUrl = res["executeUrl"]!;
        });
      } catch (e) {
        print('exception: ' + e.toString());
        /* final snackBar = SnackBar(
          content: Text(e.toString()),
          duration: Duration(seconds: 10),
          action: SnackBarAction(
            label: 'Close',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        _scaffoldKey.currentState.showSnackBar(snackBar);*/
      }
    });
  }
}
