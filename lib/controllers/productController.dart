import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_paypal_native/flutter_paypal_native.dart';
import 'package:flutter_paypal_native/models/currency_code.dart';
import 'package:flutter_paypal_native/models/environment.dart';
import 'package:flutter_paypal_native/models/order_callback.dart';
import 'package:flutter_paypal_native/models/user_action.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:zwerge/controllers/userController.dart';
import 'package:zwerge/models/areaModel.dart';
import 'package:zwerge/models/cartModel.dart';
import 'package:zwerge/models/couponModal.dart';
import 'package:zwerge/models/deliveryTimesModel.dart';
import 'package:zwerge/models/faqModel.dart';
import 'package:zwerge/models/optionsModel.dart';
import 'package:zwerge/models/productInfoModel.dart';
import 'package:zwerge/models/productModel.dart';
import 'package:zwerge/models/shopContactModel.dart';
import 'package:zwerge/models/whishlistModel.dart';
import 'package:zwerge/screens/closed.dart';
import 'package:zwerge/screens/home.dart';
import 'package:zwerge/screens/orders.dart';
import 'package:zwerge/screens/searchResult.dart';
import 'package:zwerge/services/remote_services.dart';
import 'package:zwerge/utils/Colors.dart';
import 'package:zwerge/utils/Constants.dart';

class ProductController extends GetxController {
  String addressText = "Addresse eingeben";
  bool closedIsShown = false;
  var products;
  var faq;
  List<DeliveryTimesModel> deliveryTimes = [];
  OptionsModel? options;
  var productKeys;
  var productKeys2;
  var categoryKey = [];
  var categoryHeights = [];
  int currentCategorySlideIndex = -1;
  bool oneTimeTrigger = true;

  List<Product>? search = [];
  late List<Product> searchResult = [];
  late List<WhishlistModel> whishlist;
  late List<Product> whishlistResult = [];
  late List<Product> allPoducts = [];
  var productInfo;
  ShopCotactModel? shopContact;

  PanelController pc = new PanelController();
  PanelController pcAddress = new PanelController();
  PanelController pcDetail = new PanelController();
  PanelController pcAddressDetail = new PanelController();
  TextEditingController? searchTextField;
  TextEditingController? couponTextField;
  bool slideUpVisibilty = true;
  bool slideUpAddressVisibilty = false;
  Product? slideUpProduct;
  CartModel? cartItems;
  int totalItems = 0;
  bool isLoading = false;
  int activeTab = 0;
  Variant? variant;
  var groupvalue;
  var selectedAddressId;
  var addressGroupvalue;
  var selectedTip;
  bool checkboxCoupon = false;
  int step = 0;
  var restourantTabs = 0;
  String selectedDeliveryTime = "current";
  TextEditingController? nameController;
  TextEditingController? emailController;
  TextEditingController? phoneController;
  TextEditingController? addressController;
  TextEditingController? addressHomeNoController;
  TextEditingController? companyController;
  TextEditingController? noteController;
  TextEditingController? couponController;
  int productDetailQuantitiy = 1;
  CouponModal? couponModal;
  bool isCouponApplied = false;
  int selectedPayment = 0;
  late Map<int, bool> isExpanded;
  int activeProductCardNote = 9999;
  bool buttonIsLoading = true;

  final box = GetStorage();

  final kApiUrl = 'http://207.154.227.94:4242';

  final FlutterPaypalNativePlugin = FlutterPaypalNative.instance;
  // log queue
  List<String> logQueue = [];

  Future addToCart(Product? item, Variant? variant, bool haveVariant, {int quantitiy = 1, String options = "-1"}) async {
    print('addToCart');
    try {
      update();
      var result = await RemoteServices.addToCart(item, variant, haveVariant, quantitiy, options);
      print(result);
      Future.delayed(const Duration(milliseconds: 250), () {
        buttonIsLoading = true;
        getCartList();
      });

      //hidePanel();
      slideUpVisibilty = true;
      update();
      return result;
    } finally {
      update();
    }
  }

  addWhishlist(String product_id) async {
    try {
      final box = GetStorage();
      var loginCheck = box.read('userId');
      if (loginCheck != null) {
        var result = await RemoteServices.addToWhishlist(product_id);

        if (result == "1") {
          Get.snackbar('Erfolg', 'Produkt zur Wunschliste hinzugefügt');
          Future.delayed(const Duration(milliseconds: 350), () {
            getWhishlist();
            update();
          });
        } else {}
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
    } catch (e) {
      print(e);
    }
  }

  allProducts(List<ProductModel> product) {
    for (var cats in product) {
      search!.addAll(cats.products);
    }
  }

  String calculatePrice() {
    print('calculatePrice');
    var price, delivery, total, discount;
    UserController userController = Get.put(UserController());

    if (cartItems!.amount == null) {
      return '0';
    }
    price = double.parse(cartItems!.total.replaceAll(",", "."));

    delivery = double.parse(userController.selectedArea != null ? userController.selectedArea!.deliveryAmount : '0');

    total = price + delivery;

    discount = double.parse(cartItems!.discountamount.replaceAll(",", "."));
    // discount = 0;
    total = total - discount;

    return total.toStringAsFixed(2);
  }

  calculateTotalItems() async {
    try {
      totalItems = 0;

      if (cartItems == null) {
        totalItems = 0;
        return;
      }
      cartItems!.products.forEach((element) {
        totalItems += element.quantity;
      });
      update();
    } catch (e) {
      print(e);
    }
  }

  checkout() async {
    UserController userController = Get.find<UserController>();
    try {
      var result = "";
      if (userController.isLogin == false || box.read('coordinateActive') == "1") {
        final name = nameController!.text;
        final email = emailController!.text;
        final phone = phoneController!.text;
        var address = addressController!.text;
        var addressHomeNo = addressHomeNoController != null ? addressHomeNoController!.text : "";
        print(addressHomeNo);
        var company = companyController!.text;
        var note = noteController!.text;

        address = address + " " + addressHomeNo;

        var result = await RemoteServices.checkoutNoLogin(
            name, email, phone, address, company, note, userController.loginInfo, userController.selectedArea, selectedPayment, selectedDeliveryTime);
      } else {
        final note = noteController!.text;

        var result = await RemoteServices.checkout(
            userController.selectedAddress, userController.loginInfo, userController.selectedArea, note, selectedPayment, selectedDeliveryTime);
      }
      nameController!.text = "";
      emailController!.text = "";
      phoneController!.text = "";
      companyController!.text = "";
      noteController!.text = "";
      couponController!.text = '';

      resetAfterCheckout();
      update();
      userController.update();
    } catch (e) {
      print(e);
    }
  }

  void checkoutComplete(orderID) async {
    UserController userController = Get.find<UserController>();
    await checkout();
    showResult("Order successful $orderID");
    Get.defaultDialog(
        title: "",
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        barrierDismissible: false,
        confirmTextColor: Colors.white,
        content: Container(
          width: Get.width,
          child: Column(
            children: [
              Image.asset(
                "assets/orderSuccesful.png",
                width: Get.width / 4,
              ),
              SizedBox(
                height: 20,
              ),
              // Siparişinizi aldık!
              Text(
                "Wir haben Ihre Bestellung erhalten!",
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
                      Get.off(Home());
                    },
                    child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        alignment: Alignment.center,
                        child: // Anasayfa
                            Text("Home",
                                style: const TextStyle(
                                    color: const Color(0xffffffff),
                                    fontWeight: FontWeight.w900,
                                    fontFamily: "Avenir",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 12.0)),
                        height: 40,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(27)), color: MyColors.watermelon)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  if (userController.isLogin == true)
                    GestureDetector(
                      onTap: () {
                        Get.off(Orders());
                      },
                      child: Container(
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          child: // Anasayfa
                              Text("Gehen Sie zu Ihren Bestellungen",
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
    cartItems!.products.forEach((element) async {
      await removeFromCart(element.id);
    });
  }

  bool checkoutControl() {
    UserController userController = Get.find<UserController>();
    if (userController.isLogin == false || box.read('coordinateActive') == "1") {
      if (!controlCheckoutEntries()) {
        return false;
      }
      if (addressText != 'Abholung') {
        // if (addressHomeNoController!.text == '') {
        //   return false;
        // }
      }
    } else {
      if (userController.selectedAddress == null) {
        return false;
      }
    }
    if (cartItems == null) {
      return false;
    }
    if (userController.selectedArea == null) {
      return false;
    }
    bool priceControl =
        double.parse(cartItems!.amount.replaceAll(',', '.')) > double.parse(userController.selectedArea!.minAmount.replaceAll(',', '.'));

    return (cartItems!.products.length > 0 && priceControl);
  }

  clearSession() async {
    await RemoteServices.clearSession();
    update();
  }

  bool controlCheckoutEntries() {
    if (addressText == 'Abholung' && nameController!.text.isNotEmpty && emailController!.text.isNotEmpty && phoneController!.text.isNotEmpty) {
      return true;
    }
    if (nameController!.text.isNotEmpty &&
        emailController!.text.isNotEmpty &&
        phoneController!.text.isNotEmpty &&
        addressController!.text.isNotEmpty) {
      return true;
    }
    return false;
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

  Future<void> discountCheck(String code) async {
    try {
      isLoading = true;
      var result = await RemoteServices.discountCheck(code);
      if (result != null && result != '[]') {
        couponModal = couponModalFromJson(result);
        if (couponModal != null) {
          if (couponModal!.status == 1) {
            customModal(title: "Sie haben " + couponModal!.giftamount.toString() + " € Rabatt erhalten.", status: "success");
            isCouponApplied = true;
          } else {
            customModal(title: "Der Rabattcode ist ungültig.", status: "error");
          }
        } else {
          customModal(title: "Der Rabattcode ist ungültig.", status: "error");
        }
      } else {
        Get.snackbar('Warnung', 'Kein Produkt gefunden');
      }
    } finally {
      isLoading = false;
      getCartList();
    }
  }

  Future<void> discountRemove() async {
    try {
      isLoading = true;
      var result = await RemoteServices.discountRemove();
      if (result != null && result != '[]') {
        isCouponApplied = false;
        couponModal!.giftamount = "0";
      } else {
        Get.snackbar('Warnung', 'Kein Produkt gefunden');
      }
    } finally {
      isLoading = false;
      getCartList();
    }
  }

  dumpSession() async {
    var result = await RemoteServices.dumpSession();
    update();
  }

  editProductNote(String id, String note) async {
    try {
      var result = await RemoteServices.editProductNote(id, note);
      var newResult = jsonDecode(result.toString());

      if (newResult["status"].toString() == "1") {
        activeProductCardNote = 999;
        update();
      } else {
        Get.snackbar('Warnung', 'Etwas ist schief gelaufen');
      }
    } catch (e) {
      print(e);
    }
  }

  getCartList() async {
    print('getCartList');
    calculateTotalItems();

    var list = await RemoteServices.getCartList();
    // print(list);
    if (list != null && list != '[]' && list != '') {
      cartItems = cartModelFromJson(list);
      update();
    } else {
      cartItems = null;
      update();
      Get.snackbar('Warnung', 'Kein Produkt im Warenkorb gefunden');
    }
    try {} catch (e) {
      print(e);
    }
  }

  Future<void> getDeliveryTimes() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getDeliveryTimes();

      if (result != null && result != '[]') {
        deliveryTimes = deliveryTimesModelFromJson(result);

        update();
      } else {
        Get.snackbar('Warnung', 'Kein Produkt gefunden');
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getFaq() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getFaq();

      if (result != null && result != '[]') {
        faq = faqModelFromJson(result);
        update();
      } else {
        Get.snackbar('Warnung', 'Kein Produkt gefunden');
      }
    } finally {
      isLoading = false;
    }
  }

  getItem(int id) {
    return products.singleWhere((element) => element.id == id);
  }

  Future<void> getOptions() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getOptions();
      // result = null;
      if (result != null && result != '[]') {
        options = optionsModelFromJson(result);
        final box = await GetStorage();

        if (options != null) {
          await box.write('primaryColor', options!.primaryColor.toString());
          await box.write('secondaryColor', options!.secondaryColor.toString());
          await box.write('secondaryColorOpacity', options!.secondaryColor.toString() + "1a");
          await box.write('textColor', options!.textColor.toString());
          await box.write('buttonColor', options!.buttonColor.toString());
          await box.write('coordinateActive', options!.coordinateActive.toString());
        } else {
          await box.write('primaryColor', "#F54748");
          await box.write('secondaryColor', "#F54748");
          await box.write('secondaryColorOpacity', "#F547481a");
          await box.write('textColor', "#ffffff");
          await box.write('buttonColor', "#F54748");
        }

        update();
      } else {
        Get.snackbar('Warnung', 'Kein Produkt gefunden');
      }
    } finally {
      isLoading = false;
    }
  }

  Future<void> getProductInfo(int productId) async {
    try {
      isLoading = true;
      final box = GetStorage();
      var result = await RemoteServices.getProductInfo(productId);

      if (result != null && result != '[]' && result != '{"allergens":[],"additives":[]}') {
        productInfo = productInfoModelFromJson(result);
        return productInfo;
      } else {
        productInfo = null;
      }
      update();
      //update();
    } finally {
      isLoading = false;
    }
  }

  Future<void> getProducts() async {
    try {
      isLoading = true;
      final box = GetStorage();
      var result = await RemoteServices.getProducts('1');

      if (result != null && result != '[]') {
        products = productModelFromJson(result);
        allProducts(products);
        for (var i = 0; i < products.length; ++i) {
          box.remove('offset' + i.toString());
        }

        productKeys = [for (var i = 0; i < products.length; ++i) GlobalObjectKey(i)];
        if (productKeys2 == null) {
          productKeys2 = [for (var i = 0; i < products.length; ++i) GlobalObjectKey(i + 1000)];
        }

        update();
      } else {
        Get.snackbar('Warnung', 'Kein Produkt gefunden');
      }
    } finally {
      isLoading = false;
    }
  }

  int getQuantity(int id) {
    print("getQuantity çalıştı id: " + id.toString());
    if (cartItems != null) {
      var index = cartItems!.products.indexWhere((element) => element.id == id);
      if (index != -1) {
        print("product_id" + id.toString());
        print("index" + index.toString());
        print(cartItems!.products[index].quantity.toString());
        return cartItems!.products[index].quantity;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  Future<void> getShopContact() async {
    try {
      isLoading = true;
      var result = await RemoteServices.getShopContact();

      if (result != null && result != '[]') {
        shopContact = shopCotactModelFromJson(result);
      } else {}
      update();
      //update();
    } finally {
      isLoading = false;
    }
  }

  Future<void> getWhishlist() async {
    try {
      //   isLoading = true;

      allPoducts.clear();
      var result = await RemoteServices.getWhishlist();

      if (result != null && result != '[]' && result != '') {
        whishlist = whishlistModelFromJson(result);
        for (var cats in products) {
          allPoducts.addAll(cats.products);
        }
        whishlistResult.clear();
        for (var item in whishlist) {
          var whishlistResult2 = allPoducts.where((i) => i.id == item.productId).toList();

          whishlistResult.addAll(whishlistResult2);
        }
        print(whishlistResult);
        update();
      } else {
        // Get.snackbar('Warnung', 'Kein Produkt gefunden');
      }
    } finally {
      // isLoading = false;
    }
  }

  goToClosed() {
    Future.delayed(Duration(milliseconds: 100), () {
      Get.offAll(Closed());
    });
  }

  hideAddressPanel() {
    slideUpAddressVisibilty = false;
    update();
    Future.delayed(const Duration(milliseconds: 100), () {
      pcAddress.hide();
      slideUpAddressVisibilty = false;
      update();
    });
  }

  hideAddressPanelDetail() {
    slideUpAddressVisibilty = false;
    update();
    Future.delayed(const Duration(milliseconds: 100), () {
      pcAddressDetail.hide();
      slideUpAddressVisibilty = false;
      update();
    });
  }

  hidePanel() {
    slideUpVisibilty = false;
    update();
    Future.delayed(const Duration(milliseconds: 100), () {
      pc.hide();
      slideUpVisibilty = false;
      update();
    });
  }

  hidePanelDetail() {
    slideUpVisibilty = false;
    update();
    Future.delayed(const Duration(milliseconds: 100), () {
      pcDetail.hide();
      slideUpVisibilty = false;
      update();
    });
  }

  bool homeCheckoutControl() {
    UserController userController = Get.find<UserController>();
    if (cartItems == null) {
      return false;
    }
    var cartitemtotal = cartItems!.amount.replaceAll(",", ".");
    var userminamount;
    if (box.read('coordinateActive') != "1") {
      if (userController.selectedArea != null) {
        userminamount = userController.selectedArea!.minAmount.replaceAll(",", ".");
      }
    } else if (userController.selectedArea != null) {
      userminamount = userController.selectedArea!.minAmount.replaceAll(",", ".");
    }
    bool priceControl = (userController.selectedArea != null ? double.parse(cartitemtotal) > double.parse(userminamount) : false);
    return !(userController.selectedArea != null && cartItems!.products.length > 0 && priceControl);
  }

  void initPayPal() async {
    UserController userController = Get.find<UserController>();
    //set debugMode for error logging
    FlutterPaypalNative.isDebugMode = false;
    //initiate payPal plugin
    await FlutterPaypalNativePlugin.init(
      //your app id !!! No Underscore!!! see readme.md for help
      returnUrl: "com.orderio.main://paypalpay",
      //client id from developer dashboard
      clientID: shopContact != null ? shopContact!.paypalClientId.toString() : "",
      //sandbox, staging, live etc
      payPalEnvironment: FPayPalEnvironment.live,

      //what currency do you plan to use? default is US dollars
      currencyCode: FPayPalCurrencyCode.eur,
      //action paynow?
      action: FPayPalUserAction.payNow,
    );

    //call backs for payment
    FlutterPaypalNativePlugin.setPayPalOrderCallback(
      callback: FPayPalOrderCallback(
        onCancel: () {
          //remove all items from queue
          FlutterPaypalNativePlugin.removeAllPurchaseItems();
          //user canceled the payment
          showResult("cancel");
        },
        onSuccess: (data) async {
          //successfully paid
          //remove all items from queue
          FlutterPaypalNativePlugin.removeAllPurchaseItems();
          String orderID = data.orderId ?? " ";
          checkoutComplete(orderID);
        },
        onError: (data) {
          //an error occured
          showResult("error: ${data.reason}");
        },
        onShippingChange: (data) {
          //the user updated the shipping address
          showResult(
            "shipping change: ${data.shippingChangeAddress?.addressLine1 ?? ""}",
          );
        },
      ),
    );
  }

  bool isAlreadyInCart(id) {
    print('isAlreadyInCart id:' + id.toString());
    if (cartItems != null) {
      return cartItems!.products.indexWhere((element) => element.id.toString() == id) > -1;
    } else {
      return false;
    }
  }

  bool isAlreadyInWhishlist(id) {
    if (whishlistResult != null) {
      return whishlistResult.indexWhere((element) => element.id.toString() == id) > -1;
    } else {
      return false;
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    searchTextField?.dispose();
    couponTextField?.dispose();
    nameController?.dispose();
    emailController?.dispose();
    phoneController?.dispose();
    addressController?.dispose();
    companyController?.dispose();
    noteController?.dispose();
    couponController?.dispose();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();

    await getOptions();

    getProducts();
    getCartList();
    getDeliveryTimes();
    await getShopContact();

    Future.delayed(const Duration(milliseconds: 500), () {
      getWhishlist();
      getFaq();
    });

    searchTextField = new TextEditingController();
    couponTextField = new TextEditingController();

    nameController = new TextEditingController();
    emailController = new TextEditingController();
    phoneController = new TextEditingController();
    addressController = new TextEditingController();
    companyController = new TextEditingController();
    noteController = new TextEditingController();
    couponController = new TextEditingController();

    isExpanded = Map();
    isExpanded[0] = false;
    isExpanded[1] = false;
    isExpanded[2] = false;
    isExpanded[3] = false;

    final box = GetStorage();
    OneSignal.shared.setAppId("72f715e1-8b51-43dd-9f52-772d9874ecc0");
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
    if (box.read('email') != null) {
      OneSignal().setEmail(email: box.read('email'));
    }

    initPayPal();
  }

  removeFromCart(int id) async {
    print('removeFromCart id:' + id.toString());
    var index = cartItems!.products.indexWhere((element) => element.id == id);
    if (index != -1) {
      var cart_id = cartItems!.products[index].id;
      await RemoteServices.removeFromCart(cart_id);
      //int index = cartItems!.products.indexWhere((element) => element.cartId == cart_id);
      //cartItems!.products.removeAt(index);
      Future.delayed(const Duration(milliseconds: 300), () {
        getCartList();
        update();
      });
    }
  }

  removeFromWhishlist(String product_id) async {
    try {
      var result = await RemoteServices.removeFromWhishlist(product_id);

      if (result == "1") {
        //  Get.snackbar('Erfolg', 'product removed from wish list');
        Future.delayed(const Duration(milliseconds: 350), () {
          getWhishlist();
          update();
        });
      } else {
        // Get.snackbar('Warnung', 'something went wrong');
      }
    } catch (e) {
      print(e);
    }
  }

  resetAfterCheckout() async {
    try {
      isCouponApplied = false;
      await discountRemove();
      update();
    } catch (e) {
      print(e);
    }
  }

  searchProducts() {
    searchResult = search!.where((i) => i.name!.toLowerCase().contains(searchTextField!.text.toLowerCase())).toList();
    update();
    Get.to(SearchResults());
    update();
  }

  void setActiveTab(int tab) {
    activeTab = tab;
    print(activeTab);
    update();
  }

  Future<void> setGelAl() async {
    UserController userController = Get.find<UserController>();
    final box = GetStorage();

    try {
      isLoading = true;
      var result = await RemoteServices.setGelAl();

      if (result != null && result != '[]') {
        userController.selectedArea =
            new AreaModel(id: '10', shopId: shopID.toString(), postal: '', city: '', minAmount: '1', deliveryAmount: '0', distance: '0');
        userController.update();
        update();
      } else {
        // Get.snackbar('Warnung', 'Kein Produkt gefunden');
      }
    } finally {
      isLoading = false;
    }
  }

  showAddressPanel() {
    pcAddress.show();
    Future.delayed(const Duration(milliseconds: 100), () {
      pcAddress.animatePanelToPosition(1);
    });

    slideUpAddressVisibilty = true;
    update();
  }

  showAddressPanelDetail() {
    pcAddressDetail.show();
    Future.delayed(const Duration(milliseconds: 100), () {
      pcAddressDetail.animatePanelToPosition(1);
    });

    slideUpAddressVisibilty = true;
    update();
  }

  showPanel(product) {
    slideUpProduct = product;
    variant = null;
    pc.show();
    Future.delayed(const Duration(milliseconds: 100), () {
      pc.animatePanelToPosition(1);
    });

    slideUpVisibilty = true;
    update();
  }

  showPanelDetail(product) {
    slideUpProduct = product;
    variant = null;
    pcDetail.show();
    Future.delayed(const Duration(milliseconds: 100), () {
      pcDetail.animatePanelToPosition(1);
    });

    slideUpVisibilty = true;
    update();
  }

  showResult(String text) {
    logQueue.add(text);
    print(logQueue);
    update();
  }

  Future updateCart(int id, int quantity) async {
    print('updateCart id:' + id.toString() + ' quantity:' + quantity.toString());
    try {
      update();
      if (cartItems != null) {
        // var index = cartItems!.products.indexWhere((element) => element.id == id);
        // if (index != -1) {
        // int cart_id = cartItems!.products[index].cartId;

        var result = await RemoteServices.updateCart(id, quantity);

        Future.delayed(const Duration(milliseconds: 500), () {
          buttonIsLoading = true;
          getCartList();
        });

        return result;
        // }
      }
    } finally {
      update();
    }
  }

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    final url = Uri.parse('$kApiUrl/payment-sheet');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'a': 'a',
      }),
    );
    final body = json.decode(response.body);
    if (body['error'] != null) {
      throw Exception(body['error']);
    }
    return body;
  }
}
